-- ==================================================================================
-- PROYECTO: CAFETERIA AURORA - DATA MART & PROCESO ETL EN AZURE SQL SERVER
-- BASE DE DATOS: Cafeteria_DM (Conectada a BD_Cafeteria via Azure Elastic Query)
-- OBJETIVO: Implementacion fisica del Modelo Dimensional Estrella y Carga ETL
-- AUTOR: Equipo de Base de Datos Avanzadas y Big Data
-- ==================================================================================
-- NOTA TECNICA: 
-- Azure SQL Database es un servicio PaaS donde las consultas directas entre bases de datos
-- con sintaxis de tres partes (ej. BD_Cafeteria.dbo.CLIENTE) no son permitidas (Error 40515).
-- La solucion arquitectonica oficial es Azure Elastic Query (Tablas Externas sobre RDBMS),
-- permitiendo que Cafeteria_DM consulte en tiempo real las tablas operacionales de BD_Cafeteria.
-- ==================================================================================

USE Cafeteria_DM
GO

-- ==================================================================================
-- PASO 1: SEGURIDAD Y CONFIGURACION DE ORIGEN DE DATOS EXTERNO (ELASTIC QUERY)
-- ==================================================================================

-- 1.1 Master Key de cifrado
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name LIKE '%DatabaseMasterKey%')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'AuroraMasterKey#2026'
END
GO

-- 1.2 Credencial de base de datos para autenticacion en BD_Cafeteria
IF NOT EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'Cred_Azure_Admin')
BEGIN
    CREATE DATABASE SCOPED CREDENTIAL [Cred_Azure_Admin]
    WITH IDENTITY = 'admincafeteria',
    SECRET = 'AuroraCafe#2026Sql'
END
GO

-- 1.3 Origen de datos externo apuntando a BD_Cafeteria en el mismo servidor Azure
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'Src_BD_Cafeteria')
BEGIN
    CREATE EXTERNAL DATA SOURCE [Src_BD_Cafeteria]
    WITH (
        TYPE = RDBMS,
        LOCATION = N'cafeteria-aurora-norma3.database.windows.net',
        DATABASE_NAME = N'BD_Cafeteria',
        CREDENTIAL = [Cred_Azure_Admin]
    )
END
GO

-- ==================================================================================
-- PASO 2: TABLAS EXTERNAS VINCULADAS A BD_Cafeteria (CAPA DE EXTRACCION)
-- ==================================================================================

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_DETALLE_PEDIDO')
    DROP EXTERNAL TABLE dbo.ext_DETALLE_PEDIDO
GO

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_PEDIDO')
    DROP EXTERNAL TABLE dbo.ext_PEDIDO
GO

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_PRODUCTO')
    DROP EXTERNAL TABLE dbo.ext_PRODUCTO
GO

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_CATEGORIA')
    DROP EXTERNAL TABLE dbo.ext_CATEGORIA
GO

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_EMPLEADO')
    DROP EXTERNAL TABLE dbo.ext_EMPLEADO
GO

IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ext_CLIENTE')
    DROP EXTERNAL TABLE dbo.ext_CLIENTE
GO

CREATE EXTERNAL TABLE dbo.ext_CLIENTE (
    id_cliente INT NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    telefono VARCHAR(20) NULL,
    correo VARCHAR(100) NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'CLIENTE'
)
GO

CREATE EXTERNAL TABLE dbo.ext_EMPLEADO (
    id_empleado INT NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    dni VARCHAR(8) NOT NULL,
    cargo VARCHAR(60) NOT NULL,
    tipo_contrato VARCHAR(20) NOT NULL,
    sueldo DECIMAL(10,2) NOT NULL,
    turno VARCHAR(30) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    estado VARCHAR(20) NOT NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'EMPLEADO'
)
GO

CREATE EXTERNAL TABLE dbo.ext_CATEGORIA (
    id_categoria INT NOT NULL,
    nombre_categoria VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200) NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'CATEGORIA'
)
GO

CREATE EXTERNAL TABLE dbo.ext_PRODUCTO (
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200) NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    id_proveedor INT NULL,
    estado VARCHAR(20) NOT NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'PRODUCTO'
)
GO

CREATE EXTERNAL TABLE dbo.ext_PEDIDO (
    id_pedido INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(40) NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'PEDIDO'
)
GO

CREATE EXTERNAL TABLE dbo.ext_DETALLE_PEDIDO (
    id_detalle INT NOT NULL,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL
)
WITH (
    DATA_SOURCE = [Src_BD_Cafeteria],
    SCHEMA_NAME = N'dbo',
    OBJECT_NAME = N'DETALLE_PEDIDO'
)
GO

