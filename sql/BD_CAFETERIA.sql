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
INNER JOIN PROVEEDOR pr ON p.id_proveedor = pr.id_proveedor;
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
INNER JOIN EMPLEADO e ON pe.id_empleado = e.id_empleado;
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
INNER JOIN PRODUCTO p ON i.id_producto = p.id_producto;
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
SET IDENTITY_INSERT [dbo].[CLIENTE] ON 

INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (1, N'Cliente', N'General', N'000000000', N'general@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (2, N'Cliente', N'Frecuente 01', N'900000001', N'frecuente01@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (3, N'Cliente', N'Frecuente 02', N'900000002', N'frecuente02@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (4, N'Cliente', N'Frecuente 03', N'900000003', N'frecuente03@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (5, N'Cliente', N'Frecuente 04', N'900000004', N'frecuente04@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (6, N'Cliente', N'Frecuente 05', N'900000005', N'frecuente05@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (7, N'Cliente', N'Frecuente 06', N'900000006', N'frecuente06@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (8, N'Cliente', N'Frecuente 07', N'900000007', N'frecuente07@cafeteria.pe')
INSERT [dbo].[CLIENTE] ([id_cliente], [nombres], [apellidos], [telefono], [correo]) VALUES (9, N'Cliente', N'Frecuente 08', N'900000008', N'frecuente08@cafeteria.pe')
SET IDENTITY_INSERT [dbo].[CLIENTE] OFF
GO
SET IDENTITY_INSERT [dbo].[DETALLE_PEDIDO] ON 

INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (1, 4, 8, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (2, 5, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (3, 1, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (4, 1, 2, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (5, 2, 4, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (6, 2, 5, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (7, 3, 7, 2, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (8, 6, 13, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (9, 6, 17, 2, CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (10, 7, 15, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (11, 7, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (12, 8, 8, 2, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (13, 8, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (14, 9, 16, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[DETALLE_PEDIDO] ([id_detalle], [id_pedido], [id_producto], [cantidad], [subtotal]) VALUES (15, 9, 12, 1, CAST(7.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DETALLE_PEDIDO] OFF
GO
SET IDENTITY_INSERT [dbo].[EMPLEADO] ON 

INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (1, N'Encargado', N'Local 01', N'00000001', N'Encargado', N'Full Time', CAST(2000.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-01-10' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (2, N'Barista', N'Turno Mañana', N'00000002', N'Barista', N'Full Time', CAST(1200.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-02-15' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (3, N'Barista', N'Turno Tarde', N'00000003', N'Barista', N'Part Time', CAST(550.00 AS Decimal(10, 2)), N'Tarde', CAST(N'2025-03-01' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (4, N'Barista', N'Rotativo 01', N'00000004', N'Barista', N'Full Time', CAST(1200.00 AS Decimal(10, 2)), N'Mañana', CAST(N'2025-01-22' AS Date), N'Activo')
INSERT [dbo].[EMPLEADO] ([id_empleado], [nombres], [apellidos], [dni], [cargo], [tipo_contrato], [sueldo], [turno], [fecha_ingreso], [estado]) VALUES (5, N'Barista', N'Rotativo 02', N'00000005', N'Barista', N'Part Time', CAST(550.00 AS Decimal(10, 2)), N'Tarde', CAST(N'2025-04-05' AS Date), N'Activo')
SET IDENTITY_INSERT [dbo].[EMPLEADO] OFF
GO
SET IDENTITY_INSERT [dbo].[INVENTARIO] ON 

INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (1, 1, 49, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (2, 2, 45, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (3, 3, 40, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (4, 4, 40, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (5, 5, 60, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (6, 6, 60, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (7, 7, 29, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (8, 8, 23, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (9, 9, 20, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (10, 10, 15, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (11, 11, 22, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (12, 12, 24, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (13, 13, 19, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (14, 14, 20, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (15, 15, 19, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (16, 16, 24, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (17, 17, 28, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (18, 18, 30, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (19, 19, 30, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (20, 20, 30, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (21, 21, 30, CAST(N'2026-06-25' AS Date))
INSERT [dbo].[INVENTARIO] ([id_inventario], [id_producto], [cantidad_disponible], [fecha_actualizacion]) VALUES (22, 22, 30, CAST(N'2026-06-25' AS Date))
SET IDENTITY_INSERT [dbo].[INVENTARIO] OFF
GO
SET IDENTITY_INSERT [dbo].[PEDIDO] ON 

INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (1, CAST(N'2026-05-27' AS Date), CAST(23.50 AS Decimal(10, 2)), N'Efectivo', 1, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (2, CAST(N'2026-05-27' AS Date), CAST(21.00 AS Decimal(10, 2)), N'Tarjeta', 2, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (3, CAST(N'2026-05-27' AS Date), CAST(27.00 AS Decimal(10, 2)), N'Yape', 3, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (4, CAST(N'2026-05-27' AS Date), CAST(7.00 AS Decimal(10, 2)), N'Efectivo', 4, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (5, CAST(N'2026-05-27' AS Date), CAST(8.50 AS Decimal(10, 2)), N'Yape', 5, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (6, CAST(N'2026-06-25' AS Date), CAST(24.00 AS Decimal(10, 2)), N'Yape', 6, 1)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (7, CAST(N'2026-06-25' AS Date), CAST(28.00 AS Decimal(10, 2)), N'Efectivo', 7, 2)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (8, CAST(N'2026-06-25' AS Date), CAST(26.00 AS Decimal(10, 2)), N'Tarjeta', 8, 3)
INSERT [dbo].[PEDIDO] ([id_pedido], [fecha_pedido], [total], [metodo_pago], [id_cliente], [id_empleado]) VALUES (9, CAST(N'2026-06-25' AS Date), CAST(15.50 AS Decimal(10, 2)), N'Yape', 9, 4)
SET IDENTITY_INSERT [dbo].[PEDIDO] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTO] ON 

INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (1, N'Latte', N'Bebida caliente con cafe espresso y leche vaporizada', CAST(12.00 AS Decimal(10, 2)), 49, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (2, N'Cappuccino', N'Bebida caliente con espresso, leche y espuma', CAST(11.50 AS Decimal(10, 2)), 45, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (3, N'Mocha', N'Bebida caliente con cafe, leche y chocolate', CAST(13.00 AS Decimal(10, 2)), 40, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (4, N'Mocha Frapuccino', N'Bebida fria con cafe, leche, chocolate y hielo', CAST(13.00 AS Decimal(10, 2)), 40, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (5, N'Espresso', N'Cafe concentrado servido en porcion pequeña', CAST(8.00 AS Decimal(10, 2)), 60, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (6, N'Espresso 2', N'Cafe concentrado servido en porcion doble pequeña', CAST(8.00 AS Decimal(10, 2)), 60, 1, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (7, N'Cold Brew', N'Cafe frio preparado por infusion lenta', CAST(13.50 AS Decimal(10, 2)), 29, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (8, N'Muffins de naranja', N'Muffin de naranja en porcion individual', CAST(7.00 AS Decimal(10, 2)), 23, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (9, N'Brownies', N'Postre de chocolate en porcion individual', CAST(8.50 AS Decimal(10, 2)), 20, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (10, N'Cheesecake', N'Postre frio a base de queso crema', CAST(12.50 AS Decimal(10, 2)), 15, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (11, N'Croissants', N'Postre de masa hojaldrada para acompanamiento', CAST(9.00 AS Decimal(10, 2)), 22, 4, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (12, N'Muffins de manzana', N'Muffin de manzana en porcion individual', CAST(7.00 AS Decimal(10, 2)), 24, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (13, N'Panino Vesubio', N'Panino Vesubio preparado para venta directa', CAST(14.00 AS Decimal(10, 2)), 19, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (14, N'Chicken Panino', N'Panino de pollo preparado para venta directa', CAST(13.50 AS Decimal(10, 2)), 20, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (15, N'Chicken Ciabatta', N'Ciabatta de pollo preparada para venta directa', CAST(14.50 AS Decimal(10, 2)), 19, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (16, N'Triple', N'Sandwich triple preparado para venta directa', CAST(8.50 AS Decimal(10, 2)), 24, 3, 2, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (17, N'Galleta de chocolate', N'Galleta de chocolate para acompanamiento', CAST(5.00 AS Decimal(10, 2)), 28, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (18, N'Galleta de chispas de chocolate', N'Galleta con chispas de chocolate para acompanamiento', CAST(5.50 AS Decimal(10, 2)), 30, 4, 1, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (19, N'Vainilla Frapuccino', N'Bebida fria sabor vainilla con leche y hielo', CAST(13.50 AS Decimal(10, 2)), 30, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (20, N'Caramelo Frapuccino', N'Bebida fria sabor caramelo con leche y hielo', CAST(14.00 AS Decimal(10, 2)), 30, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (21, N'Fresa Frapuccino', N'Bebida fria sabor fresa con leche y hielo', CAST(13.50 AS Decimal(10, 2)), 30, 2, 3, N'Activo')
INSERT [dbo].[PRODUCTO] ([id_producto], [nombre_producto], [descripcion], [precio], [stock], [id_categoria], [id_proveedor], [estado]) VALUES (22, N'Chocolate Blanco Frapuccino', N'Bebida fria sabor chocolate blanco con leche y hielo', CAST(14.50 AS Decimal(10, 2)), 30, 2, 3, N'Activo')
SET IDENTITY_INSERT [dbo].[PRODUCTO] OFF
GO
SET IDENTITY_INSERT [dbo].[PROVEEDOR] ON 

INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (1, N'Maria Almenara', N'Productos de panaderia y postres', N'989111222', N'ventas@mariaalmenara.com')
INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (2, N'Cocina Central', N'Alimentos y productos preparados', N'989333444', N'contacto@cocinacentral.com')
INSERT [dbo].[PROVEEDOR] ([id_proveedor], [nombre_proveedor], [tipo_suministro], [telefono], [correo]) VALUES (3, N'Ransa', N'Suministros e insumos esenciales para bebidas y funcionamiento general', N'989555666', N'atencion@ransa.com')
SET IDENTITY_INSERT [dbo].[PROVEEDOR] OFF
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
        RAISERROR('El stock no puede ser negativo.', 16, 1);
        RETURN;
    END;

    UPDATE PRODUCTO
    SET stock = @nuevo_stock
    WHERE id_producto = @id_producto;

    UPDATE INVENTARIO
    SET cantidad_disponible = @nuevo_stock,
        fecha_actualizacion = CAST(GETDATE() AS DATE)
    WHERE id_producto = @id_producto;
END;
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
    WHERE id_categoria = @id_categoria;
END;
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
    VALUES (@nombres, @apellidos, @telefono, @correo);
END;
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
    VALUES (@fecha_pedido, @total, @metodo_pago, @id_cliente, @id_empleado);
END;
GO
