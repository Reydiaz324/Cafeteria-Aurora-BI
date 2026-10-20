-- =====================================================================
-- PROYECTO: CAFETERÍA AURORA
-- SCRIPT: V2_ROLES_USUARIOS.sql
-- DESCRIPCIÓN: Creación de tablas ROL, USUARIO, inserción de usuarios
--              semilla con contraseña hasheada (SHA2-256) y procedimiento
--              SP_AUTENTICAR_USUARIO para autenticación segura.
-- AUTOR: Equipo de Base de Datos
-- =====================================================================

-- 1. TABLA ROL
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ROL')
BEGIN
    CREATE TABLE [dbo].[ROL] (
        [id_rol] INT IDENTITY(1,1) NOT NULL,
        [nombre_rol] VARCHAR(50) NOT NULL,
        [descripcion] VARCHAR(150) NULL,
        CONSTRAINT [PK_ROL] PRIMARY KEY CLUSTERED ([id_rol] ASC),
        CONSTRAINT [UQ_ROL_nombre] UNIQUE NONCLUSTERED ([nombre_rol] ASC)
    )
END
GO

-- 2. TABLA USUARIO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'USUARIO')
BEGIN
    CREATE TABLE [dbo].[USUARIO] (
        [id_usuario] INT IDENTITY(1,1) NOT NULL,
        [id_empleado] INT NOT NULL,
        [id_rol] INT NOT NULL,
        [username] VARCHAR(50) NOT NULL,
        [password_hash] VARCHAR(64) NOT NULL,
        [estado] VARCHAR(20) NOT NULL CONSTRAINT [DF_USUARIO_estado] DEFAULT ('Activo'),
        [fecha_creacion] DATETIME NOT NULL CONSTRAINT [DF_USUARIO_fecha] DEFAULT (GETDATE()),
        CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED ([id_usuario] ASC),
        CONSTRAINT [UQ_USUARIO_username] UNIQUE NONCLUSTERED ([username] ASC),
        CONSTRAINT [FK_USUARIO_EMPLEADO] FOREIGN KEY ([id_empleado]) REFERENCES [dbo].[EMPLEADO] ([id_empleado]),
        CONSTRAINT [FK_USUARIO_ROL] FOREIGN KEY ([id_rol]) REFERENCES [dbo].[ROL] ([id_rol])
    )
END
GO

-- 3. POBLAR ROLES INICIALES
IF NOT EXISTS (SELECT 1 FROM [dbo].[ROL] WHERE [nombre_rol] = 'Encargado')
    INSERT INTO [dbo].[ROL] ([nombre_rol], [descripcion]) VALUES ('Encargado', 'Acceso total: métricas, inventario, reportes y administración')

IF NOT EXISTS (SELECT 1 FROM [dbo].[ROL] WHERE [nombre_rol] = 'Barista')
    INSERT INTO [dbo].[ROL] ([nombre_rol], [descripcion]) VALUES ('Barista', 'Acceso operativo: toma de pedidos, emisión de boletas y caja')
GO

-- 4. POBLAR USUARIOS INICIALES (Contraseñas con SHA2-256)
-- Clave por defecto para pruebas: 1234
-- Hash SHA2-256: 03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4

-- Usuario Encargado (Mariana Vega, id_empleado = 1)
IF NOT EXISTS (SELECT 1 FROM [dbo].[USUARIO] WHERE [username] = 'mariana.vega')
BEGIN
    INSERT INTO [dbo].[USUARIO] ([id_empleado], [id_rol], [username], [password_hash], [estado])
    VALUES (
        1, 
        (SELECT [id_rol] FROM [dbo].[ROL] WHERE [nombre_rol] = 'Encargado'), 
        'mariana.vega', 
        LOWER(CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '1234'), 2)),
        'Activo'
    )
END
GO

-- Usuario Barista (Jose Castillo, id_empleado = 2)
IF NOT EXISTS (SELECT 1 FROM [dbo].[USUARIO] WHERE [username] = 'jose.castillo')
BEGIN
    INSERT INTO [dbo].[USUARIO] ([id_empleado], [id_rol], [username], [password_hash], [estado])
    VALUES (
        2, 
        (SELECT [id_rol] FROM [dbo].[ROL] WHERE [nombre_rol] = 'Barista'), 
        'jose.castillo', 
        LOWER(CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', '1234'), 2)),
        'Activo'
    )
END
GO

-- 5. PROCEDIMIENTO ALMACENADO DE AUTENTICACIÓN
CREATE OR ALTER PROCEDURE [dbo].[SP_AUTENTICAR_USUARIO]
    @username VARCHAR(50),
    @password VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @hash VARCHAR(64) = LOWER(CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', @password), 2))

    SELECT 
        u.id_usuario,
        u.username,
        e.id_empleado,
        e.nombres + ' ' + e.apellidos AS nombre_completo,
        r.id_rol,
        r.nombre_rol,
        u.estado
    FROM [dbo].[USUARIO] u
    INNER JOIN [dbo].[EMPLEADO] e ON u.id_empleado = e.id_empleado
    INNER JOIN [dbo].[ROL] r ON u.id_rol = r.id_rol
    WHERE LOWER(u.username) = LOWER(TRIM(@username))
      AND u.password_hash = @hash
      AND u.estado = 'Activo'
      AND e.estado = 'Activo'
END
GO

-- Otorgar permisos de ejecución al usuario de la aplicación
GRANT EXECUTE ON [dbo].[SP_AUTENTICAR_USUARIO] TO [app_cafeteria]
GO