-- ==================================================================================
-- PASO 3: MODELO DIMENSIONAL ESTRELLA (5 DIMENSIONES + 1 TABLA DE HECHOS + AUDITORIA)
-- ==================================================================================

IF OBJECT_ID('dbo.Fact_Ventas', 'U') IS NOT NULL
    DROP TABLE dbo.Fact_Ventas
GO

IF OBJECT_ID('dbo.Dim_Cliente', 'U') IS NOT NULL
    DROP TABLE dbo.Dim_Cliente
GO

IF OBJECT_ID('dbo.Dim_Empleado', 'U') IS NOT NULL
    DROP TABLE dbo.Dim_Empleado
GO

IF OBJECT_ID('dbo.Dim_MetodoPago', 'U') IS NOT NULL
    DROP TABLE dbo.Dim_MetodoPago
GO

IF OBJECT_ID('dbo.Dim_Producto', 'U') IS NOT NULL
    DROP TABLE dbo.Dim_Producto
GO

IF OBJECT_ID('dbo.Dim_Tiempo', 'U') IS NOT NULL
    DROP TABLE dbo.Dim_Tiempo
GO

IF OBJECT_ID('dbo.LOG_HISTORIAL_JOB_ETL', 'U') IS NOT NULL
    DROP TABLE dbo.LOG_HISTORIAL_JOB_ETL
GO

-- 1. Dim_Cliente
CREATE TABLE dbo.Dim_Cliente(
    id_cliente_sk INT IDENTITY(1,1) NOT NULL,
    id_cliente_bk INT NOT NULL,
    nombre_completo VARCHAR(160) NOT NULL,
    telefono VARCHAR(20) NULL,
    PRIMARY KEY CLUSTERED (id_cliente_sk ASC)
)
GO

-- 2. Dim_Empleado
CREATE TABLE dbo.Dim_Empleado(
    id_empleado_sk INT IDENTITY(1,1) NOT NULL,
    id_empleado_bk INT NOT NULL,
    nombre_completo VARCHAR(160) NOT NULL,
    cargo VARCHAR(60) NOT NULL,
    turno VARCHAR(30) NOT NULL,
    PRIMARY KEY CLUSTERED (id_empleado_sk ASC)
)
GO

-- 3. Dim_MetodoPago
CREATE TABLE dbo.Dim_MetodoPago(
    id_metodo_pago_sk INT IDENTITY(1,1) NOT NULL,
    metodo_pago VARCHAR(40) NOT NULL,
    PRIMARY KEY CLUSTERED (id_metodo_pago_sk ASC)
)
GO

-- 4. Dim_Producto
CREATE TABLE dbo.Dim_Producto(
    id_producto_sk INT IDENTITY(1,1) NOT NULL,
    id_producto_bk INT NOT NULL,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(80) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED (id_producto_sk ASC)
)
GO

-- 5. Dim_Tiempo
CREATE TABLE dbo.Dim_Tiempo(
    id_tiempo_sk INT NOT NULL,
    fecha DATE NOT NULL,
    anio INT NOT NULL,
    mes INT NOT NULL,
    nombre_mes VARCHAR(20) NOT NULL,
    dia INT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    PRIMARY KEY CLUSTERED (id_tiempo_sk ASC)
)
GO

-- 6. Fact_Ventas
CREATE TABLE dbo.Fact_Ventas(
    id_venta_sk INT IDENTITY(1,1) NOT NULL,
    id_tiempo_sk INT NOT NULL,
    id_producto_sk INT NOT NULL,
    id_empleado_sk INT NOT NULL,
    id_cliente_sk INT NOT NULL,
    id_metodo_pago_sk INT NOT NULL,
    id_pedido_original INT NOT NULL,
    cantidad INT NOT NULL,
    monto_total DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED (id_venta_sk ASC),
    CONSTRAINT FK_Fact_Tiempo FOREIGN KEY (id_tiempo_sk) REFERENCES dbo.Dim_Tiempo(id_tiempo_sk),
    CONSTRAINT FK_Fact_Producto FOREIGN KEY (id_producto_sk) REFERENCES dbo.Dim_Producto(id_producto_sk),
    CONSTRAINT FK_Fact_Empleado FOREIGN KEY (id_empleado_sk) REFERENCES dbo.Dim_Empleado(id_empleado_sk),
    CONSTRAINT FK_Fact_Cliente FOREIGN KEY (id_cliente_sk) REFERENCES dbo.Dim_Cliente(id_cliente_sk),
    CONSTRAINT FK_Fact_MetodoPago FOREIGN KEY (id_metodo_pago_sk) REFERENCES dbo.Dim_MetodoPago(id_metodo_pago_sk)
)
GO

