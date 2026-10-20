/****** Objeto: Table [dbo].[CATEGORIA] Fecha de script: 1/07/2026 00:47:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre_categoria] [varchar](80) NOT NULL,
	[descripcion] [varchar](200) NULL,
 CONSTRAINT [PK_CATEGORIA] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[PROVEEDOR] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDOR](
	[id_proveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombre_proveedor] [varchar](100) NOT NULL,
	[tipo_suministro] [varchar](120) NOT NULL,
	[telefono] [varchar](20) NULL,
	[correo] [varchar](100) NULL,
 CONSTRAINT [PK_PROVEEDOR] PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[PRODUCTO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[nombre_producto] [varchar](80) NOT NULL,
	[descripcion] [varchar](200) NULL,
	[precio] [decimal](10, 2) NOT NULL,
	[stock] [int] NOT NULL,
	[id_categoria] [int] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_PRODUCTO] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VW_PRODUCTOS_CATEGORIA] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PRODUCTOS_CATEGORIA] AS
SELECT
    p.id_producto,
    p.nombre_producto,
    p.precio,
    p.stock,
    p.estado,
    c.nombre_categoria,
    pr.nombre_proveedor
FROM PRODUCTO p
INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
INNER JOIN PROVEEDOR pr ON p.id_proveedor = pr.id_proveedor
GO
/****** Objeto: Table [dbo].[CLIENTE] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](80) NOT NULL,
	[apellidos] [varchar](80) NOT NULL,
	[telefono] [varchar](20) NULL,
	[correo] [varchar](100) NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[EMPLEADO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLEADO](
	[id_empleado] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](80) NOT NULL,
	[apellidos] [varchar](80) NOT NULL,
	[dni] [varchar](8) NOT NULL,
	[cargo] [varchar](60) NOT NULL,
	[tipo_contrato] [varchar](20) NOT NULL,
	[sueldo] [decimal](10, 2) NOT NULL,
	[turno] [varchar](30) NOT NULL,
	[fecha_ingreso] [date] NOT NULL,
	[estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_EMPLEADO] PRIMARY KEY CLUSTERED 
(
	[id_empleado] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[PEDIDO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PEDIDO](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[fecha_pedido] [date] NOT NULL,
	[total] [decimal](10, 2) NOT NULL,
	[metodo_pago] [varchar](40) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_empleado] [int] NOT NULL,
 CONSTRAINT [PK_PEDIDO] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VW_PEDIDOS_CLIENTE_EMPLEADO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PEDIDOS_CLIENTE_EMPLEADO] AS
SELECT
    pe.id_pedido,
    pe.fecha_pedido,
    pe.total,
    pe.metodo_pago,
    c.nombres + ' ' + c.apellidos AS cliente,
    e.nombres + ' ' + e.apellidos AS empleado
FROM PEDIDO pe
INNER JOIN CLIENTE c ON pe.id_cliente = c.id_cliente
INNER JOIN EMPLEADO e ON pe.id_empleado = e.id_empleado
GO
/****** Objeto: Table [dbo].[INVENTARIO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVENTARIO](
	[id_inventario] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad_disponible] [int] NOT NULL,
	[fecha_actualizacion] [date] NOT NULL,
 CONSTRAINT [PK_INVENTARIO] PRIMARY KEY CLUSTERED 
(
	[id_inventario] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: View [dbo].[VW_INVENTARIO_PRODUCTOS] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_INVENTARIO_PRODUCTOS] AS
SELECT
    i.id_inventario,
    p.id_producto,
    p.nombre_producto,
    i.cantidad_disponible,
    i.fecha_actualizacion
FROM INVENTARIO i
INNER JOIN PRODUCTO p ON i.id_producto = p.id_producto
GO
/****** Objeto: Table [dbo].[DETALLE_PEDIDO] Fecha de script: 1/07/2026 00:47:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_PEDIDO](
	[id_detalle] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[subtotal] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_DETALLE_PEDIDO] PRIMARY KEY CLUSTERED 
(
	[id_detalle] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[CATEGORIA] ON 

INSERT [dbo].[CATEGORIA] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (1, N'Lattes/Cappuccino', N'Cafe y bebidas calientes preparadas en la cafeteria')
INSERT [dbo].[CATEGORIA] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (2, N'Frappuccinos', N'Bebidas frias y refrescantes preparadas en la cafeteria')
INSERT [dbo].[CATEGORIA] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (3, N'Panaderia', N'Productos de panaderia para venta directa')
INSERT [dbo].[CATEGORIA] ([id_categoria], [nombre_categoria], [descripcion]) VALUES (4, N'Postres', N'Postres y dulces para acompanamiento')
SET IDENTITY_INSERT [dbo].[CATEGORIA] OFF
GO

SET IDENTITY_INSERT [dbo].[PROVEEDOR] ON 

INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (1, N'Maria Almenara', N'Productos de panaderia y postres', N'989111222', N'ventas@mariaalmenara.com')
INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (2, N'Cocina Central', N'Alimentos y productos preparados', N'989333444', N'contacto@cocinacentral.com')
INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (3, N'Ransa', N'Suministros e insumos esenciales para bebidas y funcionamiento general', N'989555666', N'atencion@ransa.com')
SET IDENTITY_INSERT [dbo].[PROVEEDOR] OFF
GO

SET IDENTITY_INSERT [dbo].[PRODUCTO] ON 

INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (1, N'Latte', N'Bebida caliente con cafe espresso y leche vaporizada', CAST(12.00 AS Decimal(10, 2)), 67, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (2, N'Cappuccino', N'Bebida caliente con espresso, leche y espuma', CAST(11.50 AS Decimal(10, 2)), 71, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (3, N'Mocha', N'Bebida caliente con cafe, leche y chocolate', CAST(13.00 AS Decimal(10, 2)), 74, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (4, N'Mocha Frapuccino', N'Bebida fria con cafe, leche, chocolate y hielo', CAST(13.00 AS Decimal(10, 2)), 76, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (5, N'Espresso', N'Cafe concentrado servido en porcion pequeña', CAST(8.00 AS Decimal(10, 2)), 74, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (6, N'Espresso 2', N'Cafe concentrado servido en porcion doble pequeña', CAST(8.00 AS Decimal(10, 2)), 77, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (7, N'Cold Brew', N'Cafe frio preparado por infusion lenta', CAST(13.50 AS Decimal(10, 2)), 71, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (8, N'Muffins de naranja', N'Muffin de naranja en porcion individual', CAST(7.00 AS Decimal(10, 2)), 71, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (9, N'Brownies', N'Postre de chocolate en porcion individual', CAST(8.50 AS Decimal(10, 2)), 73, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (10, N'Cheesecake', N'Postre frio a base de queso crema', CAST(12.50 AS Decimal(10, 2)), 73, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (11, N'Croissants', N'Postre de masa hojaldrada para acompanamiento', CAST(9.00 AS Decimal(10, 2)), 73, 4, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (12, N'Muffins de manzana', N'Muffin de manzana en porcion individual', CAST(7.00 AS Decimal(10, 2)), 76, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (13, N'Panino Vesubio', N'Panino Vesubio preparado para venta directa', CAST(14.00 AS Decimal(10, 2)), 75, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (14, N'Chicken Panino', N'Panino de pollo preparado para venta directa', CAST(13.50 AS Decimal(10, 2)), 75, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (15, N'Chicken Ciabatta', N'Ciabatta de pollo preparada para venta directa', CAST(14.50 AS Decimal(10, 2)), 75, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (16, N'Triple', N'Sandwich triple preparado para venta directa', CAST(8.50 AS Decimal(10, 2)), 74, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (17, N'Galleta de chocolate', N'Galleta de chocolate para acompanamiento', CAST(5.00 AS Decimal(10, 2)), 74, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (18, N'Galleta de chispas de chocolate', N'Galleta con chispas de chocolate para acompanamiento', CAST(5.50 AS Decimal(10, 2)), 74, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (19, N'Vainilla Frapuccino', N'Bebida fria sabor vainilla con leche y hielo', CAST(13.50 AS Decimal(10, 2)), 77, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (20, N'Caramelo Frapuccino', N'Bebida fria sabor caramelo con leche y hielo', CAST(14.00 AS Decimal(10, 2)), 76, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (21, N'Fresa Frapuccino', N'Bebida fria sabor fresa con leche y hielo', CAST(13.50 AS Decimal(10, 2)), 77, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (22, N'Chocolate Blanco Frapuccino', N'Bebida fria sabor chocolate blanco con leche y hielo', CAST(14.50 AS Decimal(10, 2)), 77, 2, 3, N'Activo')
SET IDENTITY_INSERT [dbo].[PRODUCTO] OFF
GO

SET IDENTITY_INSERT [dbo].[EMPLEADO] ON 

INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (1, N'Encargado', N'Local 01', N'00000001', N'Encargado', N'Full Time', CAST(2000.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-01-10' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (2, N'Barista', N'Turno Mañana', N'00000002', N'Barista', N'Full Time', CAST(1200.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-02-15' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (3, N'Barista', N'Turno Tarde', N'00000003', N'Barista', N'Part Time', CAST(550.00 AS Decimal(10, 2)), N'Tarde', CAST(N'2025-03-01' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (4, N'Barista', N'Rotativo 01', N'00000004', N'Barista', N'Full Time', CAST(1200.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-01-22' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (5, N'Barista', N'Rotativo 02', N'00000005', N'Barista', N'Part Time', CAST(550.00 AS Decimal(10, 2)), N'Tarde', CAST(N'2025-04-05' AS Date), N'Activo')
SET IDENTITY_INSERT [dbo].[EMPLEADO] OFF
GO

SET IDENTITY_INSERT [dbo].[CLIENTE] ON 

INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (1, N'Cliente', N'General', N'000000000', N'general@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (2, N'Mateo', N'Quispe Paredes', N'912345671', N'mateo.quispe@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (3, N'Valeria', N'Salazar Benitez', N'912345672', N'valeria.salazar@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (4, N'Joaquin', N'Flores Tello', N'912345673', N'jflores@hotmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (5, N'Camila', N'Villanueva Rios', N'912345674', N'camila.vr@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (6, N'Diego', N'Mendoza Chavez', N'912345675', N'diego.mendoza@yahoo.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (7, N'Sofia', N'Cardenas Gil', N'912345676', N'sofia.cardenas@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (8, N'Sebastian', N'Alarcon Soto', N'912345677', N'salarcon@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (9, N'Daniela', N'Palacios Neyra', N'912345678', N'daniela.p@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (10, N'Rodrigo', N'Rivas Guevara', N'912345679', N'rrivas@hotmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (11, N'Luciana', N'Morales Huaman', N'912345680', N'luciana.morales@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (12, N'Alejandro', N'Torres Bazan', N'912345681', N'atorres@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (13, N'Mariana', N'Delgado Prieto', N'912345682', N'mariana.delgado@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (14, N'Gabriel', N'Herrera Vaca', N'912345683', N'gherrera@yahoo.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (15, N'Fabiana', N'Montenegro Cruz', N'912345684', N'fabiana.mc@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (16, N'Nicolas', N'Cordova Solis', N'912345685', N'ncordova@hotmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (17, N'Antonella', N'Carrillo Ponce', N'912345686', N'antonella.cp@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (18, N'Alonso', N'Paz Maldonado', N'912345687', N'alonso.paz@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (19, N'Ariana', N'Reyes Espinoza', N'912345688', N'ariana.reyes@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (20, N'Franco', N'Vargas Zegarra', N'912345689', N'fvargas@hotmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (21, N'Micaela', N'Lozano Bravo', N'912345690', N'mlozano@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (22, N'Bruno', N'Aguilar Medina', N'912345691', N'bruno.am@yahoo.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (23, N'Jimena', N'Castillo Farfan', N'912345692', N'jimenac@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (24, N'Esteban', N'Cabrera Romero', N'912345693', N'esteban.cr@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (25, N'Renata', N'Peralta Suarez', N'912345694', N'renata.peralta@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (26, N'Guillermo', N'Velasquez Osorio', N'912345695', N'gvelasquez@hotmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (27, N'Romina', N'Figueroa Nunez', N'912345696', N'romina.fn@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (28, N'Leonardo', N'Chavez Guzman', N'912345697', N'lchavez@outlook.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (29, N'Adriana', N'Guerrero Silva', N'912345698', N'adriana.gs@gmail.com')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (30, N'Renzo', N'Valdivia Campos', N'912345699', N'renzo.valdivia@gmail.com')
SET IDENTITY_INSERT [dbo].[CLIENTE] OFF
GO

SET IDENTITY_INSERT [dbo].[INVENTARIO] ON 

INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (1, 1, 67, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (2, 2, 71, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (3, 3, 74, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (4, 4, 76, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (5, 5, 74, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (6, 6, 77, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (7, 7, 71, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (8, 8, 71, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (9, 9, 73, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (10, 10, 73, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (11, 11, 73, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (12, 12, 76, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (13, 13, 75, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (14, 14, 75, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (15, 15, 75, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (16, 16, 74, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (17, 17, 74, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (18, 18, 74, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (19, 19, 77, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (20, 20, 76, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (21, 21, 77, CAST(N'2026-10-17' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (22, 22, 77, CAST(N'2026-10-17' AS Date))
SET IDENTITY_INSERT [dbo].[INVENTARIO] OFF
GO

SET IDENTITY_INSERT [dbo].[PEDIDO] ON 

INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (1, CAST(N'2026-05-10' AS Date), CAST(21.00 AS Decimal(10, 2)), N'Efectivo', 1, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (2, CAST(N'2026-05-11' AS Date), CAST(18.50 AS Decimal(10, 2)), N'Tarjeta', 2, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (3, CAST(N'2026-05-12' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Yape', 3, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (4, CAST(N'2026-05-13' AS Date), CAST(7.00 AS Decimal(10, 2)), N'Efectivo', 4, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (5, CAST(N'2026-05-14' AS Date), CAST(8.50 AS Decimal(10, 2)), N'Yape', 5, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (6, CAST(N'2026-05-16' AS Date), CAST(24.00 AS Decimal(10, 2)), N'Yape', 6, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (7, CAST(N'2026-05-18' AS Date), CAST(28.00 AS Decimal(10, 2)), N'Efectivo', 7, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (8, CAST(N'2026-05-20' AS Date), CAST(26.00 AS Decimal(10, 2)), N'Tarjeta', 8, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (9, CAST(N'2026-05-22' AS Date), CAST(15.50 AS Decimal(10, 2)), N'Yape', 9, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (10, CAST(N'2026-05-25' AS Date), CAST(25.50 AS Decimal(10, 2)), N'Plin', 10, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (11, CAST(N'2026-05-27' AS Date), CAST(23.50 AS Decimal(10, 2)), N'Efectivo', 11, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (12, CAST(N'2026-05-27' AS Date), CAST(21.00 AS Decimal(10, 2)), N'Tarjeta', 12, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (13, CAST(N'2026-05-29' AS Date), CAST(24.00 AS Decimal(10, 2)), N'Yape', 13, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (14, CAST(N'2026-05-31' AS Date), CAST(22.00 AS Decimal(10, 2)), N'Efectivo', 1, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (15, CAST(N'2026-06-02' AS Date), CAST(25.00 AS Decimal(10, 2)), N'Yape', 14, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (16, CAST(N'2026-06-04' AS Date), CAST(18.50 AS Decimal(10, 2)), N'Tarjeta', 15, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (17, CAST(N'2026-06-06' AS Date), CAST(25.50 AS Decimal(10, 2)), N'Yape', 2, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (18, CAST(N'2026-06-09' AS Date), CAST(26.50 AS Decimal(10, 2)), N'Efectivo', 16, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (19, CAST(N'2026-06-12' AS Date), CAST(22.00 AS Decimal(10, 2)), N'Plin', 17, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (20, CAST(N'2026-06-15' AS Date), CAST(26.00 AS Decimal(10, 2)), N'Tarjeta', 18, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (21, CAST(N'2026-06-18' AS Date), CAST(26.00 AS Decimal(10, 2)), N'Yape', 19, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (22, CAST(N'2026-06-20' AS Date), CAST(18.50 AS Decimal(10, 2)), N'Efectivo', 20, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (23, CAST(N'2026-06-23' AS Date), CAST(42.00 AS Decimal(10, 2)), N'Tarjeta', 3, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (24, CAST(N'2026-06-25' AS Date), CAST(22.00 AS Decimal(10, 2)), N'Yape', 21, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (25, CAST(N'2026-06-28' AS Date), CAST(23.00 AS Decimal(10, 2)), N'Plin', 22, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (26, CAST(N'2026-06-30' AS Date), CAST(13.50 AS Decimal(10, 2)), N'Efectivo', 1, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (27, CAST(N'2026-07-03' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Tarjeta', 23, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (28, CAST(N'2026-07-05' AS Date), CAST(24.00 AS Decimal(10, 2)), N'Yape', 24, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (29, CAST(N'2026-07-08' AS Date), CAST(20.50 AS Decimal(10, 2)), N'Efectivo', 4, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (30, CAST(N'2026-07-11' AS Date), CAST(20.50 AS Decimal(10, 2)), N'Plin', 25, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (31, CAST(N'2026-07-14' AS Date), CAST(24.00 AS Decimal(10, 2)), N'Tarjeta', 26, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (32, CAST(N'2026-07-17' AS Date), CAST(26.50 AS Decimal(10, 2)), N'Yape', 27, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (33, CAST(N'2026-07-20' AS Date), CAST(23.00 AS Decimal(10, 2)), N'Efectivo', 5, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (34, CAST(N'2026-07-23' AS Date), CAST(25.50 AS Decimal(10, 2)), N'Tarjeta', 28, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (35, CAST(N'2026-07-26' AS Date), CAST(22.00 AS Decimal(10, 2)), N'Yape', 29, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (36, CAST(N'2026-07-29' AS Date), CAST(27.50 AS Decimal(10, 2)), N'Plin', 30, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (37, CAST(N'2026-08-02' AS Date), CAST(33.00 AS Decimal(10, 2)), N'Tarjeta', 2, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (38, CAST(N'2026-08-05' AS Date), CAST(18.50 AS Decimal(10, 2)), N'Yape', 6, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (39, CAST(N'2026-08-08' AS Date), CAST(25.00 AS Decimal(10, 2)), N'Efectivo', 7, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (40, CAST(N'2026-08-11' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Plin', 8, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (41, CAST(N'2026-08-14' AS Date), CAST(30.50 AS Decimal(10, 2)), N'Tarjeta', 9, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (42, CAST(N'2026-08-17' AS Date), CAST(20.00 AS Decimal(10, 2)), N'Yape', 11, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (43, CAST(N'2026-08-20' AS Date), CAST(15.00 AS Decimal(10, 2)), N'Efectivo', 12, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (44, CAST(N'2026-08-23' AS Date), CAST(26.50 AS Decimal(10, 2)), N'Tarjeta', 14, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (45, CAST(N'2026-08-26' AS Date), CAST(22.50 AS Decimal(10, 2)), N'Yape', 15, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (46, CAST(N'2026-08-29' AS Date), CAST(19.00 AS Decimal(10, 2)), N'Efectivo', 1, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (47, CAST(N'2026-09-02' AS Date), CAST(20.50 AS Decimal(10, 2)), N'Yape', 17, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (48, CAST(N'2026-09-06' AS Date), CAST(26.00 AS Decimal(10, 2)), N'Tarjeta', 18, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (49, CAST(N'2026-09-10' AS Date), CAST(25.50 AS Decimal(10, 2)), N'Efectivo', 20, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (50, CAST(N'2026-09-14' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Plin', 22, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (51, CAST(N'2026-09-18' AS Date), CAST(28.00 AS Decimal(10, 2)), N'Tarjeta', 24, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (52, CAST(N'2026-09-22' AS Date), CAST(21.50 AS Decimal(10, 2)), N'Yape', 26, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (53, CAST(N'2026-09-26' AS Date), CAST(24.50 AS Decimal(10, 2)), N'Efectivo', 28, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (54, CAST(N'2026-09-29' AS Date), CAST(25.50 AS Decimal(10, 2)), N'Tarjeta', 30, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (55, CAST(N'2026-10-03' AS Date), CAST(21.00 AS Decimal(10, 2)), N'Yape', 2, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (56, CAST(N'2026-10-06' AS Date), CAST(26.50 AS Decimal(10, 2)), N'Tarjeta', 5, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (57, CAST(N'2026-10-09' AS Date), CAST(16.50 AS Decimal(10, 2)), N'Efectivo', 10, 4)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (58, CAST(N'2026-10-12' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Plin', 13, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (59, CAST(N'2026-10-15' AS Date), CAST(23.00 AS Decimal(10, 2)), N'Yape', 19, 5)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (60, CAST(N'2026-10-17' AS Date), CAST(18.50 AS Decimal(10, 2)), N'Efectivo', 1, 2)
SET IDENTITY_INSERT [dbo].[PEDIDO] OFF
GO

SET IDENTITY_INSERT [dbo].[DETALLE_PEDIDO] ON 

INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (1, 1, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (2, 1, 11, 1, CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (3, 2, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (4, 2, 8, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (5, 3, 7, 2, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (6, 4, 8, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (7, 5, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (8, 6, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (9, 6, 17, 2, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (10, 7, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (11, 7, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (12, 8, 8, 2, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (13, 8, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (14, 9, 16, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (15, 9, 12, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (16, 10, 4, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (17, 10, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (18, 11, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (19, 11, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (20, 12, 4, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (21, 12, 5, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (22, 13, 3, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (23, 13, 18, 2, CAST(11.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (24, 14, 19, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (25, 14, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (26, 15, 5, 2, CAST(16.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (27, 15, 11, 1, CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (28, 16, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (29, 16, 12, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (30, 17, 14, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (31, 17, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (32, 18, 20, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (33, 18, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (34, 19, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (35, 19, 16, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (36, 20, 3, 2, CAST(26.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (37, 21, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (38, 21, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (39, 22, 21, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (40, 22, 17, 1, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (41, 23, 1, 2, CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (42, 23, 11, 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (43, 24, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (44, 24, 6, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (45, 25, 22, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (46, 25, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (47, 26, 5, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (48, 26, 18, 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (49, 27, 14, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (50, 27, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (51, 28, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (52, 28, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (53, 29, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (54, 29, 16, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (55, 30, 19, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (56, 30, 8, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (57, 31, 20, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (58, 31, 17, 2, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (59, 32, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (60, 32, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (61, 33, 6, 2, CAST(16.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (62, 33, 12, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (63, 34, 3, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (64, 34, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (65, 35, 21, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (66, 35, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (67, 36, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (68, 36, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (69, 37, 1, 2, CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (70, 37, 11, 1, CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (71, 38, 4, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (72, 38, 18, 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (73, 39, 14, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (74, 39, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (75, 40, 22, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (76, 40, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (77, 41, 16, 2, CAST(17.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (78, 41, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (79, 42, 3, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (80, 42, 8, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (81, 43, 5, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (82, 43, 12, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (83, 44, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (84, 44, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (85, 45, 20, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (86, 45, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (87, 46, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (88, 46, 17, 1, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (89, 47, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (90, 47, 11, 1, CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (91, 48, 19, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (92, 48, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (93, 49, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (94, 49, 14, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (95, 50, 4, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (96, 50, 8, 2, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (97, 51, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (98, 51, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (99, 52, 3, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (100, 52, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (101, 53, 21, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (102, 53, 18, 2, CAST(11.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (103, 54, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (104, 54, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (105, 55, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (106, 55, 11, 1, CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (107, 56, 20, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (108, 56, 10, 1, CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (109, 57, 16, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (110, 57, 5, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (111, 58, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (112, 58, 14, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (113, 59, 22, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (114, 59, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (115, 60, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (116, 60, 8, 1, CAST(7.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DETALLE_PEDIDO] OFF
GO

SET ANSI_PADDING ON
GO
/****** Objeto: Index [UQ_EMPLEADO_dni] Fecha de script: 1/07/2026 00:47:53 ******/
ALTER TABLE [dbo].[EMPLEADO] ADD  CONSTRAINT [UQ_EMPLEADO_dni] UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Objeto: Index [UQ_INVENTARIO_id_producto] Fecha de script: 1/07/2026 00:47:53 ******/
ALTER TABLE [dbo].[INVENTARIO] ADD  CONSTRAINT [UQ_INVENTARIO_id_producto] UNIQUE NONCLUSTERED 
(
	[id_producto] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_DETALLE_PEDIDO_PEDIDO] FOREIGN KEY([id_pedido])
