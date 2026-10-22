package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.aurora.cafeteria.AppState
import com.aurora.cafeteria.model.Order
import com.aurora.cafeteria.ui.*
import com.aurora.cafeteria.ui.theme.AuroraColors.Arena
import com.aurora.cafeteria.ui.theme.AuroraColors.Blanco
import com.aurora.cafeteria.ui.theme.AuroraColors.Borde
import com.aurora.cafeteria.ui.theme.AuroraColors.Espresso
import com.aurora.cafeteria.ui.theme.AuroraColors.Muted
import com.aurora.cafeteria.ui.theme.AuroraColors.Oro
import com.aurora.cafeteria.ui.theme.AuroraColors.Rojo
import com.aurora.cafeteria.ui.theme.AuroraColors.Verde
import com.aurora.cafeteria.ui.theme.AuroraType

private fun stockTag(stock: Int, min: Int): Pair<String, Tone> = when {
    stock <= 0 -> "Agotado" to Tone.Bad
    stock <= min -> "Stock bajo" to Tone.Warn
    else -> "Disponible" to Tone.Ok
}

private fun orderTone(o: Order) = when (o.status) {
    "Entregado" -> Tone.Ok
    "Cancelado" -> Tone.Bad
    else -> Tone.Warn
}

// ---------------- Dashboard ----------------

@Composable
fun AdminDashboardScreen(nav: NavHostController, state: AppState) {
    val sales = state.orders.filter { it.status != "Cancelado" }.sumOf { it.total }
    val pendingPay = state.orders.filter { !it.isPaymentConfirmed && it.status != "Cancelado" }.sumOf { it.total }
    val attention = state.orders.count { it.status == "Nuevo" || it.status == "En preparación" }
    val low = state.products.count { it.stock <= it.minStock }
    val out = state.products.count { it.stock <= 0 }
    val week = listOf("J" to 0.45f, "V" to 0.6f, "S" to 0.5f, "D" to 0.75f, "L" to 0.65f, "M" to 0.95f, "X" to 0.85f)

    AdminShell(nav, Routes.ADMIN_DASHBOARD) {
        Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)) {
            Column {
                Text("Buen día, ${state.user?.firstName ?: ""}", style = AuroraType.Title)
                Text("ADMINISTRACIÓN", fontSize = 11.sp, color = Muted, letterSpacing = 1.sp)
            }
            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                Column(Modifier.weight(1f).clip(RoundedCornerShape(18.dp)).background(Espresso).padding(16.dp)) {
                    Text("Ventas registradas", color = Blanco, fontSize = 12.sp)
                    Text(money(sales), color = Blanco, style = AuroraType.Title)
                    Text("${state.orders.size} pedidos", color = Oro, fontSize = 12.sp)
                }
                AuroraCard(Modifier.weight(1f)) {
                    Text("Pedidos recibidos", color = Muted, fontSize = 12.sp)
                    Text("${state.orders.size}", style = AuroraType.Title)
                    Text("$attention pendientes de atención", color = Muted, fontSize = 12.sp)
                }
            }
            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                AuroraCard(Modifier.weight(1f)) {
                    Text("Pagos pendientes", color = Muted, fontSize = 12.sp)
                    Text(money(pendingPay), style = AuroraType.Title)
                    Text("No son dinero recibido", color = Muted, fontSize = 12.sp)
                }
                AuroraCard(Modifier.weight(1f), onClick = { nav.goTab(Routes.ADMIN_INVENTORY, Routes.ADMIN_DASHBOARD) }) {
                    Text("Stock bajo", color = Muted, fontSize = 12.sp)
                    Text("$low", style = AuroraType.Title)
                    Text("$out producto(s) agotado(s) · Revisar →", color = Muted, fontSize = 12.sp)
                }
            }
            AuroraCard {
                Text("Ventas de la semana", fontWeight = FontWeight.Bold)
                Spacer(Modifier.height(12.dp))
                Row(Modifier.fillMaxWidth().height(110.dp), horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.Bottom) {
                    week.forEachIndexed { i, (day, h) ->
                        Column(horizontalAlignment = Alignment.CenterHorizontally) {
                            Box(Modifier.width(26.dp).height((80 * h).dp).clip(RoundedCornerShape(6.dp))
                                .background(if (i == week.lastIndex) Espresso else Oro))
                            Text(day, fontSize = 11.sp, color = Muted, modifier = Modifier.padding(top = 6.dp))
                        }
                    }
                }
            }
            Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
                listOf(
                    Triple("Productos", Icons.Outlined.LocalCafe, Routes.ADMIN_PRODUCTS),
                    Triple("Inventario", Icons.Outlined.Inventory2, Routes.ADMIN_INVENTORY),
                    Triple("Pedidos", Icons.Outlined.ReceiptLong, Routes.ADMIN_ORDERS)
                ).forEach { (label, icon, route) ->
                    Column(
                        Modifier.weight(1f).clip(RoundedCornerShape(16.dp)).background(Blanco)
                            .clickable { nav.goTab(route, Routes.ADMIN_DASHBOARD) }.padding(vertical = 14.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Icon(icon, null)
                        Text(label, fontSize = 12.sp, fontWeight = FontWeight.SemiBold, modifier = Modifier.padding(top = 6.dp))
                    }
                }
            }
        }
    }
}

