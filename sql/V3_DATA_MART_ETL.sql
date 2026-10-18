-- ==================================================================================
-- PROYECTO: CAFETERÍA AURORA
-- SCRIPT: V3_DATA_MART_ETL.sql
-- DESCRIPCIÓN: 
--   1. Creación del Data Mart / Almacén de Datos (Cafeteria_DM).
--   2. Implementación física del Modelo Estrella (5 Dimensiones + 1 Fact Table).
--   3. Procedimiento ETL para extracción de BD_Cafeteria (OLTP), transformación
--      y carga en Cafeteria_DM (OLAP/BI).
-- AUTOR: Equipo de Base de Datos y Big Data
-- FECHA: Octubre 2026
-- ==================================================================================

-- ==================================================================================
-- PASO 1: CREACIÓN DE LA BASE DE DATOS DIMENSIONAL (DATA MART)
-- ==================================================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Cafeteria_DM')
BEGIN
    CREATE DATABASE Cafeteria_DM;
END
GO

USE Cafeteria_DM;
GO

-- ==================================================================================
-- PASO 2: CREACIÓN DE TABLAS DE DIMENSIONES (5 Dimensiones)
-- ==================================================================================

-- 1. Dimensión Producto
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dim_Producto')
BEGIN
    CREATE TABLE dbo.Dim_Producto (
        id_producto_sk INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Dim_Producto PRIMARY KEY CLUSTERED,
        id_producto_bk INT NOT NULL, -- Clave del negocio (origen OLTP)
        nombre_producto VARCHAR(100) NOT NULL,
        categoria VARCHAR(80) NOT NULL,
        precio_unitario DECIMAL(10,2) NOT NULL
    );
END
GO

-- 2. Dimensión Tiempo
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dim_Tiempo')
BEGIN
    CREATE TABLE dbo.Dim_Tiempo (
        id_tiempo_sk INT NOT NULL CONSTRAINT PK_Dim_Tiempo PRIMARY KEY CLUSTERED, -- Formato YYYYMMDD
        fecha DATE NOT NULL,
        anio INT NOT NULL,
        mes INT NOT NULL,
        nombre_mes VARCHAR(20) NOT NULL,
        dia INT NOT NULL,
        dia_semana VARCHAR(20) NOT NULL
    );
END
GO

-- 3. Dimensión Empleado
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dim_Empleado')
BEGIN
    CREATE TABLE dbo.Dim_Empleado (
        id_empleado_sk INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Dim_Empleado PRIMARY KEY CLUSTERED,
        id_empleado_bk INT NOT NULL,
        nombre_completo VARCHAR(160) NOT NULL,
        cargo VARCHAR(60) NOT NULL,
        turno VARCHAR(30) NOT NULL
    );
END
GO

-- 4. Dimensión Cliente
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dim_Cliente')
BEGIN
    CREATE TABLE dbo.Dim_Cliente (
        id_cliente_sk INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Dim_Cliente PRIMARY KEY CLUSTERED,
        id_cliente_bk INT NOT NULL,
        nombre_completo VARCHAR(160) NOT NULL,
        telefono VARCHAR(20) NULL
    );
END
GO

-- 5. Dimensión Método de Pago
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dim_MetodoPago')
BEGIN
    CREATE TABLE dbo.Dim_MetodoPago (
        id_metodo_pago_sk INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Dim_MetodoPago PRIMARY KEY CLUSTERED,
        metodo_pago VARCHAR(40) NOT NULL
    );
END
GO

-- ==================================================================================
-- PASO 3: CREACIÓN DE LA TABLA DE HECHOS (Fact_Ventas con 2 medidas cuantitativas)
-- ==================================================================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Fact_Ventas')
BEGIN
    CREATE TABLE dbo.Fact_Ventas (
        id_venta_sk INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Fact_Ventas PRIMARY KEY CLUSTERED,
        id_tiempo_sk INT NOT NULL CONSTRAINT FK_Fact_Tiempo FOREIGN KEY REFERENCES dbo.Dim_Tiempo(id_tiempo_sk),
        id_producto_sk INT NOT NULL CONSTRAINT FK_Fact_Producto FOREIGN KEY REFERENCES dbo.Dim_Producto(id_producto_sk),
        id_empleado_sk INT NOT NULL CONSTRAINT FK_Fact_Empleado FOREIGN KEY REFERENCES dbo.Dim_Empleado(id_empleado_sk),
        id_cliente_sk INT NOT NULL CONSTRAINT FK_Fact_Cliente FOREIGN KEY REFERENCES dbo.Dim_Cliente(id_cliente_sk),
        id_metodo_pago_sk INT NOT NULL CONSTRAINT FK_Fact_MetodoPago FOREIGN KEY REFERENCES dbo.Dim_MetodoPago(id_metodo_pago_sk),
        id_pedido_original INT NOT NULL,
        -- Medidas Cuantitativas:
        cantidad INT NOT NULL,
        monto_total DECIMAL(10,2) NOT NULL
    );
