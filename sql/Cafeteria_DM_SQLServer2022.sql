-- Adaptacion para SQL Server 2022. Ejecutar en una instancia local autorizada.
-- No elimina bases existentes.
USE [master];
GO
IF DB_ID(N'Cafeteria_DM') IS NOT NULL
    THROW 50001, 'Cafeteria_DM ya existe. Detenga la ejecucion y revise la base existente.', 1;
GO
CREATE DATABASE [Cafeteria_DM];
GO
ALTER DATABASE [Cafeteria_DM] SET COMPATIBILITY_LEVEL = 160;
GO
USE [Cafeteria_DM]
GO
/****** Objeto: Table [dbo].[Dim_Cliente] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Cliente](
	[id_cliente_sk] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente_bk] [int] NOT NULL,
	[nombre_completo] [varchar](160) NOT NULL,
	[telefono] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Dim_Empleado] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Empleado](
	[id_empleado_sk] [int] IDENTITY(1,1) NOT NULL,
	[id_empleado_bk] [int] NOT NULL,
	[nombre_completo] [varchar](160) NOT NULL,
	[cargo] [varchar](60) NOT NULL,
	[turno] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_empleado_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Dim_MetodoPago] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_MetodoPago](
	[id_metodo_pago_sk] [int] IDENTITY(1,1) NOT NULL,
	[metodo_pago] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_metodo_pago_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Dim_Producto] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Producto](
	[id_producto_sk] [int] IDENTITY(1,1) NOT NULL,
	[id_producto_bk] [int] NOT NULL,
	[nombre_producto] [varchar](100) NOT NULL,
	[categoria] [varchar](80) NOT NULL,
	[precio_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Dim_Tiempo] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Tiempo](
	[id_tiempo_sk] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[anio] [int] NOT NULL,
	[mes] [int] NOT NULL,
	[nombre_mes] [varchar](20) NOT NULL,
	[dia] [int] NOT NULL,
	[dia_semana] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tiempo_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Fact_Ventas] Fecha de script: 6/10/2026 12:47:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Ventas](
	[id_venta_sk] [int] IDENTITY(1,1) NOT NULL,
	[id_tiempo_sk] [int] NOT NULL,
	[id_producto_sk] [int] NOT NULL,
	[id_empleado_sk] [int] NOT NULL,
	[id_cliente_sk] [int] NOT NULL,
	[id_metodo_pago_sk] [int] NOT NULL,
	[id_pedido_original] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[monto_total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_venta_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Dim_Cliente] ON 

INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (0, 1, N'Valeria Quispe Flores', N'987654321')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (1, 2, N'Diego Huaman Rojas', N'976543210')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (2, 3, N'Camila Condori Mamani', N'965432109')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (3, 4, N'Sebastian Chavez Cardenas', N'954321098')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (4, 5, N'Luciana Arias Salazar', N'943210987')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (5, 6, N'Brenda Quispe Huaman', N'987321654')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (6, 7, N'Renato Cordova Rojas', N'986456123')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (7, 8, N'Milagros Paredes Flores', N'985654321')
INSERT [dbo].[Dim_Cliente] ([id_cliente_sk], [id_cliente_bk], [nombre_completo], [telefono]) VALUES (8, 9, N'Anthony Tapia Mamani', N'984789123')
SET IDENTITY_INSERT [dbo].[Dim_Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Dim_Empleado] ON 

INSERT [dbo].[Dim_Empleado] ([id_empleado_sk], [id_empleado_bk], [nombre_completo], [cargo], [turno]) VALUES (0, 1, N'Mariana Vega', N'Encargado', N'Mañana')
INSERT [dbo].[Dim_Empleado] ([id_empleado_sk], [id_empleado_bk], [nombre_completo], [cargo], [turno]) VALUES (1, 2, N'Jose Castillo', N'Barista', N'Mañana')
INSERT [dbo].[Dim_Empleado] ([id_empleado_sk], [id_empleado_bk], [nombre_completo], [cargo], [turno]) VALUES (2, 3, N'Paola Mendoza', N'Barista', N'Mañana')
INSERT [dbo].[Dim_Empleado] ([id_empleado_sk], [id_empleado_bk], [nombre_completo], [cargo], [turno]) VALUES (3, 4, N'Ruben Flores', N'Barista', N'Mañana')
INSERT [dbo].[Dim_Empleado] ([id_empleado_sk], [id_empleado_bk], [nombre_completo], [cargo], [turno]) VALUES (4, 5, N'Elena Paredes', N'Barista', N'Mañana')
SET IDENTITY_INSERT [dbo].[Dim_Empleado] OFF
GO
SET IDENTITY_INSERT [dbo].[Dim_MetodoPago] ON 

INSERT [dbo].[Dim_MetodoPago] ([id_metodo_pago_sk], [metodo_pago]) VALUES (0, N'Efectivo')
INSERT [dbo].[Dim_MetodoPago] ([id_metodo_pago_sk], [metodo_pago]) VALUES (1, N'Tarjeta')
INSERT [dbo].[Dim_MetodoPago] ([id_metodo_pago_sk], [metodo_pago]) VALUES (2, N'Yape')
SET IDENTITY_INSERT [dbo].[Dim_MetodoPago] OFF
GO
SET IDENTITY_INSERT [dbo].[Dim_Producto] ON 

INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (0, 1, N'Latte', N'Lattes/Cappuccino', CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (1, 2, N'Cappuccino', N'Lattes/Cappuccino', CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (2, 3, N'Mocha', N'Lattes/Cappuccino', CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (3, 4, N'Mocha Frapuccino', N'Frappuccinos', CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (4, 5, N'Espresso', N'Lattes/Cappuccino', CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (5, 6, N'Espresso 2', N'Lattes/Cappuccino', CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (6, 7, N'Cold Brew', N'Frappuccinos', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (7, 8, N'Muffins de naranja', N'Postres', CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (8, 9, N'Brownies', N'Postres', CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (9, 10, N'Cheesecake', N'Postres', CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (10, 11, N'Croissants', N'Postres', CAST(9.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (11, 12, N'Muffins de manzana', N'Postres', CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (12, 13, N'Panino Vesubio', N'Panaderia', CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (13, 14, N'Chicken Panino', N'Panaderia', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (14, 15, N'Chicken Ciabatta', N'Panaderia', CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (15, 16, N'Triple', N'Panaderia', CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (16, 17, N'Galleta de chocolate', N'Postres', CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (17, 18, N'Galleta de chispas de chocolate', N'Postres', CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (18, 19, N'Vainilla Frapuccino', N'Frappuccinos', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (19, 20, N'Caramelo Frapuccino', N'Frappuccinos', CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (20, 21, N'Fresa Frapuccino', N'Frappuccinos', CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[Dim_Producto] ([id_producto_sk], [id_producto_bk], [nombre_producto], [categoria], [precio_unitario]) VALUES (21, 22, N'Chocolate Blanco Frapuccino', N'Frappuccinos', CAST(14.50 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Dim_Producto] OFF
GO
INSERT [dbo].[Dim_Tiempo] ([id_tiempo_sk], [fecha], [anio], [mes], [nombre_mes], [dia], [dia_semana]) VALUES (20260527, CAST(N'2026-05-27' AS Date), 2026, 5, N'May', 27, N'Wednesday')
INSERT [dbo].[Dim_Tiempo] ([id_tiempo_sk], [fecha], [anio], [mes], [nombre_mes], [dia], [dia_semana]) VALUES (20260625, CAST(N'2026-06-25' AS Date), 2026, 6, N'June', 25, N'Thursday')
GO
SET IDENTITY_INSERT [dbo].[Fact_Ventas] ON 

INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (1, 20260527, 0, 1, 0, 0, 1, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (2, 20260625, 0, 2, 7, 1, 8, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (3, 20260527, 1, 1, 0, 0, 1, 1, CAST(11.50 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (4, 20260527, 3, 0, 1, 1, 2, 1, CAST(13.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (5, 20260527, 4, 0, 1, 1, 2, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (6, 20260527, 6, 1, 2, 2, 3, 2, CAST(27.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (7, 20260625, 6, 1, 6, 0, 7, 1, CAST(13.50 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (8, 20260527, 7, 1, 3, 0, 4, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (9, 20260625, 7, 2, 7, 1, 8, 2, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (10, 20260527, 8, 2, 4, 2, 5, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (11, 20260625, 11, 3, 8, 2, 9, 1, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (12, 20260625, 12, 0, 5, 2, 6, 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (13, 20260625, 14, 1, 6, 0, 7, 1, CAST(14.50 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (14, 20260625, 15, 3, 8, 2, 9, 1, CAST(8.50 AS Decimal(10, 2)))
INSERT [dbo].[Fact_Ventas] ([id_venta_sk], [id_tiempo_sk], [id_producto_sk], [id_empleado_sk], [id_cliente_sk], [id_metodo_pago_sk], [id_pedido_original], [cantidad], [monto_total]) VALUES (15, 20260625, 16, 0, 5, 2, 6, 2, CAST(10.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Fact_Ventas] OFF
GO
ALTER TABLE [dbo].[Fact_Ventas]  WITH CHECK ADD FOREIGN KEY([id_cliente_sk])
REFERENCES [dbo].[Dim_Cliente] ([id_cliente_sk])
GO
ALTER TABLE [dbo].[Fact_Ventas]  WITH CHECK ADD FOREIGN KEY([id_empleado_sk])
REFERENCES [dbo].[Dim_Empleado] ([id_empleado_sk])
GO
ALTER TABLE [dbo].[Fact_Ventas]  WITH CHECK ADD FOREIGN KEY([id_metodo_pago_sk])
REFERENCES [dbo].[Dim_MetodoPago] ([id_metodo_pago_sk])
GO
ALTER TABLE [dbo].[Fact_Ventas]  WITH CHECK ADD FOREIGN KEY([id_producto_sk])
REFERENCES [dbo].[Dim_Producto] ([id_producto_sk])
GO
ALTER TABLE [dbo].[Fact_Ventas]  WITH CHECK ADD FOREIGN KEY([id_tiempo_sk])
REFERENCES [dbo].[Dim_Tiempo] ([id_tiempo_sk])
GO