// ---------------- Productos ----------------

@Composable
fun AdminProductsScreen(nav: NavHostController, state: AppState) {
    var query by remember { mutableStateOf("") }
    var filter by remember { mutableStateOf("Todos") }
    var toDelete by remember { mutableStateOf<Int?>(null) }

    val list = state.products
        .filter { it.name.contains(query, true) || it.category.contains(query, true) }
        .filter {
            when (filter) {
                "Disponibles" -> it.stock > it.minStock
                "Stock bajo" -> it.stock in 1..it.minStock
                "Agotados" -> it.stock <= 0
                else -> true
            }
        }

    AdminShell(nav, Routes.ADMIN_PRODUCTS) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Productos", "${state.products.size} productos · ${state.products.count { it.stock > 0 }} disponibles")
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(14.dp)) {
                SearchBox("Buscar nombre o categoría", value = query, onValueChange = { query = it })
                Row(Modifier.horizontalScroll(rememberScrollState()), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    listOf("Todos", "Disponibles", "Stock bajo", "Agotados").forEach { AuroraChip(it, filter == it) { filter = it } }
                }
                PrimaryButton("+  Crear producto", { nav.navigate(Routes.adminProductForm(-1)) })
                AuroraCard {
                    list.forEach { p ->
                        val (tag, tone) = stockTag(p.stock, p.minStock)
                        Row(Modifier.fillMaxWidth().padding(vertical = 8.dp), verticalAlignment = Alignment.CenterVertically) {
                            ProductImage(p.category, Modifier.size(64.dp))
                            Spacer(Modifier.width(12.dp))
                            Column(Modifier.weight(1f)) {
                                Text(p.name, fontWeight = FontWeight.Bold)
                                Text("${p.category} · ${money(p.price)}", color = Muted, fontSize = 12.sp)
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    StatusTag(tag, tone)
                                    Text("  ${p.stock} uds.", color = Muted, fontSize = 12.sp)
                                }
                            }
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                Icon(Icons.Outlined.Edit, "Editar", modifier = Modifier.size(22.dp).clickable { nav.navigate(Routes.adminProductForm(p.id)) })
                                Spacer(Modifier.height(14.dp))
                                Icon(Icons.Outlined.DeleteOutline, "Eliminar", tint = Rojo, modifier = Modifier.size(22.dp).clickable { toDelete = p.id })
                            }
                        }
                    }
                    if (list.isEmpty()) Text("Sin resultados.", color = Muted)
                }
                Spacer(Modifier.height(12.dp))
            }
        }
    }

    toDelete?.let { id ->
        val name = state.products.firstOrNull { it.id == id }?.name ?: ""
        AlertDialog(
            onDismissRequest = { toDelete = null },
            containerColor = Blanco,
            icon = { Icon(Icons.Outlined.WarningAmber, null, tint = Rojo) },
            title = { Text("¿Eliminar $name?", style = AuroraType.Heading) },
            text = { Text("Esta acción quitará el producto de la carta.") },
            confirmButton = {
                TextButton(onClick = { state.deleteProduct(id); toDelete = null }) { Text("Eliminar", color = Rojo, fontWeight = FontWeight.Bold) }
            },
            dismissButton = { TextButton(onClick = { toDelete = null }) { Text("Cancelar", color = Espresso) } }
        )
    }
}