END
GO

-- ==================================================================================
-- PASO 4: PROCEDIMIENTO ALMACENADO PARA EL PROCESO ETL
-- ==================================================================================
CREATE OR ALTER PROCEDURE dbo.SP_EJECUTAR_ETL_VENTAS
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Limpiar datos antiguos para carga limpia
        DELETE FROM dbo.Fact_Ventas;
        DELETE FROM dbo.Dim_Producto;
        DBCC CHECKIDENT ('dbo.Dim_Producto', RESEED, 0);
        DELETE FROM dbo.Dim_Empleado;
        DBCC CHECKIDENT ('dbo.Dim_Empleado', RESEED, 0);
        DELETE FROM dbo.Dim_Cliente;
        DBCC CHECKIDENT ('dbo.Dim_Cliente', RESEED, 0);
        DELETE FROM dbo.Dim_MetodoPago;
        DBCC CHECKIDENT ('dbo.Dim_MetodoPago', RESEED, 0);
        DELETE FROM dbo.Dim_Tiempo;

        -- 1. ETL Dim_Producto (Desnormalización de Producto con Categoría)
        INSERT INTO dbo.Dim_Producto (id_producto_bk, nombre_producto, categoria, precio_unitario)
        SELECT 
            p.id_producto,
            p.nombre_producto,
            c.nombre_categoria,
            p.precio
        FROM BD_Cafeteria.dbo.PRODUCTO p
        INNER JOIN BD_Cafeteria.dbo.CATEGORIA c ON p.id_categoria = c.id_categoria;

        -- 2. ETL Dim_Empleado (Concatenación de nombres y apellidos)
        INSERT INTO dbo.Dim_Empleado (id_empleado_bk, nombre_completo, cargo, turno)
        SELECT 
            id_empleado,
            nombres + ' ' + apellidos,
            cargo,
            turno
        FROM BD_Cafeteria.dbo.EMPLEADO;

        -- 3. ETL Dim_Cliente (Manejo de nulos y estandarización)
        INSERT INTO dbo.Dim_Cliente (id_cliente_bk, nombre_completo, telefono)
        SELECT 
            id_cliente,
            nombres + ' ' + apellidos,
            ISNULL(telefono, 'Sin teléfono')
        FROM BD_Cafeteria.dbo.CLIENTE;

        -- 4. ETL Dim_MetodoPago (Extracción de catálogo único de pagos)
        INSERT INTO dbo.Dim_MetodoPago (metodo_pago)
        SELECT DISTINCT metodo_pago 
        FROM BD_Cafeteria.dbo.PEDIDO;

        -- 5. ETL Dim_Tiempo (Desglose de fechas en atributos analíticos)
        INSERT INTO dbo.Dim_Tiempo (id_tiempo_sk, fecha, anio, mes, nombre_mes, dia, dia_semana)
        SELECT DISTINCT
            CAST(CONVERT(VARCHAR(8), fecha_pedido, 112) AS INT) AS id_tiempo_sk,
            fecha_pedido,
            YEAR(fecha_pedido),
            MONTH(fecha_pedido),
            DATENAME(MONTH, fecha_pedido),
            DAY(fecha_pedido),
            DATENAME(WEEKDAY, fecha_pedido)
        FROM BD_Cafeteria.dbo.PEDIDO;

        -- 6. ETL Fact_Ventas (Cruce dimensional y carga de métricas)
        INSERT INTO dbo.Fact_Ventas (
            id_tiempo_sk,
            id_producto_sk,
            id_empleado_sk,
            id_cliente_sk,
            id_metodo_pago_sk,
            id_pedido_original,
            cantidad,
            monto_total
        )
        SELECT 
            t.id_tiempo_sk,
            dp.id_producto_sk,
            de.id_empleado_sk,
            dc.id_cliente_sk,
            dm.id_metodo_pago_sk,
            p.id_pedido,
            det.cantidad,
            det.subtotal
        FROM BD_Cafeteria.dbo.DETALLE_PEDIDO det
        INNER JOIN BD_Cafeteria.dbo.PEDIDO p ON det.id_pedido = p.id_pedido
        INNER JOIN dbo.Dim_Producto dp ON det.id_producto = dp.id_producto_bk
        INNER JOIN dbo.Dim_Empleado de ON p.id_empleado = de.id_empleado_bk
        INNER JOIN dbo.Dim_Cliente dc ON p.id_cliente = dc.id_cliente_bk
        INNER JOIN dbo.Dim_MetodoPago dm ON p.metodo_pago = dm.metodo_pago
        INNER JOIN dbo.Dim_Tiempo t ON p.fecha_pedido = t.fecha;

        COMMIT TRANSACTION;
        PRINT 'Proceso ETL completado exitosamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
