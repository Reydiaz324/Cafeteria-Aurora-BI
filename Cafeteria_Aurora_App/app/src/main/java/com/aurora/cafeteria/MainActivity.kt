package com.aurora.cafeteria

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import androidx.navigation.NavType
import androidx.navigation.navArgument
import com.aurora.cafeteria.ui.screens.*
import com.aurora.cafeteria.ui.theme.AuroraColors
import com.aurora.cafeteria.ui.theme.AuroraTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            AuroraTheme {
                val nav = rememberNavController()
                val state = remember { AppState() }
                val route by nav.currentBackStackEntryAsState()
                val bg = if (route?.destination?.route == Routes.SPLASH) AuroraColors.Espresso else AuroraColors.Crema

                Box(Modifier.fillMaxSize().background(bg).systemBarsPadding()) {
                    NavHost(navController = nav, startDestination = Routes.SPLASH) {
                        // Autenticación
                        composable(Routes.SPLASH) { SplashScreen(nav) }
                        composable(Routes.WELCOME) { WelcomeScreen(nav) }
                        composable(Routes.LOGIN) { LoginScreen(nav, state) }
                        composable(Routes.REGISTER) { RegisterScreen(nav, state) }
                        composable(Routes.RECOVER) { RecoverScreen(nav) }

                        // Tienda (cliente)
                        composable(Routes.HOME) { HomeScreen(nav, state) }
                        composable(Routes.MENU) { MenuScreen(nav, state) }
                        composable(Routes.ORDERS) { OrdersScreen(nav, state) }
                        composable(Routes.FAVORITES) { FavoritesScreen(nav, state) }
                        composable(Routes.PROFILE) { ProfileScreen(nav, state) }
                        composable(
                            Routes.DETAIL, arguments = listOf(navArgument("id") { type = NavType.IntType })
                        ) { DetailScreen(nav, state, it.arguments?.getInt("id") ?: 0) }

                        // Carrito y pedido
                        composable(Routes.CART) { CartScreen(nav, state) }
                        composable(Routes.MODALITY) { ModalityScreen(nav, state) }
                        composable(Routes.PAYMENT) { PaymentScreen(nav, state) }
                        composable(Routes.CONFIRMATION) {
                            ConfirmationScreen(nav, state, it.arguments?.getString("code").orEmpty())
                        }
                        composable(Routes.TRACKING) {
                            TrackingScreen(nav, state, it.arguments?.getString("code").orEmpty())
                        }

                        // Administración
                        composable(Routes.ADMIN_DASHBOARD) { AdminDashboardScreen(nav, state) }
                        composable(Routes.ADMIN_PRODUCTS) { AdminProductsScreen(nav, state) }
                        composable(Routes.ADMIN_ORDERS) { AdminOrdersScreen(nav, state) }
                        composable(Routes.ADMIN_INVENTORY) { AdminInventoryScreen(nav, state) }
                        composable(Routes.ADMIN_MORE) { AdminMoreScreen(nav, state) }
                        composable(
                            Routes.ADMIN_PRODUCT_FORM, arguments = listOf(navArgument("id") { type = NavType.IntType })
                        ) { AdminProductFormScreen(nav, state, it.arguments?.getInt("id") ?: -1) }
                        composable(Routes.ADMIN_ORDER) {
                            AdminOrderDetailScreen(nav, state, it.arguments?.getString("code").orEmpty())
                        }
                    }
                }
            }
        }
    }
}
