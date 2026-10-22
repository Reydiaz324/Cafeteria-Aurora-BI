package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import com.aurora.cafeteria.R
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.border
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.aurora.cafeteria.AppState
import com.aurora.cafeteria.data.AuroraRepository
import com.aurora.cafeteria.model.Product
import com.aurora.cafeteria.ui.*
import com.aurora.cafeteria.ui.theme.AuroraColors.Arena
import com.aurora.cafeteria.ui.theme.AuroraColors.Blanco
import com.aurora.cafeteria.ui.theme.AuroraColors.Borde
import com.aurora.cafeteria.ui.theme.AuroraColors.Espresso
import com.aurora.cafeteria.ui.theme.AuroraColors.Muted
import com.aurora.cafeteria.ui.theme.AuroraColors.Oro
import com.aurora.cafeteria.ui.theme.AuroraColors.Rojo
import com.aurora.cafeteria.ui.theme.AuroraType

private fun quickAdd(state: AppState, p: Product): String {
    val size = if (p.category == "Postres") "Una porción" else "Regular"
    val temp = if (p.category == "Cafés") "Caliente" else ""
    state.addToCart(p, 1, size, temp, "", p.price)
    return "${p.name} agregado al carrito"
}

@Composable
fun SearchBox(text: String, onClick: (() -> Unit)? = null, value: String? = null, onValueChange: ((String) -> Unit)? = null) {
    val shape = RoundedCornerShape(18.dp)
    Row(
        Modifier.fillMaxWidth().clip(shape).background(Blanco).border(1.dp, Borde, shape)
            .let { if (onClick != null) it.clickable(onClick = onClick) else it }
            .padding(horizontal = 14.dp, vertical = 14.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(Icons.Outlined.Search, null, tint = Muted)
        Spacer(Modifier.width(10.dp))
        if (onValueChange != null && value != null) {
            androidx.compose.foundation.text.BasicTextField(
                value = value, onValueChange = onValueChange, singleLine = true,
                textStyle = androidx.compose.ui.text.TextStyle(fontSize = 15.sp, color = Espresso),
                decorationBox = { inner ->
                    if (value.isEmpty()) Text(text, color = Muted, fontSize = 15.sp)
                    inner()
                },
                modifier = Modifier.weight(1f)
            )
        } else {
            Text(text, color = Muted, fontSize = 15.sp, modifier = Modifier.weight(1f))
        }
        Icon(Icons.Outlined.Tune, null)
    }
}

@Composable
fun HomeScreen(nav: NavHostController, state: AppState) {
    val ctx = LocalContext.current
    var category by remember { mutableStateOf("Cafés") }
    val hour = java.util.Calendar.getInstance().get(java.util.Calendar.HOUR_OF_DAY)
    val greeting = when { hour < 12 -> "Buenos días"; hour < 19 -> "Buenas tardes"; else -> "Buenas noches" }

    CustomerShell(nav, Routes.HOME) {
        Column(Modifier.fillMaxSize().verticalScroll(rememberScrollState())) {
            Row(Modifier.fillMaxWidth().padding(20.dp), verticalAlignment = Alignment.CenterVertically) {
                Column(Modifier.weight(1f)) {
                    Text("Aurora", style = AuroraType.Title)
                    Text("CAFÉ · CONEXIÓN · MOMENTOS", fontSize = 10.sp, color = Muted, letterSpacing = 1.sp)
                }
                CartButton(state.cartCount) { nav.navigate(Routes.CART) }
            }
            Column(Modifier.padding(horizontal = 20.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Column(Modifier.weight(1f)) {
                        Text("$greeting, ${state.user?.firstName ?: ""}", style = AuroraType.Title)
                        Text("Un buen día empieza con tu café.", color = Muted, fontSize = 14.sp)
                    }
                    IconButton(onClick = { ctx.toast("Sin notificaciones nuevas") }) { Icon(Icons.Outlined.Notifications, "Notificaciones") }
                }
                SearchBox("¿Qué se te antoja hoy?", onClick = { nav.goTab(Routes.MENU, Routes.HOME) })

                // Promoción
                Row(
                    Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(Espresso).padding(20.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(Modifier.weight(1f)) {
                        Text("TU PRIMER MOMENTO", color = Oro, fontSize = 11.sp, letterSpacing = 1.sp)
                        Text("Disfruta un 10%", color = Blanco, style = AuroraType.Heading, modifier = Modifier.padding(vertical = 6.dp))
                        Text("Usa ${AuroraRepository.PROMO_CODE} · Hasta el 31 oct.", color = Blanco, fontSize = 12.sp)
                    }
                    ProductImage("Cafés", Modifier.size(92.dp))
                }

                // Categorías
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    listOf("Cafés", "Frappés", "Postres").forEach {
                        AuroraChip(it, category == it) { category = it }
                    }
                    AuroraChip("Ver todo →", false) { nav.goTab(Routes.MENU, Routes.HOME) }
                }

                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text("Favoritos de Aurora", style = AuroraType.Heading, modifier = Modifier.weight(1f))
                    Text("Ver menú", fontWeight = FontWeight.SemiBold, fontSize = 14.sp,
                        modifier = Modifier.clickable { nav.goTab(Routes.MENU, Routes.HOME) })
                }
                AuroraCard {
                    val list = state.products.filter { it.category == category }.take(3)
                    if (list.isEmpty()) Text("Pronto tendremos novedades aquí.", color = Muted)
                    list.forEach { p ->
                        ProductRow(p, { nav.navigate(Routes.detail(p.id)) }, { ctx.toast(quickAdd(state, p)) })
                    }
                }
                Row(
                    Modifier.fillMaxWidth().clickable { nav.goTab(Routes.MENU, Routes.HOME) },
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Box(Modifier.clip(RoundedCornerShape(50)).background(Arena).padding(horizontal = 12.dp, vertical = 6.dp)) {
                        Text("NUEVO", fontSize = 11.sp, fontWeight = FontWeight.Bold)
                    }
                    Spacer(Modifier.width(10.dp))
                    Text("Prueba el sándwich de pollo y palta →", fontSize = 14.sp)
                }
                Spacer(Modifier.height(12.dp))
            }
        }
    }
}