REFERENCES [dbo].[PEDIDO] ([id_pedido])
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO] CHECK CONSTRAINT [FK_DETALLE_PEDIDO_PEDIDO]
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_DETALLE_PEDIDO_PRODUCTO] FOREIGN KEY([id_producto])
REFERENCES [dbo].[PRODUCTO] ([id_producto])
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO] CHECK CONSTRAINT [FK_DETALLE_PEDIDO_PRODUCTO]
GO
ALTER TABLE [dbo].[INVENTARIO]  WITH CHECK ADD  CONSTRAINT [FK_INVENTARIO_PRODUCTO] FOREIGN KEY([id_producto])
REFERENCES [dbo].[PRODUCTO] ([id_producto])
GO
ALTER TABLE [dbo].[INVENTARIO] CHECK CONSTRAINT [FK_INVENTARIO_PRODUCTO]
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_PEDIDO_CLIENTE] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[CLIENTE] ([id_cliente])
GO
ALTER TABLE [dbo].[PEDIDO] CHECK CONSTRAINT [FK_PEDIDO_CLIENTE]
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD  CONSTRAINT [FK_PEDIDO_EMPLEADO] FOREIGN KEY([id_empleado])
REFERENCES [dbo].[EMPLEADO] ([id_empleado])
GO
ALTER TABLE [dbo].[PEDIDO] CHECK CONSTRAINT [FK_PEDIDO_EMPLEADO]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_CATEGORIA] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[CATEGORIA] ([id_categoria])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_CATEGORIA]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCTO_PROVEEDOR] FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[PROVEEDOR] ([id_proveedor])
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [FK_PRODUCTO_PROVEEDOR]
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO]  WITH CHECK ADD  CONSTRAINT [CK_DETALLE_PEDIDO_cantidad] CHECK  (([cantidad]>(0)))
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO] CHECK CONSTRAINT [CK_DETALLE_PEDIDO_cantidad]
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO]  WITH CHECK ADD  CONSTRAINT [CK_DETALLE_PEDIDO_subtotal] CHECK  (([subtotal]>=(0)))
GO
ALTER TABLE [dbo].[DETALLE_PEDIDO] CHECK CONSTRAINT [CK_DETALLE_PEDIDO_subtotal]
GO
ALTER TABLE [dbo].[EMPLEADO]  WITH CHECK ADD  CONSTRAINT [CK_EMPLEADO_sueldo] CHECK  (([sueldo]>=(0)))
GO
ALTER TABLE [dbo].[EMPLEADO] CHECK CONSTRAINT [CK_EMPLEADO_sueldo]
GO
ALTER TABLE [dbo].[EMPLEADO]  WITH CHECK ADD  CONSTRAINT [CK_EMPLEADO_tipo_contrato] CHECK  (([tipo_contrato]='Part Time' OR [tipo_contrato]='Full Time'))
GO
ALTER TABLE [dbo].[EMPLEADO] CHECK CONSTRAINT [CK_EMPLEADO_tipo_contrato]
GO
ALTER TABLE [dbo].[INVENTARIO]  WITH CHECK ADD  CONSTRAINT [CK_INVENTARIO_cantidad_disponible] CHECK  (([cantidad_disponible]>=(0)))
GO
ALTER TABLE [dbo].[INVENTARIO] CHECK CONSTRAINT [CK_INVENTARIO_cantidad_disponible]
GO
ALTER TABLE [dbo].[PEDIDO]  WITH CHECK ADD  CONSTRAINT [CK_PEDIDO_total] CHECK  (([total]>=(0)))
GO
ALTER TABLE [dbo].[PEDIDO] CHECK CONSTRAINT [CK_PEDIDO_total]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [CK_PRODUCTO_precio] CHECK  (([precio]>=(0)))
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [CK_PRODUCTO_precio]
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD  CONSTRAINT [CK_PRODUCTO_stock] CHECK  (([stock]>=(0)))
GO
ALTER TABLE [dbo].[PRODUCTO] CHECK CONSTRAINT [CK_PRODUCTO_stock]
GO
/****** Objeto: StoredProcedure [dbo].[SP_ACTUALIZAR_STOCK_PRODUCTO] Fecha de script: 1/07/2026 00:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZAR_STOCK_PRODUCTO]
    @id_producto INT,
    @nuevo_stock INT
AS
BEGIN
    IF @nuevo_stock < 0
    BEGIN
        RAISERROR('El stock no puede ser negativo.', 16, 1)
        RETURN
    END

    UPDATE PRODUCTO
    SET stock = @nuevo_stock
    WHERE id_producto = @id_producto

    UPDATE INVENTARIO
    SET cantidad_disponible = @nuevo_stock,
        fecha_actualizacion = CAST(GETDATE() AS DATE)
    WHERE id_producto = @id_producto
END
GO
/****** Objeto: StoredProcedure [dbo].[SP_LISTAR_PRODUCTOS_POR_CATEGORIA] Fecha de script: 1/07/2026 00:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LISTAR_PRODUCTOS_POR_CATEGORIA]
    @id_categoria INT
AS
BEGIN
    SELECT
        id_producto,
        nombre_producto,
        descripcion,
        precio,
        stock,
        estado
    FROM PRODUCTO
    WHERE id_categoria = @id_categoria
END
GO
/****** Objeto: StoredProcedure [dbo].[SP_REGISTRAR_CLIENTE] Fecha de script: 1/07/2026 00:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_CLIENTE]
    @nombres VARCHAR(80),
    @apellidos VARCHAR(80),
    @telefono VARCHAR(20),
    @correo VARCHAR(100)
AS
BEGIN
    INSERT INTO CLIENTE (nombres, apellidos, telefono, correo)
    VALUES (@nombres, @apellidos, @telefono, @correo)
END
GO
/****** Objeto: StoredProcedure [dbo].[SP_REGISTRAR_PEDIDO] Fecha de script: 1/07/2026 00:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_REGISTRAR_PEDIDO]
    @fecha_pedido DATE,
    @total DECIMAL(10,2),
    @metodo_pago VARCHAR(40),
    @id_cliente INT,
    @id_empleado INT
AS
BEGIN
    INSERT INTO PEDIDO (fecha_pedido, total, metodo_pago, id_cliente, id_empleado)
    VALUES (@fecha_pedido, @total, @metodo_pago, @id_cliente, @id_empleado)
END
GO