-- 7. LOG_HISTORIAL_JOB_ETL (Historial de Auditoria de Ejecucion)
CREATE TABLE dbo.LOG_HISTORIAL_JOB_ETL(
    id_historial INT IDENTITY(1,1) NOT NULL,
    nombre_job VARCHAR(100) NOT NULL,
    paso_ejecutado VARCHAR(80) NOT NULL,
    fecha_ejecucion DATE NOT NULL,
    hora_inicio TIME(7) NOT NULL,
    hora_fin TIME(7) NOT NULL,
    duracion_segundos DECIMAL(5,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    filas_procesadas INT NOT NULL,
    mensaje VARCHAR(255) NOT NULL,
    PRIMARY KEY CLUSTERED (id_historial ASC)
)
GO

-- ==================================================================================
-- PASO 4: PROCEDIMIENTO ALMACENADO PARA EL PROCESO ETL AUTOMATIZADO
-- ==================================================================================

CREATE OR ALTER PROCEDURE dbo.usp_ETL_CargaCompleta
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON

    DECLARE @RegistrosOrigen INT
    DECLARE @RegistrosDestino INT
    DECLARE @MontoOrigen DECIMAL(19,2)
    DECLARE @MontoDestino DECIMAL(19,2)
    DECLARE @HoraInicio TIME(7) = CONVERT(TIME(7), SYSDATETIME())
    DECLARE @FechaEjecucion DATE = CAST(GETDATE() AS DATE)
    DECLARE @InicioDt DATETIME2 = SYSDATETIME()
    DECLARE @FinDt DATETIME2
    DECLARE @DuracionSegundos DECIMAL(5,2)

    -- Validar consistencia e integridad de datos operacionales en el origen
    IF EXISTS (
        SELECT 1
        FROM dbo.ext_DETALLE_PEDIDO
        WHERE cantidad <= 0
           OR subtotal < 0
           OR id_pedido IS NULL
           OR id_producto IS NULL
    )
    BEGIN
        RAISERROR ('Existen detalles de pedido invalidos en el origen.', 16, 1)
        RETURN
    END

    SELECT
        @RegistrosOrigen = COUNT(*),
        @MontoOrigen = COALESCE(SUM(subtotal), 0)
    FROM dbo.ext_DETALLE_PEDIDO

    IF @RegistrosOrigen = 0
    BEGIN
        RAISERROR ('La tabla de detalles de origen esta vacia.', 16, 1)
        RETURN
    END

    BEGIN TRY
        BEGIN TRANSACTION

        -- Limpieza de tablas dependientes y reinicio de identidades
        DELETE FROM dbo.Fact_Ventas
        DELETE FROM dbo.Dim_Cliente
        DBCC CHECKIDENT ('dbo.Dim_Cliente', RESEED, 0)
        DELETE FROM dbo.Dim_Empleado
        DBCC CHECKIDENT ('dbo.Dim_Empleado', RESEED, 0)
        DELETE FROM dbo.Dim_Producto
        DBCC CHECKIDENT ('dbo.Dim_Producto', RESEED, 0)
        DELETE FROM dbo.Dim_Tiempo
        DELETE FROM dbo.Dim_MetodoPago
        DBCC CHECKIDENT ('dbo.Dim_MetodoPago', RESEED, 0)
        DBCC CHECKIDENT ('dbo.Fact_Ventas', RESEED, 0)

        -- 1. Carga Dim_Cliente
        INSERT INTO dbo.Dim_Cliente (id_cliente_bk, nombre_completo, telefono)
        SELECT
            id_cliente,
            CONCAT(nombres, ' ', apellidos),
            telefono
        FROM dbo.ext_CLIENTE

        -- 2. Carga Dim_Empleado
        INSERT INTO dbo.Dim_Empleado (id_empleado_bk, nombre_completo, cargo, turno)
        SELECT
            id_empleado,
            CONCAT(nombres, ' ', apellidos),
            cargo,
            turno
        FROM dbo.ext_EMPLEADO

        -- 3. Carga Dim_Producto (Desnormalizacion con Categoria)
        INSERT INTO dbo.Dim_Producto (id_producto_bk, nombre_producto, categoria, precio_unitario)
        SELECT
            p.id_producto,
            p.nombre_producto,
            c.nombre_categoria,
            p.precio
        FROM dbo.ext_PRODUCTO p
        INNER JOIN dbo.ext_CATEGORIA c
            ON p.id_categoria = c.id_categoria

        -- 4. Carga Dim_Tiempo
        INSERT INTO dbo.Dim_Tiempo (id_tiempo_sk, fecha, anio, mes, nombre_mes, dia, dia_semana)
        SELECT DISTINCT
            CONVERT(INT, CONVERT(CHAR(8), fecha_pedido, 112)),
            fecha_pedido,
            YEAR(fecha_pedido),
            MONTH(fecha_pedido),
            DATENAME(MONTH, fecha_pedido),
            DAY(fecha_pedido),
            DATENAME(WEEKDAY, fecha_pedido)
        FROM dbo.ext_PEDIDO

        -- 5. Carga Dim_MetodoPago
        INSERT INTO dbo.Dim_MetodoPago (metodo_pago)
        SELECT DISTINCT
            LTRIM(RTRIM(metodo_pago))
        FROM dbo.ext_PEDIDO
        WHERE NULLIF(LTRIM(RTRIM(metodo_pago)), '') IS NOT NULL

        -- 6. Carga Fact_Ventas (Granularidad atomica: Detalle de venta)
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
            dt.id_tiempo_sk,
            dp.id_producto_sk,
            de.id_empleado_sk,
            dc.id_cliente_sk,
            dm.id_metodo_pago_sk,
            d.id_pedido,
            d.cantidad,
            d.subtotal
        FROM dbo.ext_DETALLE_PEDIDO d
        INNER JOIN dbo.ext_PEDIDO pe
            ON d.id_pedido = pe.id_pedido
        INNER JOIN dbo.Dim_Cliente dc
            ON pe.id_cliente = dc.id_cliente_bk
        INNER JOIN dbo.Dim_Empleado de
            ON pe.id_empleado = de.id_empleado_bk
        INNER JOIN dbo.Dim_Producto dp
            ON d.id_producto = dp.id_producto_bk
        INNER JOIN dbo.Dim_Tiempo dt
            ON pe.fecha_pedido = dt.fecha
        INNER JOIN dbo.Dim_MetodoPago dm
            ON LTRIM(RTRIM(pe.metodo_pago)) = dm.metodo_pago
        WHERE d.cantidad > 0
          AND d.subtotal >= 0

        -- Validacion estricta de cuadratura operacional
        SELECT
            @RegistrosDestino = COUNT(*),
            @MontoDestino = COALESCE(SUM(monto_total), 0)
        FROM dbo.Fact_Ventas

        IF @RegistrosOrigen <> @RegistrosDestino
           OR @MontoOrigen <> @MontoDestino
        BEGIN
            RAISERROR ('No coinciden los registros o montos entre el origen OLTP y el destino Data Mart.', 16, 1)
            RETURN
        END

        -- Registro de auditoria en LOG_HISTORIAL_JOB_ETL
        SET @FinDt = SYSDATETIME()
        SET @DuracionSegundos = CAST(DATEDIFF(MILLISECOND, @InicioDt, @FinDt) / 1000.0 AS DECIMAL(5,2))

        INSERT INTO dbo.LOG_HISTORIAL_JOB_ETL (
            nombre_job,
            paso_ejecutado,
            fecha_ejecucion,
            hora_inicio,
            hora_fin,
            duracion_segundos,
            estado,
            filas_procesadas,
            mensaje
        )
        VALUES (
            'JOB_ETL_CARGA_DIARIA_CAFETERIA',
            'Paso 1: usp_ETL_CargaCompleta',
            @FechaEjecucion,
            @HoraInicio,
            CONVERT(TIME(7), @FinDt),
            @DuracionSegundos,
            'Correcto',
            @RegistrosDestino,
            'Ejecución programada finalizada con éxito. Carga dimensional completa en Azure SQL.'
        )

        COMMIT TRANSACTION

        SELECT
            @RegistrosOrigen AS RegistrosOrigen,
            @RegistrosDestino AS RegistrosDestino,
            @MontoDestino AS MontoTotal,
            'CORRECTO' AS Estado

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION
        END

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-- Procedimiento alternativo por compatibilidad de nomenclatura
CREATE OR ALTER PROCEDURE dbo.SP_EJECUTAR_ETL_VENTAS
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON
    EXEC dbo.usp_ETL_CargaCompleta
END
GO