@Composable
fun AdminProductFormScreen(nav: NavHostController, state: AppState, id: Int) {
    val ctx = LocalContext.current
    val existing = state.products.firstOrNull { it.id == id }
    var name by remember { mutableStateOf(existing?.name ?: "") }
    var desc by remember { mutableStateOf(existing?.description ?: "") }
    var price by remember { mutableStateOf(existing?.price?.toString() ?: "") }
    var stock by remember { mutableStateOf(existing?.stock?.toString() ?: "") }
    var category by remember { mutableStateOf(existing?.category ?: "Cafés") }
    var submitted by remember { mutableStateOf(false) }

    val priceValue = price.replace(",", ".").toDoubleOrNull()
    val stockValue = stock.toIntOrNull()

    Column(Modifier.fillMaxSize()) {
        ScreenHeader(if (existing == null) "Crear producto" else "Editar producto", onBack = { nav.popBackStack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)) {
            AuroraField("Nombre", name, { name = it }, error = if (submitted && name.isBlank()) "Ingresa un nombre." else null)
            AuroraField("Descripción", desc, { desc = it })
            AuroraField("Precio (S/)", price, { price = it }, keyboardType = KeyboardType.Decimal,
                error = if (submitted && (priceValue == null || priceValue <= 0)) "Ingresa un precio válido." else null)
            AuroraField("Stock (unidades)", stock, { stock = it }, keyboardType = KeyboardType.Number,
                error = if (submitted && (stockValue == null || stockValue < 0)) "Ingresa un stock válido." else null)
            Text("Categoría", fontWeight = FontWeight.SemiBold, fontSize = 14.sp)
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                listOf("Cafés", "Frappés", "Postres").forEach { AuroraChip(it, category == it) { category = it } }
            }
        }
        Column(Modifier.background(Blanco).padding(20.dp), verticalArrangement = Arrangement.spacedBy(10.dp)) {
            PrimaryButton("Guardar", {
                submitted = true
                if (name.isNotBlank() && priceValue != null && priceValue > 0 && stockValue != null && stockValue >= 0) {
                    state.saveProduct(id, name.trim(), desc.trim(), priceValue, category, stockValue)
                    ctx.toast("Cambios guardados")
                    nav.popBackStack()
                }
            })
            SecondaryButton("Cancelar", { nav.popBackStack() })
        }
    }
}

// ---------------- Pedidos ----------------

@Composable
fun AdminOrdersScreen(nav: NavHostController, state: AppState) {
    var query by remember { mutableStateOf("") }
    var filter by remember { mutableStateOf("Todos") }
    val filters = listOf("Todos", "Nuevos", "Pendientes", "Preparación", "Listos", "Entregados", "Cancelados")

    val list = state.orders
        .filter { it.code.contains(query, true) || it.customerName.contains(query, true) }
        .filter {
            when (filter) {
                "Nuevos" -> it.status == "Nuevo"
                "Pendientes" -> !it.isPaymentConfirmed && it.status != "Cancelado"
                "Preparación" -> it.status == "En preparación"
                "Listos" -> it.status == "Listo"
                "Entregados" -> it.status == "Entregado"
                "Cancelados" -> it.status == "Cancelado"
                else -> true
            }
        }

    AdminShell(nav, Routes.ADMIN_ORDERS) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Pedidos", "${state.orders.count { it.status != "Entregado" && it.status != "Cancelado" }} por atender")
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Row(Modifier.horizontalScroll(rememberScrollState()), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    filters.forEach { AuroraChip(it, filter == it) { filter = it } }
                }
                SearchBox("Buscar código o cliente", value = query, onValueChange = { query = it })
                list.forEach { o ->
                    AuroraCard(onClick = { nav.navigate(Routes.adminOrder(o.code)) }) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text(o.code, fontWeight = FontWeight.Bold, fontSize = 18.sp, modifier = Modifier.weight(1f))
                            StatusTag(o.status, orderTone(o))
                        }
                        Text("${o.customerName} · Hoy ${o.time} · ${o.modality}", color = Muted, fontSize = 13.sp,
                            modifier = Modifier.padding(vertical = 4.dp))
                        Text(o.lines.lines().joinToString(", ") { it.substringBefore(" ·") }, fontSize = 13.sp)
                        Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.padding(top = 6.dp)) {
                            Text("${o.payment} · ${if (o.isPaymentConfirmed) "Confirmado" else "Pendiente"}",
                                color = if (o.isPaymentConfirmed) Verde else Rojo, fontSize = 12.sp, modifier = Modifier.weight(1f))
                            Text(money(o.total), fontWeight = FontWeight.Bold, fontSize = 20.sp)
                        }
                        Text("Ver pedido y gestionar →", fontWeight = FontWeight.SemiBold, fontSize = 13.sp,
                            modifier = Modifier.padding(top = 6.dp))
                    }
                }
                if (list.isEmpty()) Text("No hay pedidos en esta lista.", color = Muted)
                InfoBanner("No confundir estado y pago", "Preparar un pedido no confirma su cobro.")
                Spacer(Modifier.height(12.dp))
            }
        }
    }
}