@Composable
fun MenuScreen(nav: NavHostController, state: AppState) {
    val ctx = LocalContext.current
    var query by remember { mutableStateOf("") }
    var filter by remember { mutableStateOf("Todos") }
    var priceAsc by remember { mutableStateOf<Boolean?>(null) }

    val filtered = state.products
        .filter { p ->
            when (filter) {
                "Calientes" -> p.category == "Cafés"
                "Fríos" -> p.category == "Frappés"
                "Postres" -> p.category == "Postres"
                else -> true
            }
        }
        .filter { it.name.contains(query, ignoreCase = true) || it.category.contains(query, ignoreCase = true) }
        .let { list ->
            when (priceAsc) {
                true -> list.sortedBy { it.price }
                false -> list.sortedByDescending { it.price }
                null -> list
            }
        }

    CustomerShell(nav, Routes.MENU) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Nuestro menú", cartCount = state.cartCount, onCart = { nav.navigate(Routes.CART) })
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(14.dp)) {
                SearchBox("Buscar café, frappé, postre...", value = query, onValueChange = { query = it })
                Row(Modifier.horizontalScroll(rememberScrollState()), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    listOf("Todos", "Calientes", "Fríos", "Postres").forEach { AuroraChip(it, filter == it) { filter = it } }
                }
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text("${filtered.size} productos", color = Muted, fontSize = 13.sp, modifier = Modifier.weight(1f))
                    Text("Popularidad ↓", fontWeight = FontWeight.SemiBold, fontSize = 13.sp,
                        modifier = Modifier.clickable { priceAsc = null })
                    Text("  ·  Precio ${when (priceAsc) { true -> "↑"; false -> "↓"; null -> "↕" }}",
                        fontWeight = FontWeight.SemiBold, fontSize = 13.sp,
                        modifier = Modifier.clickable { priceAsc = priceAsc != true })
                }
                AuroraCard {
                    if (filtered.isEmpty()) {
                        Text("No encontramos resultados. Prueba con otra búsqueda.", color = Muted)
                    }
                    filtered.forEach { p ->
                        ProductRow(p, { nav.navigate(Routes.detail(p.id)) }, { ctx.toast(quickAdd(state, p)) })
                    }
                }
                Text("Disponibilidad actualizada al confirmar tu pedido.", color = Muted, fontSize = 12.sp)
                Spacer(Modifier.height(12.dp))
            }
        }
    }
}

