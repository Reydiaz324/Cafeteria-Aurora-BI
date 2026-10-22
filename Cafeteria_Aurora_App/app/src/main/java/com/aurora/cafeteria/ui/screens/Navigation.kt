package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import com.aurora.cafeteria.ui.AuroraBottomBar
import com.aurora.cafeteria.ui.NavItem
import androidx.compose.foundation.layout.ColumnScope

object Routes {
    const val SPLASH = "splash"
    const val WELCOME = "welcome"
    const val LOGIN = "login"
    const val REGISTER = "register"
    const val RECOVER = "recover"

    const val HOME = "home"
    const val MENU = "menu"
    const val ORDERS = "orders"
    const val FAVORITES = "favorites"
    const val PROFILE = "profile"
    const val DETAIL = "detail/{id}"

    const val CART = "cart"
    const val MODALITY = "modality"
    const val PAYMENT = "payment"
    const val CONFIRMATION = "confirmation/{code}"
    const val TRACKING = "tracking/{code}"

    const val ADMIN_DASHBOARD = "admin_dashboard"
    const val ADMIN_PRODUCTS = "admin_products"
    const val ADMIN_ORDERS = "admin_orders"
    const val ADMIN_INVENTORY = "admin_inventory"
    const val ADMIN_MORE = "admin_more"
    const val ADMIN_PRODUCT_FORM = "admin_product_form/{id}"
    const val ADMIN_ORDER = "admin_order/{code}"

    fun detail(id: Int) = "detail/$id"
    fun confirmation(code: String) = "confirmation/$code"
    fun tracking(code: String) = "tracking/$code"
    fun adminProductForm(id: Int) = "admin_product_form/$id"
    fun adminOrder(code: String) = "admin_order/$code"
}

/** Navega a una pestaña de la barra inferior conservando su estado. */
fun NavHostController.goTab(route: String, root: String) {
    navigate(route) {
        popUpTo(root) { saveState = true }
        launchSingleTop = true
        restoreState = true
    }
}

/** Navega y limpia todo el historial (login / logout). */
fun NavHostController.navClear(route: String) {
    navigate(route) {
        popUpTo(graph.id) { inclusive = true }
        launchSingleTop = true
    }
}

val customerTabs = listOf(
    NavItem(Routes.HOME, "Inicio", Icons.Outlined.Home),
    NavItem(Routes.MENU, "Menú", Icons.Outlined.LocalCafe),
    NavItem(Routes.ORDERS, "Pedidos", Icons.Outlined.ReceiptLong),
    NavItem(Routes.FAVORITES, "Favoritos", Icons.Outlined.FavoriteBorder),
    NavItem(Routes.PROFILE, "Perfil", Icons.Outlined.Person)
)

val adminTabs = listOf(
    NavItem(Routes.ADMIN_DASHBOARD, "Dashboard", Icons.Outlined.Dashboard),
    NavItem(Routes.ADMIN_PRODUCTS, "Productos", Icons.Outlined.LocalCafe),
    NavItem(Routes.ADMIN_ORDERS, "Pedidos", Icons.Outlined.ReceiptLong),
    NavItem(Routes.ADMIN_INVENTORY, "Inventario", Icons.Outlined.Inventory2),
    NavItem(Routes.ADMIN_MORE, "Más", Icons.Outlined.Menu)
)

@Composable
fun CustomerShell(nav: NavHostController, current: String, content: @Composable () -> Unit) {
    Column(Modifier.fillMaxSize()) {
        Box(Modifier.weight(1f)) { content() }
        AuroraBottomBar(customerTabs, current) { nav.goTab(it, Routes.HOME) }
    }
}

@Composable
fun AdminShell(nav: NavHostController, current: String, content: @Composable () -> Unit) {
    Column(Modifier.fillMaxSize()) {
        Box(Modifier.weight(1f)) { content() }
        AuroraBottomBar(adminTabs, current) { nav.goTab(it, Routes.ADMIN_DASHBOARD) }
    }
}
