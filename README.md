# Cafetería Aurora — Sistema POS & Solución de Inteligencia de Negocios (Power BI)

![Estado del Proyecto](https://img.shields.io/badge/Estado-Finalizado-success?style=for-the-badge)
![Tecnologías](https://img.shields.io/badge/Stack-C%23_%7C_SQL_Server_%7C_Power_BI-blue?style=for-the-badge)
![Licencia](https://img.shields.io/badge/Uso-Académico-orange?style=for-the-badge)

> **Proyecto Final:** Base de Datos Avanzadas y Big Data  
> **NRC:** 26046 | **Período:** 2026-2  
> **Docente:** Victor Isaac Chavez Bardales  

---

## 👥 Integrantes del Equipo
* **Aranda Alvarado, Anderson Leithon** (100%)
* **Becerra Chombo, Luis Alfredo** (100%)
* **Diaz Rossello, Angel Enrrique** (100%)
* **Navarro Barrueto, Johann Roberto** (100%)
* **Soto Principe, Gerson Manuel** (100%)

---

## 📋 Descripción del Proyecto
El proyecto **Cafetería Aurora** es una solución integral de ingeniería que articula:
1. Un **Sistema Transaccional (OLTP)** de Punto de Venta (POS) y control de inventario desarrollado en **C# (Windows Forms / .NET Framework 4.7.2)** y **SQL Server**.
2. Una **Solución de Inteligencia de Negocios (BI)** basada en un **Data Mart dimensional (Star Schema / Modelo Estrella)** alimentado por un proceso ETL automatizado en T-SQL.
3. Un **Dashboard Analítico e Interactivo en Power BI** orientado a la toma de decisiones gerenciales sobre ventas, rotación de productos, rendimiento de baristas y horas pico.
4. Un sistema de **Auditoría DDL** con triggers a nivel de base de datos y blindaje de seguridad contra borrado no autorizado.

---

## 🔒 Declaración Ética y Privacidad de Datos (Alineación ABET SO 6)
En cumplimiento estricto con las políticas de tratamiento ético, legal y seguro de la información:
* **Datos 100% Sintéticos / Anónimos:** Todos los registros de clientes, números de teléfono y números de DNI incluidos en los scripts son ficticios (*Mock Data* con fines exclusivamente educativos y de prueba). No se utilizan datos de personas reales.
* **Cero Credenciales Sensibles en Código:** El archivo `App.config` y los scripts SQL han sido sanitizados para operar de forma segura en entornos locales (`.\SQLEXPRESS`) mediante autenticación integrada de Windows, sin exponer contraseñas ni cadenas de producción de la nube.

---

## 🏗️ Arquitectura de la Solución

```
[ Punto de Venta C# POS ] 
           │
           ▼ (Transacciones en tiempo real)
[ BD_Cafeteria (OLTP) ] ── (14 tablas normalizadas en 3FN)
           │
           ▼ (Proceso ETL: V3_DATA_MART_ETL.sql)
[ Cafeteria_DM (OLAP) ] ── (Modelo Estrella: 1 Fact Table + 5 Dimensiones)
           │
           ▼ (Consultas y Cross-Filtering)
[ Power BI Desktop Dashboard ] ── (KPIs, Análisis por Turno, Producto y Métodos de Pago)
```

---

## 📂 Estructura del Repositorio

```text
├── CAFETERIA/                  # Aplicación de Escritorio en C# (.NET Framework 4.7.2)
│   └── guicafeteria/
│       ├── guicafeteria.sln    # Solución de Visual Studio
│       ├── FormPanel.cs        # Menú principal y navegación
│       ├── Pedido.cs           # Pantalla de ventas (POS) y emisión de tickets
│       ├── FrmEncargado.cs     # Módulo de administración e inventario
│       └── App.config          # Configuración de conexión sanitizada para desarrollo local
├── sql/                        # Scripts SQL ordenados y modulares
│   ├── BD_CAFETERIA.sql        # Esquema relacional transaccional (OLTP)
│   ├── V2_ROLES_USUARIOS.sql   # Gestión de roles, usuarios con hash SHA2-256 y login SP
│   ├── V3_DATA_MART_ETL.sql    # Creación de Cafeteria_DM (Star Schema) y Pipeline ETL
│   ├── V4_USUARIO_DESARROLLADOR.sql # Perfil DDL restringido (sin permisos de DROP DATABASE)
│   └── V5_AUDITORIA_DDL.sql    # Trigger DDL a nivel de base de datos y LOG_AUDITORIA_DDL
├── presentacion_powerbi_cafeteria.html # Presentación interactiva en HTML para la sustentación
├── .gitignore                  # Exclusión de binarios, .vs/, compilados y temporales
└── README.md                   # Documentación principal del proyecto
```

---

## 🚀 Guía de Despliegue y Ejecución

### 1. Base de Datos Transaccional (SQL Server)
1. Abrir **SQL Server Management Studio (SSMS)** y conectarse a la instancia local (`.\SQLEXPRESS`).
2. Ejecutar los scripts en el siguiente orden:
   ```sql
   -- 1. Crear esquema transaccional
   sql/BD_CAFETERIA.sql

   -- 2. Configurar roles y procedimiento de autenticación segura
   sql/V2_ROLES_USUARIOS.sql

   -- 3. Crear Data Mart dimensional y ejecutar proceso ETL
   sql/V3_DATA_MART_ETL.sql

   -- 4. Instalar trigger y tabla de auditoría DDL
   sql/V5_AUDITORIA_DDL.sql
   ```

### 2. Aplicación de Escritorio C# (POS)
1. Abrir `CAFETERIA/guicafeteria/guicafeteria.sln` con **Visual Studio 2019 / 2022**.
2. Verificar que `App.config` apunte a `.\SQLEXPRESS` y `BD_Cafeteria`.
3. Compilar y ejecutar con `F5`.

### 3. Modelo Analítico en Power BI
1. Abrir **Power BI Desktop**.
2. Conectar a SQL Server local:
   * **Servidor:** `.\SQLEXPRESS`
   * **Base de datos:** `Cafeteria_DM`
3. Cargar las tablas del Modelo Estrella:
   * `Fact_Ventas` (Centro)
   * `Dim_Tiempo`, `Dim_Producto`, `Dim_Empleado`, `Dim_Cliente`, `Dim_MetodoPago`
4. Verificar las relaciones activas de cardinalidad `1:N` con filtro cruzado en dirección única.

---

## 📊 Modelo Estrella (Star Schema)

* **Tabla de Hechos:**
  * `Fact_Ventas`: Almacena las métricas cuantitativas (`monto_total`, `cantidad_unidades`, `precio_unitario`).
* **Dimensiones:**
  * `Dim_Tiempo`: Atributos temporales (Año, Mes, Trimestre, Día de semana, Fin de semana).
  * `Dim_Producto`: Información del producto y categoría desnormalizada.
  * `Dim_Empleado`: Datos del barista/encargado y turno asignado.
  * `Dim_Cliente`: Segmentación de clientes (General / Frecuente).
  * `Dim_MetodoPago`: Clasificación por método de pago (Efectivo, Yape/Plin, Tarjeta).

---

## 🎯 KPIs Implementados
* **Ingresos Totales (S/.):** Volumen acumulado de ventas en el período evaluado.
* **Ticket Promedio:** Gasto medio por transacción (`Total Ventas / Total Pedidos`).
* **Pareto de Productos:** Identificación del 20% de productos que generan el 80% de ingresos.
* **Ventas por Turno:** Comparativa del volumen comercial entre el turno mañana y turno tarde.
* **Penetración de Medios Digitales:** Ratio de pagos digitales frente a efectivo.
