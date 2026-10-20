-- ============================================================================
-- SCRIPT DE AUDITORÍA DDL PARA BD_Cafeteria
-- Objetivo: Registrar automáticamente cada cambio estructural (CREATE TABLE,
--           ALTER TABLE, DROP TABLE, etc.) realizado por cualquier usuario,
--           especialmente [usr_desarrollador].
--           Incluye blindaje de seguridad (DENY) para que no puedan borrar el log.
-- ============================================================================

USE [BD_Cafeteria]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------------------------------------------------------
-- 1. TABLA DE REGISTRO DE AUDITORÍA DDL
-- ----------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LOG_AUDITORIA_DDL')
BEGIN
    CREATE TABLE LOG_AUDITORIA_DDL (
        id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
        fecha_evento DATETIME DEFAULT GETDATE(),
        usuario_login NVARCHAR(128),
        usuario_db NVARCHAR(128),
        tipo_evento NVARCHAR(100),
        tipo_objeto NVARCHAR(100),
        nombre_objeto NVARCHAR(256),
        esquema NVARCHAR(100),
        comando_sql NVARCHAR(MAX),
        ip_cliente NVARCHAR(50)
    )
    PRINT 'Tabla LOG_AUDITORIA_DDL creada con éxito.'
END
ELSE
BEGIN
    PRINT 'Tabla LOG_AUDITORIA_DDL ya existe.'
END
GO

-- ----------------------------------------------------------------------------
-- 2. DISPARADOR (TRIGGER) DDL A NIVEL DE BASE DE DATOS
-- Se ejecuta con contexto 'dbo' (WITH EXECUTE AS 'dbo') para que el disparador
-- siempre tenga privilegios para registrar el evento, independientemente de
-- las restricciones del usuario que ejecute la acción.
-- ----------------------------------------------------------------------------
CREATE OR ALTER TRIGGER TRG_AUDITORIA_DDL
ON DATABASE
WITH EXECUTE AS 'dbo'
FOR DDL_DATABASE_LEVEL_EVENTS
AS
BEGIN
    SET NOCOUNT ON
    
    DECLARE @data XML = EVENTDATA()
    
    -- Ignoramos eventos sobre la propia tabla de auditoría para evitar recursividad
    IF @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)') = 'LOG_AUDITORIA_DDL'
        RETURN
        
    INSERT INTO LOG_AUDITORIA_DDL (
        fecha_evento,
        usuario_login,
        usuario_db,
        tipo_evento,
        tipo_objeto,
        nombre_objeto,
        esquema,
        comando_sql,
        ip_cliente
    )
    VALUES (
        GETDATE(),
        @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(128)'),
        @data.value('(/EVENT_INSTANCE/UserName)[1]', 'NVARCHAR(128)'),
        @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
        @data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(100)'),
        @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)'),
        @data.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(100)'),
        @data.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'NVARCHAR(MAX)'),
        @data.value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(50)')
    )
END
GO
PRINT 'Trigger TRG_AUDITORIA_DDL instalado y activo con ejecución privilegiada.'
GO

-- ----------------------------------------------------------------------------
-- 3. BLINDAJE DE SEGURIDAD (ANTI-MANIPULACIÓN)
-- Prohibimos INSERT, UPDATE, DELETE y DROP sobre la tabla de log a usr_desarrollador.
-- Ni puede borrar registros, ni alterarlos, ni insertar registros falsos.
-- ----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_desarrollador')
BEGIN
    DENY INSERT, UPDATE, DELETE ON OBJECT::LOG_AUDITORIA_DDL TO usr_desarrollador
    DENY ALTER, CONTROL ON OBJECT::LOG_AUDITORIA_DDL TO usr_desarrollador
    PRINT 'Blindaje de seguridad aplicado: usr_desarrollador NO puede modificar ni eliminar LOG_AUDITORIA_DDL.'
END
GO