@Composable
fun DetailScreen(nav: NavHostController, state: AppState, id: Int) {
    val ctx = LocalContext.current
    val product = state.products.firstOrNull { it.id == id }
    if (product == null) { LaunchedEffect(Unit) { nav.popBackStack() }; return }

    val isDessert = product.category == "Postres"
    var size by remember { mutableStateOf(if (isDessert) "Una porción" else "Regular") }
    var temp by remember { mutableStateOf(if (product.category == "Cafés") "Caliente" else "") }
    var espressoExtra by remember { mutableStateOf(false) }
    var oatMilk by remember { mutableStateOf(false) }
    var qty by remember { mutableStateOf(1) }
    var customize by remember { mutableStateOf(false) }

    val unit = product.price + (if (size == "Grande") 2.0 else 0.0) +
            (if (espressoExtra) 3.0 else 0.0) + (if (oatMilk) 2.0 else 0.0)
    val extras = listOfNotNull(
        if (espressoExtra) "Espresso extra" else null,
        if (oatMilk) "Leche de avena" else null
    ).joinToString(", ")
    val fav = state.favorites.contains(product.id)

    Column(Modifier.fillMaxSize()) {
        ScreenHeader("Tu café, a tu gusto", onBack = { nav.popBackStack() },
            cartCount = state.cartCount, onCart = { nav.navigate(Routes.CART) })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)) {
            ProductImage(product.category, Modifier.fillMaxWidth().height(200.dp))
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(product.name, style = AuroraType.Title, modifier = Modifier.weight(1f))
                IconButton(onClick = { state.toggleFavorite(product.id) }) {
                    if (fav) Icon(Icons.Filled.Favorite, "Quitar de favoritos", tint = Rojo)
                    else Icon(Icons.Outlined.FavoriteBorder, "Agregar a favoritos")
                }
            }
            Text(product.description, color = Muted, fontSize = 15.sp)
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(money(unit), fontWeight = FontWeight.Bold, fontSize = 22.sp, modifier = Modifier.weight(1f))
                when {
                    product.isOut() -> StatusTag("Agotado", Tone.Bad)
                    product.isLow() -> StatusTag("Stock bajo · ${product.stock}", Tone.Warn)
                    else -> StatusTag("Disponible", Tone.Ok)
                }
            }
            if (!isDessert) {
                Text("Tamaño", fontWeight = FontWeight.SemiBold, fontSize = 14.sp)
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    AuroraChip("Regular · 8 oz", size == "Regular") { size = "Regular" }
                    AuroraChip("Grande + S/ 2", size == "Grande") { size = "Grande" }
                }
            }
            if (product.category == "Cafés") {
                Text("Temperatura", fontWeight = FontWeight.SemiBold, fontSize = 14.sp)
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    AuroraChip("Caliente", temp == "Caliente") { temp = "Caliente" }
                    AuroraChip("Tibio", temp == "Tibio") { temp = "Tibio" }
                }
            }
            if (!isDessert) {
                Row(
                    Modifier.fillMaxWidth().clickable { customize = !customize }.padding(vertical = 8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(Icons.Outlined.Tune, null)
                    Spacer(Modifier.width(12.dp))
                    Column(Modifier.weight(1f)) {
                        Text("Personaliza tu ${product.name}", fontWeight = FontWeight.Bold)
                        Text("Leche, azúcar y un espresso extra", color = Muted, fontSize = 13.sp)
                    }
                    Icon(if (customize) Icons.Outlined.ExpandLess else Icons.Outlined.ChevronRight, null)
                }
                if (customize) {
                    AuroraCard {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text("Espresso extra  + S/ 3.00", Modifier.weight(1f))
                            Switch(espressoExtra, { espressoExtra = it }, colors = SwitchDefaults.colors(checkedTrackColor = Espresso))
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text("Leche de avena  + S/ 2.00", Modifier.weight(1f))
                            Switch(oatMilk, { oatMilk = it }, colors = SwitchDefaults.colors(checkedTrackColor = Espresso))
                        }
                    }
                }
            }
            Spacer(Modifier.height(8.dp))
        }
        Row(Modifier.background(Blanco).padding(16.dp), verticalAlignment = Alignment.CenterVertically) {
            QuantityStepper(qty, { qty = it }, max = maxOf(product.stock, 1))
            Spacer(Modifier.width(12.dp))
            PrimaryButton(
                if (product.isOut()) "Agotado · No disponible" else "Agregar · ${money(unit * qty)}",
                {
                    state.addToCart(product, qty, size, temp, extras, unit)
                    ctx.toast("${product.name} agregado al carrito")
                    nav.popBackStack()
                },
                enabled = !product.isOut()
            )
        }
    }
}

@Composable
fun FavoritesScreen(nav: NavHostController, state: AppState) {
    val ctx = LocalContext.current
    val favs = state.products.filter { state.favorites.contains(it.id) }
    CustomerShell(nav, Routes.FAVORITES) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Tus favoritos", "${favs.size} antojos guardados",
                cartCount = state.cartCount, onCart = { nav.navigate(Routes.CART) })
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp)) {
                if (favs.isEmpty()) {
                    AuroraCard {
                        Icon(Icons.Outlined.FavoriteBorder, null, modifier = Modifier.size(40.dp).align(Alignment.CenterHorizontally))
                        Spacer(Modifier.height(8.dp))
                        Text("Aún no tienes favoritos", style = AuroraType.Heading, textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth())
                        Text("Toca el corazón en un producto para guardarlo aquí.", color = Muted,
                            textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp))
                        PrimaryButton("Ver menú", { nav.goTab(Routes.MENU, Routes.HOME) })
                    }
                } else AuroraCard {
                    favs.forEach { p -> ProductRow(p, { nav.navigate(Routes.detail(p.id)) }, { ctx.toast(quickAdd(state, p)) }) }
                }
            }
        }
    }
}

