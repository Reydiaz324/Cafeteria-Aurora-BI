# Cafetería Aurora — Aplicación Móvil Android (Jetpack Compose)

Aplicación móvil nativa para la gestión de pedidos y administración de **Cafetería Aurora**, desarrollada con las últimas tecnologías de Android Moderno (Jetpack Compose y Material Design 3).

---

## 📱 Descripción General
La aplicación ofrece dos experiencias completas e intuitivas:

1. **Modo Cliente (App de Ventas y Pedidos):**
   * **Catálogo interactivo:** Cafés, Frappés, Postres con fotos, descripciones y precios.
   * **Personalización del pedido:** Selección de tamaño (Regular/Grande), temperatura (Caliente/Frío) y agregados.
   * **Carrito y Checkout:** Aplicación de cupón de descuento (`AURORA10`), selección de modalidad (*Recojo en tienda*, *Disfrutar en local*, *Delivery con tarifa de S/ 4.00*).
   * **Pasarela de pago local:** Pagos mediante **Yape**, **Plin**, **Tarjeta** o **Efectivo al recoger**.
   * **Seguimiento (Tracking):** Código de pedido único (ej. `AU-1050`) y estado del pedido en tiempo real.

2. **Modo Administrador (Panel de Control y POS Móvil):**
   * **Dashboard de Métricas:** Total de ventas acumuladas, montos pendientes de cobro, pedidos en cola de atención y alertas de productos con stock bajo o agotado.
   * **Gestión de Pedidos:** Actualización de estados (*Nuevo* -> *En preparación* -> *Listo* -> *Entregado* / *Cancelado*) y confirmación de pagos.
   * **Gestión de Inventario:** Modificación rápida de stock (+/-), alta y edición de productos, categorías y precios.

---

## 🔑 Credenciales de Acceso para Demostración

| Rol | Correo Electrónico | Contraseña | Acceso |
| :--- | :--- | :--- | :--- |
| **Cliente** | Cualquier correo válido (ej. `cliente@gmail.com`) | 6 o más caracteres | Tienda, catálogo, carrito y pedidos |
| **Administrador** | `admin@gmail.com` *(o cualquier correo que inicie con `admin`)* | 6 o más caracteres | Panel completo de administración |

---

## 🚀 Opciones de Instalación y Ejecución

### Opción 1: Instalación Directa del APK (Recomendada para la Exposición)
No es necesario compilar el código. En la raíz de esta carpeta se encuentra el instalador listo para usar:
* **Archivo:** `app-debug.apk` (60.1 MB)
* **Instalación en celular físico:**
  1. Enviar el archivo `app-debug.apk` al celular (por WhatsApp, Telegram o cable USB).
  2. Abrir el archivo y permitir la instalación de aplicaciones de fuentes desconocidas.
  3. Abrir la app **Cafetería Aurora**.
* **Instalación en emulador (Android Studio / BlueStacks / Nox):**
  * Simplemente arrastrar y soltar el archivo `app-debug.apk` dentro de la ventana del emulador.

### Opción 2: Abrir el Proyecto en Android Studio
Si el docente o jurado solicita ver el código fuente:
1. Abrir **Android Studio** (Hedgehog, Iguana o versión 2023+).
2. Seleccionar **Open** y elegir la carpeta `Cafeteria_Aurora_App`.
3. Esperar que Gradle sincronice las dependencias automáticamente (usa Gradle Wrapper incluido).
4. Seleccionar un emulador o celular conectado y presionar **Run 'app'** (Shift + F10).

---

## 🛠️ Stack Tecnológico
* **Lenguajes:** Kotlin y Java
* **UI Toolkit:** Jetpack Compose con Material 3 (Material Design moderno sin XML de vistas)
* **Navegación:** Jetpack Navigation Compose
* **Patrón de Arquitectura:** Unidirectional Data Flow (UDF) con `AppState` observable
* **Manejo de Datos:** Repositorio desacoplado (`AuroraRepository.java`), preparado para consumir API REST en producción
