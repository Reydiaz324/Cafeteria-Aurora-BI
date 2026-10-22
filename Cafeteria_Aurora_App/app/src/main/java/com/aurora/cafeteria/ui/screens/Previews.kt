package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.compose.rememberNavController
import com.aurora.cafeteria.AppState
import com.aurora.cafeteria.ui.theme.AuroraColors
import com.aurora.cafeteria.ui.theme.AuroraTheme

/** Estado de ejemplo para las vistas previas (cliente o administrador, con o sin carrito). */
private fun demoState(admin: Boolean = false, withCart: Boolean = false) = AppState().apply {
    login(if (admin) "admin@aurora.com" else "valeria@email.com", "123456")
    if (withCart) {
        products.take(3).forEach { addToCart(it, 1, "Regular", "", "", it.price) }
    }
}

@Composable
private fun Frame(content: @Composable () -> Unit) {
    AuroraTheme {
        Box(Modifier.fillMaxSize().background(AuroraColors.Crema)) { content() }
    }
}

private const val W = 393
private const val H = 852

@Preview(name = "01 Splash", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewSplash() = Frame { SplashScreen(rememberNavController()) }

@Preview(name = "02 Bienvenida", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewWelcome() = Frame { WelcomeScreen(rememberNavController()) }

@Preview(name = "03 Iniciar sesión", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewLogin() = Frame { LoginScreen(rememberNavController(), AppState()) }

@Preview(name = "04 Crear cuenta", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewRegister() = Frame { RegisterScreen(rememberNavController(), AppState()) }

@Preview(name = "05 Inicio", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewHome() = Frame { HomeScreen(rememberNavController(), demoState(withCart = true)) }

@Preview(name = "06 Menú", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewMenu() = Frame { MenuScreen(rememberNavController(), demoState()) }

@Preview(name = "07 Detalle", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewDetail() = Frame { DetailScreen(rememberNavController(), demoState(), 1) }

@Preview(name = "08 Carrito", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewCart() = Frame { CartScreen(rememberNavController(), demoState(withCart = true)) }

@Preview(name = "09 Modalidad", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewModality() = Frame { ModalityScreen(rememberNavController(), demoState(withCart = true)) }

@Preview(name = "10 Pago", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewPayment() = Frame { PaymentScreen(rememberNavController(), demoState(withCart = true)) }

@Preview(name = "11 Seguimiento", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewTracking() = Frame { TrackingScreen(rememberNavController(), demoState(), "AU-1048") }

@Preview(name = "12 Perfil", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewProfile() = Frame { ProfileScreen(rememberNavController(), demoState()) }

@Preview(name = "13 Admin Dashboard", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewAdminDashboard() = Frame { AdminDashboardScreen(rememberNavController(), demoState(admin = true)) }

@Preview(name = "14 Admin Productos", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewAdminProducts() = Frame { AdminProductsScreen(rememberNavController(), demoState(admin = true)) }

@Preview(name = "15 Admin Pedidos", showBackground = true, widthDp = W, heightDp = H)
@Composable
fun PreviewAdminOrders() = Frame { AdminOrdersScreen(rememberNavController(), demoState(admin = true)) }