@Composable
fun AdminOrderDetailScreen(nav: NavHostController, state: AppState, code: String) {
    val ctx = LocalContext.current
    val order = state.orders.firstOrNull { it.code == code }
    if (order == null) { LaunchedEffect(Unit) { nav.popBackStack() }; return }

    Column(Modifier.fillMaxSize()) {
        ScreenHeader("Pedido $code", order.customerName, onBack = { nav.popBackStack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)) {
            AuroraCard {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(order.modality, fontWeight = FontWeight.Bold, modifier = Modifier.weight(1f))
                    StatusTag(order.status, orderTone(order))
                }
                Text("Hoy ${order.time}", color = Muted, fontSize = 13.sp)
                Spacer(Modifier.height(8.dp))
                order.lines.lines().forEach { Text(it, fontSize = 14.sp) }
                Spacer(Modifier.height(8.dp))
                Text(money(order.total), fontWeight = FontWeight.Bold, fontSize = 24.sp, modifier = Modifier.align(Alignment.End))
            }
            if (order.isPaymentConfirmed)
                InfoBanner("Pago confirmado · ${order.payment}", "Simulado: no hay cobro real.", Tone.Ok, Icons.Outlined.CheckCircle)
            else {
                InfoBanner("Pago pendiente · ${order.payment}", "Se cobra al entregar. Confirma cuando recibas el dinero.")
                SecondaryButton("Marcar pago recibido", { state.updateOrder(code) { it.withPaymentConfirmed(true) }; ctx.toast("Pago registrado") })
            }
            Text("Cambiar estado", fontWeight = FontWeight.SemiBold)
            Row(Modifier.horizontalScroll(rememberScrollState()), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                listOf("Nuevo", "En preparación", "Listo", "Entregado", "Cancelado").forEach { st ->
                    AuroraChip(st, order.status == st) {
                        state.updateOrder(code) { it.withStatus(st) }
                        ctx.toast("Estado actualizado: $st")
                    }
                }
            }
        }
    }
}

// ---------------- Inventario ----------------

@Composable
fun AdminInventoryScreen(nav: NavHostController, state: AppState) {
    AdminShell(nav, Routes.ADMIN_INVENTORY) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Inventario", "Ajusta las existencias")
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)) {
                state.products.forEach { p ->
                    val (tag, tone) = stockTag(p.stock, p.minStock)
                    AuroraCard {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text(p.name, fontWeight = FontWeight.Bold, modifier = Modifier.weight(1f))
                            Text("${p.stock} uds.", fontWeight = FontWeight.Bold, fontSize = 18.sp)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.padding(top = 6.dp)) {
                            Text("Mínimo ${p.minStock}", color = Muted, fontSize = 12.sp, modifier = Modifier.weight(1f))
                            IconButton(onClick = { state.adjustStock(p.id, -1) }) { Icon(Icons.Outlined.Remove, "Restar") }
                            IconButton(onClick = { state.adjustStock(p.id, 1) }) { Icon(Icons.Outlined.Add, "Sumar") }
                            Spacer(Modifier.width(6.dp))
                            StatusTag(tag, tone)
                        }
                    }
                }
                Spacer(Modifier.height(12.dp))
            }
        }
    }
}

// ---------------- Más ----------------

@Composable
fun AdminMoreScreen(nav: NavHostController, state: AppState) {
    val ctx = LocalContext.current
    val soon = { ctx.toast("Esta pantalla se conectará más adelante") }
    AdminShell(nav, Routes.ADMIN_MORE) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Más", "${state.user?.name ?: ""} · Administración")
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)) {
                AuroraCard {
                    ProfileRow(Icons.Outlined.Group, "Clientes", null, soon)
                    ProfileRow(Icons.Outlined.LocalOffer, "Promociones", null, soon)
                    ProfileRow(Icons.Outlined.PointOfSale, "Ventas y caja", null, soon)
                    ProfileRow(Icons.Outlined.BarChart, "Reportes", null, soon)
                    ProfileRow(Icons.Outlined.Category, "Categorías", null, soon)
                    ProfileRow(Icons.Outlined.Settings, "Configuración", null, soon)
                    ProfileRow(Icons.Outlined.AdminPanelSettings, "Administradores y roles", null, soon)
                }
                Row(
                    Modifier.fillMaxWidth().clickable { state.logout(); nav.navClear(Routes.WELCOME) }.padding(8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(Icons.Outlined.Logout, null, tint = Rojo)
                    Spacer(Modifier.width(12.dp))
                    Text("Cerrar sesión", color = Rojo, fontWeight = FontWeight.Bold)
                }
            }
        }
    }
}
