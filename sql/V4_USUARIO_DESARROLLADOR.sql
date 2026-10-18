-- ============================================================================
-- SCRIPT DE CREACIÓN Y ASIGNACIÓN DE PERMISOS: usr_desarrollador
-- Proyecto: BD_Cafeteria / Cafeteria_DM
-- Objetivo: Crear perfil con permisos para consultar (SELECT), manipular datos
--           (INSERT, UPDATE, DELETE), crear, alterar y borrar tablas (DDL),
--           pero SIN permisos administrativos para borrar la base de datos (DROP DATABASE).
-- ============================================================================

-- ----------------------------------------------------------------------------
-- PARTE 1: CREACIÓN DE LOGIN A NIVEL DE SERVIDOR / MASTER
-- (Ejecutar en la base de datos [master])
-- ----------------------------------------------------------------------------
USE [master];
GO

IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'usr_desarrollador')
BEGIN
    CREATE LOGIN [usr_desarrollador] 
    WITH PASSWORD = 'DevCafe#Demo2026!', -- Reemplazar por contraseña segura en producción
         CHECK_POLICY = OFF, 
         CHECK_EXPIRATION = OFF;
    PRINT 'Login [usr_desarrollador] creado con éxito.';
END
ELSE
BEGIN
    PRINT 'Login [usr_desarrollador] ya existe.';
END
GO

-- Crear usuario en master (permite que SSMS se conecte sin fallar con Error 916 al usar <predeterminado>)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_desarrollador')
BEGIN
    CREATE USER [usr_desarrollador] FOR LOGIN [usr_desarrollador];
    PRINT 'Usuario [usr_desarrollador] creado en [master] para acceso básico.';
END
GO

-- ----------------------------------------------------------------------------
-- PARTE 2: CREACIÓN DE USUARIO Y ASIGNACIÓN DE ROLES EN [BD_Cafeteria]
-- (Ejecutar en la base de datos [BD_Cafeteria])
-- ----------------------------------------------------------------------------
USE [BD_Cafeteria];
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_desarrollador')
BEGIN
    CREATE USER [usr_desarrollador] FOR LOGIN [usr_desarrollador];
    PRINT 'Usuario [usr_desarrollador] creado en [BD_Cafeteria].';
END
ELSE
BEGIN
    PRINT 'Usuario [usr_desarrollador] ya existe en [BD_Cafeteria].';
END
GO

-- 1. Permiso de consulta en todas las tablas y vistas (SELECT)
ALTER ROLE [db_datareader] ADD MEMBER [usr_desarrollador];

-- 2. Permiso de modificación de datos en todas las tablas (INSERT, UPDATE, DELETE)
ALTER ROLE [db_datawriter] ADD MEMBER [usr_desarrollador];

-- 3. Permiso DDL: Permite crear, modificar y eliminar tablas (CREATE, ALTER, DROP, TRUNCATE TABLE)
ALTER ROLE [db_ddladmin] ADD MEMBER [usr_desarrollador];

-- 4. Permiso de ejecución de procedimientos almacenados
GRANT EXECUTE TO [usr_desarrollador];

PRINT 'Roles asignados a [usr_desarrollador] en [BD_Cafeteria]: db_datareader, db_datawriter, db_ddladmin, GRANT EXECUTE.';
GO

-- ----------------------------------------------------------------------------
-- PARTE 3: ASIGNACIÓN DE ROLES EN DATA MART [Cafeteria_DM] (Si existe)
-- ----------------------------------------------------------------------------
IF DB_ID('Cafeteria_DM') IS NOT NULL
BEGIN
    USE [Cafeteria_DM];
    
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_desarrollador')
    BEGIN
        CREATE USER [usr_desarrollador] FOR LOGIN [usr_desarrollador];
    END;

    ALTER ROLE [db_datareader] ADD MEMBER [usr_desarrollador];
    ALTER ROLE [db_datawriter] ADD MEMBER [usr_desarrollador];
    ALTER ROLE [db_ddladmin] ADD MEMBER [usr_desarrollador];
    GRANT EXECUTE TO [usr_desarrollador];

    PRINT 'Roles asignados a [usr_desarrollador] en [Cafeteria_DM].';
END
GO

-- ----------------------------------------------------------------------------
-- NOTA DE SEGURIDAD:
-- El rol db_ddladmin otorga permisos para ejecutar comandos DDL como:
--   - CREATE TABLE, ALTER TABLE, DROP TABLE, TRUNCATE TABLE
--   - CREATE INDEX, ALTER INDEX, DROP INDEX
--   - CREATE VIEW, ALTER VIEW, DROP VIEW
--   - CREATE PROCEDURE, ALTER PROCEDURE, DROP PROCEDURE
--
-- Sin embargo, NO otorga permisos para borrar la base de datos (DROP DATABASE),
-- ya que para eliminar la base de datos se requiere pertenecer al rol de servidor
-- 'dbcreator', tener permiso 'CONTROL DATABASE' o ser 'db_owner'/'sysadmin'.
-- Por tanto, este perfil NO puede borrar la base de datos.
-- ----------------------------------------------------------------------------