@Composable
fun ProfileScreen(nav: NavHostController, state: AppState) {
    val ctx = LocalContext.current
    val user = state.user
    CustomerShell(nav, Routes.PROFILE) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Mi espacio", cartCount = state.cartCount, onCart = { nav.navigate(Routes.CART) })
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)) {
                AuroraCard {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Box(Modifier.size(64.dp).clip(RoundedCornerShape(50)).background(Arena), contentAlignment = Alignment.Center) {
                            Text(user?.initials ?: "A", style = AuroraType.Heading)
                        }
                        Spacer(Modifier.width(16.dp))
                        Column {
                            Text(user?.name ?: "", style = AuroraType.Heading)
                            Text(user?.email ?: "", color = Muted, fontSize = 13.sp)
                            Text("Cliente Aurora", color = Muted, fontSize = 12.sp)
                        }
                    }
                }
                AuroraCard {
                    val soon = { ctx.toast("Esta pantalla se conectará más adelante") }
                    ProfileRow(Icons.Outlined.Person, "Editar mis datos", null, soon)
                    ProfileRow(Icons.Outlined.LocationOn, "Mis direcciones", "Casa y oficina", soon)
                    ProfileRow(Icons.Outlined.ReceiptLong, "Mis pedidos", null) { nav.goTab(Routes.ORDERS, Routes.HOME) }
                    ProfileRow(Icons.Outlined.Notifications, "Notificaciones", null, soon)
                    ProfileRow(Icons.Outlined.Shield, "Privacidad y ayuda", null, soon)
                }
                Row(
                    Modifier.fillMaxWidth().clickable { state.logout(); nav.navClear(Routes.WELCOME) }.padding(8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(Icons.Outlined.Logout, null, tint = Rojo)
                    Spacer(Modifier.width(12.dp))
                    Text("Cerrar sesión", color = Rojo, fontWeight = FontWeight.Bold)
                }
                Text("Aurora Cafetería · Versión 1.0", color = Muted, fontSize = 12.sp,
                    textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth())
            }
        }
    }
}

@Composable
fun ProfileRow(icon: androidx.compose.ui.graphics.vector.ImageVector, title: String, subtitle: String?, onClick: () -> Unit) {
    Row(Modifier.fillMaxWidth().clickable(onClick = onClick).padding(vertical = 12.dp), verticalAlignment = Alignment.CenterVertically) {
        Icon(icon, null)
        Spacer(Modifier.width(14.dp))
        Column(Modifier.weight(1f)) {
            Text(title, fontWeight = FontWeight.Bold)
            if (subtitle != null) Text(subtitle, color = Muted, fontSize = 12.sp)
        }
        Icon(Icons.Outlined.ChevronRight, null, tint = Muted)
    }
}

@Composable
fun OrdersScreen(nav: NavHostController, state: AppState) {
    val mine = state.orders.filter { it.customerName == state.user?.name }
    CustomerShell(nav, Routes.ORDERS) {
        Column(Modifier.fillMaxSize()) {
            ScreenHeader("Mis pedidos", "${mine.size} en tu historial", cartCount = state.cartCount, onCart = { nav.navigate(Routes.CART) })
            Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)) {
                if (mine.isEmpty()) {
                    AuroraCard {
                        Text("Aún no tienes pedidos", style = AuroraType.Heading)
                        Text("Cuando hagas tu primer pedido, lo verás aquí.", color = Muted, modifier = Modifier.padding(vertical = 8.dp))
                        PrimaryButton("Ver menú", { nav.goTab(Routes.MENU, Routes.HOME) })
                    }
                }
                mine.forEach { o ->
                    AuroraCard(onClick = { nav.navigate(Routes.tracking(o.code)) }) {
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Text(o.code, fontWeight = FontWeight.Bold, fontSize = 17.sp, modifier = Modifier.weight(1f))
                            StatusTag(o.status, if (o.status == "Entregado") Tone.Ok else Tone.Warn)
                        }
                        Text("Hoy ${o.time} · ${o.modality}", color = Muted, fontSize = 13.sp, modifier = Modifier.padding(vertical = 4.dp))
                        Text(o.lines.lines().joinToString(", ") { it.substringBefore(" ·") }, fontSize = 13.sp)
                        Text(money(o.total), fontWeight = FontWeight.Bold, fontSize = 18.sp,
                            modifier = Modifier.align(Alignment.End))
                    }
                }
            }
        }
    }
}
