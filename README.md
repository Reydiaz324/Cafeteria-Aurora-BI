# Cafetería Aurora — Sistema POS & Solución de Inteligencia de Negocios (Power BI)

![Estado del Proyecto](https://img.shields.io/badge/Estado-Finalizado-success?style=for-the-badge)
![Tecnologías](https://img.shields.io/badge/Stack-C%23_%7C_SQL_Server_%7C_Power_BI-blue?style=for-the-badge)
![Licencia](https://img.shields.io/badge/Licencia-MIT_%2F_Académica-orange?style=for-the-badge)

> **Proyecto:** Base de Datos Avanzadas y Big Data  
> **NRC:** 26046 | **Período Académico:** 2026-2  
> **Docente:** Victor Isaac Chavez Bardales  

---

## 📌 Control de Evidencias y Metadatos de Entrega (Capítulo V)
* **URL del Repositorio:** [https://github.com/Reydiaz324/Cafeteria-Aurora-BI](https://github.com/Reydiaz324/Cafeteria-Aurora-BI)
* **Rama Principal:** `main`
* **Etiqueta / Tag de Versión Final:** `v1.0.0`
* **Commit Hash:** `5e2f524`
* **Fecha de Entrega:** 17 de octubre de 2026

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
1. **Solución 1 — Sistema Transaccional (OLTP):** Punto de Venta (POS) y control de inventario desarrollado en **C# (Windows Forms / .NET Framework 4.7.2)** con base de datos en **SQL Server** normalizada en 3FN.
2. **Solución 2 — Solución de Inteligencia de Negocios (BI):** Data Mart dimensional (**Star Schema / Modelo Estrella**) denominado `Cafeteria_DM`, alimentado por un pipeline ETL automatizado en T-SQL, conectado a un **Dashboard Analítico e Interactivo en Power BI**.
3. **Módulo de Seguridad y Auditoría:** Autenticación por roles con hash SHA2-256, usuario con permisos DDL restringidos y trigger de auditoría DDL a nivel de base de datos.

---

## 🔒 Declaración Ética y Privacidad de Datos (Alineación ABET SO 6)
En cumplimiento estricto con las políticas de tratamiento ético, legal y seguro de la información:
* **Datos 100% Sintéticos / Anónimos:** Todos los registros de clientes, números de teléfono y números de DNI incluidos en los scripts son ficticios (*Mock Data* con fines exclusivamente educativos y de prueba). No se utilizan datos de personas reales.
* **Cero Credenciales Sensibles en Código:** El archivo `App.config` y los scripts SQL han sido sanitizados para operar de forma segura en entornos locales (`.\SQLEXPRESS`) mediante autenticación integrada de Windows, sin exponer contraseñas ni cadenas de producción de la nube.

---

## 🛠️ Dependencias y Requisitos de Software
Para reproducir ambas soluciones y el experimento, se requiere el siguiente entorno:

| Software / Dependencia | Versión Requerida | Propósito |
| :--- | :--- | :--- |
| **Microsoft SQL Server** | 2019 / 2022 o Express (`.\SQLEXPRESS`) | Motor de base de datos transaccional (OLTP) y analítica (Data Mart OLAP) |
| **SQL Server Management Studio (SSMS)** | v18.x / v19.x o superior | Administración, ejecución de scripts y validación DDL/ETL |
| **Visual Studio** | 2019 / 2022 (Community o Professional) | Entorno de desarrollo para la aplicación POS de escritorio en C# |
| **.NET Framework SDK** | v4.7.2 | Framework de compilación y ejecución de la aplicación Windows Forms |
| **Microsoft Power BI Desktop** | 2024 o superior | Modelado dimensional, medidas DAX y Dashboard interactivo |

---

## 🏗️ Arquitectura de la Solución

```
[ Solución 1: Punto de Venta C# POS ] 
                │
                ▼ (Transacciones en tiempo real)
    [ BD_Cafeteria (OLTP) ] ── (14 tablas normalizadas en 3FN)
                │
                ▼ (Pipeline ETL: V3_DATA_MART_ETL.sql - Experimento)
    [ Cafeteria_DM (OLAP) ] ── (Modelo Estrella: Fact_Ventas + 5 Dimensiones)
                │
                ▼ (Consultas analíticas y Cross-Filtering)
[ Solución 2: Power BI Desktop Dashboard ] ── (KPIs de Ventas, Rotación y Turnos)
```

---

## 📂 Estructura del Repositorio

```text
├── CAFETERIA/                  # SOLUCIÓN 1: Aplicación de Escritorio en C# (.NET Framework 4.7.2)
│   └── guicafeteria/
│       ├── guicafeteria.sln    # Archivo de solución de Visual Studio
│       ├── FormPanel.cs        # Menú principal y navegación de módulos
│       ├── Pedido.cs           # Pantalla de ventas (POS), cálculo de carrito y emisión de tickets
│       ├── FrmEncargado.cs     # Módulo de administración, inventario y catálogo
│       ├── FrmLoginEncargado.cs# Formulario de autenticación
│       └── App.config          # Configuración de cadena de conexión sanitizada (Local .\SQLEXPRESS)
├── sql/                        # SCRIPTS DE BASE DE DATOS Y PIPELINE ETL
│   ├── BD_CAFETERIA.sql        # Esquema transaccional OLTP (Tablas core + datos anónimos)
│   ├── V2_ROLES_USUARIOS.sql   # Gestión de roles, usuarios con hash SHA2-256 y SP de Login
│   ├── V3_DATA_MART_ETL.sql    # EXPERIMENTO: Creación de Cafeteria_DM (Star Schema) y Pipeline ETL
│   ├── V4_USUARIO_DESARROLLADOR.sql # Perfil DDL restringido (sin permisos de DROP DATABASE)
│   └── V5_AUDITORIA_DDL.sql    # Trigger DDL de auditoría y tabla LOG_AUDITORIA_DDL
├── .gitignore                  # Exclusión de binarios, .vs/, compilados y archivos temporales
└── README.md                   # Documentación técnica y guía de reproducción
```

---

## 🚀 Guía de Despliegue y Ejecución Paso a Paso

### Paso 1: Configurar la Base de Datos Transaccional (OLTP)
1. Abrir **SQL Server Management Studio (SSMS)** y conectarse a la instancia local (`.\SQLEXPRESS`).
2. Abrir y ejecutar los scripts SQL en el siguiente orden estricto:
   ```sql
   -- 1. Crear la base de datos relacional y poblar datos semilla iniciales
   sql/BD_CAFETERIA.sql

   -- 2. Configurar la seguridad basada en roles y hashes de autenticación
   sql/V2_ROLES_USUARIOS.sql
   ```

### Paso 2: Ejecutar la Solución 1 (Aplicación POS en C#)
1. Abrir el archivo `CAFETERIA/guicafeteria/guicafeteria.sln` en **Visual Studio**.
2. Verificar que `App.config` apunte a la instancia local:
   ```xml
   <add name="guicafeteria.Properties.Settings.BD_CafeteriaConnectionString"
        connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=BD_Cafeteria;Integrated Security=True;TrustServerCertificate=True" 
        providerName="System.Data.SqlClient" />
   ```
3. Presionar `F5` o seleccionar **Iniciar**.
4. La aplicación cargará el formulario principal (`FormPanel`). Desde allí:
   * Acceder a **Pedido** para realizar ventas y emitir comprobantes.
   * Acceder a **Encargado** para gestionar el inventario y productos.

---

### Paso 3: Reproducción del Experimento (Pipeline ETL hacia el Data Mart)
El objetivo del experimento es evaluar la transformación de datos operacionales (OLTP 3FN) a una estructura optimizada para analítica de negocios (OLAP Star Schema) mediante un proceso ETL idempotente y automatizado.

1. En **SSMS**, abrir el script `sql/V3_DATA_MART_ETL.sql`.
2. Ejecutar el script completo. Este script realiza automáticamente:
   * **Extracción (Extract):** Lee las tablas transaccionales `PEDIDO`, `DETALLE_PEDIDO`, `PRODUCTO`, `CATEGORIA`, `EMPLEADO` y `CLIENTE`.
   * **Transformación (Transform):** Desnormaliza categorías, enriquece la dimensión temporal con cálculo de trimestres y fin de semana, segmenta clientes y clasifica turnos de atención.
   * **Carga (Load):** Crea y puebla la base `Cafeteria_DM` con las dimensiones `Dim_Tiempo`, `Dim_Producto`, `Dim_Empleado`, `Dim_Cliente`, `Dim_MetodoPago` y la tabla de hechos `Fact_Ventas`.
3. Validar el resultado del experimento ejecutando una consulta analítica en `Cafeteria_DM`:
   ```sql
   USE Cafeteria_DM
   SELECT 
       p.nombre_producto,
       t.mes_nombre,
       SUM(f.cantidad_unidades) AS total_unidades,
       SUM(f.monto_total) AS total_ingresos
   FROM Fact_Ventas f
   INNER JOIN Dim_Producto p ON f.id_producto = p.id_producto
   INNER JOIN Dim_Tiempo t ON f.id_tiempo = t.id_tiempo
   GROUP BY p.nombre_producto, t.mes_nombre
   ORDER BY total_ingresos DESC
   ```

---

### Paso 4: Ejecutar la Solución 2 (Dashboard en Power BI)
1. Abrir **Power BI Desktop**.
2. Seleccionar **Obtener Datos** > **SQL Server Database**:
   * **Servidor:** `.\SQLEXPRESS`
   * **Base de datos:** `Cafeteria_DM`
   * **Modo de conectividad:** Importar
3. Cargar las tablas del Modelo Estrella: `Fact_Ventas`, `Dim_Tiempo`, `Dim_Producto`, `Dim_Empleado`, `Dim_Cliente`, `Dim_MetodoPago`.
4. En la vista de **Modelo**, verificar las relaciones `1 a Varios (1:*)` con dirección de filtro cruzado única desde cada dimensión hacia `Fact_Ventas`.
5. Visualizar las métricas clave:
   * **Ingresos Totales (S/.):** `SUM(Fact_Ventas[monto_total])`
   * **Ticket Promedio:** `DIVIDE([Ingresos Totales], DISTINCTCOUNT(Fact_Ventas[id_pedido]))`
   * **Unidades Vendidas:** `SUM(Fact_Ventas[cantidad_unidades])`
   * **Ventas por Turno:** Comparación de ingresos entre Mañana y Tarde.

---

### Paso 5: Verificación de Seguridad y Auditoría DDL
1. Ejecutar el script `sql/V5_AUDITORIA_DDL.sql` en `BD_Cafeteria`.
2. Probar el disparador de auditoría realizando un cambio de estructura controlado:
   ```sql
   -- Crear una tabla temporal de prueba
   CREATE TABLE dbo.TEST_AUDIT (id INT)
   DROP TABLE dbo.TEST_AUDIT

   -- Consultar el registro de auditoría capturado en tiempo real
   SELECT * FROM dbo.LOG_AUDITORIA_DDL ORDER BY fecha_evento DESC
   ```

---

## 📊 Modelo Estrella (Star Schema)

* **Tabla de Hechos:**
  * `Fact_Ventas`: Almacena métricas cuantitativas (`monto_total`, `cantidad_unidades`, `precio_unitario`, `id_pedido`).
* **Dimensiones:**
  * `Dim_Tiempo`: Año, mes, trimestre, día de la semana y flag de fin de semana.
  * `Dim_Producto`: Nombre, categoría desnormalizada y precio base.
  * `Dim_Empleado`: Nombre del barista/encargado y turno asignado (Mañana/Tarde).
  * `Dim_Cliente`: Tipo y segmentación del cliente (General / Frecuente).
  * `Dim_MetodoPago`: Clasificación por método de pago (Efectivo, Yape/Plin, Tarjeta).

---

## 📄 Licencia
Este proyecto se distribuye bajo la licencia **MIT License** con fines estrictamente académicos para el curso de **Base de Datos Avanzadas y Big Data (Período 2026-2)**.
