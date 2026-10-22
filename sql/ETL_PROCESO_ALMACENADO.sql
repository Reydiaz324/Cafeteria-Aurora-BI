------------------------------------------------
--------------------------------------------------------------------
USE Cafeteria_DM;
GO

CREATE OR ALTER PROCEDURE dbo.usp_ETL_CargaCompleta
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @RegistrosOrigen INT;
    DECLARE @RegistrosDestino INT;
    DECLARE @MontoOrigen DECIMAL(19,2);
    DECLARE @MontoDestino DECIMAL(19,2);

    ----- Validar datos operacionales-----------------------
    IF EXISTS (
        SELECT 1
        FROM BD_Cafeteria.dbo.DETALLE_PEDIDO
        WHERE cantidad <= 0
           OR subtotal < 0
           OR id_pedido IS NULL
           OR id_producto IS NULL
    )
        THROW 51001, 'Existen detalles de pedido invalidos.', 1;

    SELECT
        @RegistrosOrigen = COUNT(*),
        @MontoOrigen = COALESCE(SUM(subtotal), 0)
    FROM BD_Cafeteria.dbo.DETALLE_PEDIDO;

    IF @RegistrosOrigen = 0
        THROW 51003, 'La tabla de detalles de origen esta vacia.', 1;

-------------------------------------------------
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM dbo.Fact_Ventas;
        DELETE FROM dbo.Dim_Cliente;
        DELETE FROM dbo.Dim_Empleado;
        DELETE FROM dbo.Dim_Producto;
        DELETE FROM dbo.Dim_Tiempo;
        DELETE FROM dbo.Dim_MetodoPago;

        -----------------------------
        -- ETL---
        INSERT INTO dbo.Dim_Cliente
            (id_cliente_bk, nombre_completo, telefono)
        SELECT
            id_cliente,
            CONCAT(nombres, ' ', apellidos),
            telefono
        FROM BD_Cafeteria.dbo.CLIENTE;

        ----------------------------------
        INSERT INTO dbo.Dim_Empleado
            (id_empleado_bk, nombre_completo, cargo, turno)
        SELECT
            id_empleado,
            CONCAT(nombres, ' ', apellidos),
            cargo,
            turno
        FROM BD_Cafeteria.dbo.EMPLEADO;

        --------------------------------------------------
        INSERT INTO dbo.Dim_Producto
            (id_producto_bk, nombre_producto, categoria, precio_unitario)
        SELECT
            p.id_producto,
            p.nombre_producto,
            c.nombre_categoria,
            p.precio
        FROM BD_Cafeteria.dbo.PRODUCTO p
        INNER JOIN BD_Cafeteria.dbo.CATEGORIA c
            ON p.id_categoria = c.id_categoria;

        -------------------------------------------------------
        INSERT INTO dbo.Dim_Tiempo
            (id_tiempo_sk, fecha, anio, mes,
             nombre_mes, dia, dia_semana)
        SELECT DISTINCT
            CONVERT(INT, CONVERT(CHAR(8), fecha_pedido, 112)),
            fecha_pedido,
            YEAR(fecha_pedido),
            MONTH(fecha_pedido),
            DATENAME(MONTH, fecha_pedido),
            DAY(fecha_pedido),
            DATENAME(WEEKDAY, fecha_pedido)
        FROM BD_Cafeteria.dbo.PEDIDO;

        -------------------------------------------------------------------
        INSERT INTO dbo.Dim_MetodoPago (metodo_pago)
        SELECT DISTINCT
            LTRIM(RTRIM(metodo_pago))
        FROM BD_Cafeteria.dbo.PEDIDO
        WHERE NULLIF(LTRIM(RTRIM(metodo_pago)), '') IS NOT NULL;

        -------------------------------------------------------------------
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
        FROM BD_Cafeteria.dbo.DETALLE_PEDIDO d
        INNER JOIN BD_Cafeteria.dbo.PEDIDO pe
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
          AND d.subtotal >= 0;

   
   -----------------------------------------------------------
   --validacion-----------

        SELECT
            @RegistrosDestino = COUNT(*),
            @MontoDestino = COALESCE(SUM(monto_total), 0)
        FROM dbo.Fact_Ventas;

        IF @RegistrosOrigen <> @RegistrosDestino
           OR @MontoOrigen <> @MontoDestino
            THROW 51002, 'No coinciden los registros o montos.', 1;

        COMMIT TRANSACTION;

        SELECT
            @RegistrosOrigen AS RegistrosOrigen,
            @RegistrosDestino AS RegistrosDestino,
            @MontoDestino AS MontoTotal,
            'CORRECTO' AS Estado;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO

--Ejecutar--------------------

USE Cafeteria_DM;
GO
EXEC dbo.usp_ETL_CargaCompleta;
GO



-- comprobar--------------------

USE Cafeteria_DM;
GO
SELECT * FROM dbo.Dim_Cliente;
SELECT * FROM dbo.Dim_Empleado;
SELECT * FROM dbo.Dim_Producto;
SELECT * FROM dbo.Dim_Tiempo;
SELECT * FROM dbo.Dim_MetodoPago;
SELECT * FROM dbo.Fact_Ventas;

------------------------------------------------------

--LIMPIAR------------------------------------
USE Cafeteria_DM;
GO
BEGIN TRY
    BEGIN TRANSACTION;
    DELETE FROM dbo.Fact_Ventas;
    DELETE FROM dbo.Dim_Cliente;
    DELETE FROM dbo.Dim_Empleado;
    DELETE FROM dbo.Dim_Producto;
    DELETE FROM dbo.Dim_Tiempo;
    DELETE FROM dbo.Dim_MetodoPago;

    COMMIT TRANSACTION;

    PRINT 'Data Mart preparado para la exposición.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
GO



