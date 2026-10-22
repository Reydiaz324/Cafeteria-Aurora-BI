package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.aurora.cafeteria.AppState
import com.aurora.cafeteria.data.AuroraRepository
import com.aurora.cafeteria.ui.*
import com.aurora.cafeteria.ui.theme.AuroraColors.Arena
import com.aurora.cafeteria.ui.theme.AuroraColors.Blanco
import com.aurora.cafeteria.ui.theme.AuroraColors.Borde
import com.aurora.cafeteria.ui.theme.AuroraColors.Crema
import com.aurora.cafeteria.ui.theme.AuroraColors.Espresso
import com.aurora.cafeteria.ui.theme.AuroraColors.Muted
import com.aurora.cafeteria.ui.theme.AuroraColors.Oro
import com.aurora.cafeteria.ui.theme.AuroraColors.Rojo
import com.aurora.cafeteria.ui.theme.AuroraColors.Verde
import com.aurora.cafeteria.ui.theme.AuroraColors.VerdeBg
import com.aurora.cafeteria.ui.theme.AuroraType

@Composable
private fun BottomAction(content: @Composable () -> Unit) {
    Column(Modifier.background(Blanco)) {
        HorizontalDivider(color = Borde)
        Box(Modifier.padding(20.dp)) { content() }
    }
}

@Composable
private fun SummaryRow(label: String, value: String, bold: Boolean = false) {
    Row(Modifier.fillMaxWidth().padding(vertical = 3.dp)) {
        Text(label, color = if (bold) Espresso else Muted, fontWeight = if (bold) FontWeight.Bold else FontWeight.Normal,
            fontSize = if (bold) 18.sp else 14.sp, modifier = Modifier.weight(1f))
        Text(value, fontWeight = if (bold) FontWeight.Bold else FontWeight.Normal, fontSize = if (bold) 24.sp else 14.sp)
    }
}

// ---------------- Carrito ----------------

@Composable
fun CartScreen(nav: NavHostController, state: AppState) {
    val itemsCount = state.cartCount
    Column(Modifier.fillMaxSize()) {
        ScreenHeader("Tu carrito",
            if (state.cart.isEmpty()) null else "$itemsCount productos para un buen momento",
            onBack = { nav.popBackStack() })

        if (state.cart.isEmpty()) {
            Column(Modifier.weight(1f).padding(20.dp)) {
                AuroraCard {
                    Icon(Icons.Outlined.ShoppingBag, null, modifier = Modifier.size(44.dp).align(Alignment.CenterHorizontally))
                    Text("Tu próximo momento empieza aquí", style = AuroraType.Heading, textAlign = TextAlign.Center,
                        modifier = Modifier.fillMaxWidth().padding(top = 12.dp))
                    Text("Agrega tu café favorito y un antojo para acompañarlo.", color = Muted, fontSize = 14.sp,
                        textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth().padding(vertical = 12.dp))
                    PrimaryButton("Ver menú", { nav.goTab(Routes.MENU, Routes.HOME) })
                }
            }
            return@Column
        }

        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)) {
            state.cart.forEachIndexed { index, item ->
                Row(verticalAlignment = Alignment.Top) {
                    ProductImage(item.product.category, Modifier.size(72.dp))
                    Spacer(Modifier.width(12.dp))
                    Column(Modifier.weight(1f)) {
                        Row {
                            Text(item.product.name, fontWeight = FontWeight.Bold, modifier = Modifier.weight(1f))
                            Icon(Icons.Outlined.DeleteOutline, "Quitar", tint = Muted,
                                modifier = Modifier.size(22.dp).clickable { state.cart.removeAt(index) })
                        }
                        Text(item.optionsLabel, color = Muted, fontSize = 12.sp)
                        Spacer(Modifier.height(6.dp))
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Box(Modifier.weight(1f)) {
                                QuantityStepper(item.quantity, { state.cart[index] = item.withQuantity(it) })
                            }
                            Text(money(item.lineTotal), fontWeight = FontWeight.Bold, fontSize = 16.sp)
                        }
                    }
                }
            }

            // Código promocional
            Row(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(14.dp)).background(Blanco)
                    .border(1.dp, Borde, RoundedCornerShape(14.dp)).padding(14.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(AuroraRepository.PROMO_CODE, fontWeight = FontWeight.SemiBold, modifier = Modifier.weight(1f))
                if (state.promoApplied) {
                    Box(Modifier.clip(RoundedCornerShape(50)).background(VerdeBg).clickable { state.promoApplied = false }
                        .padding(horizontal = 12.dp, vertical = 5.dp)) {
                        Text("Aplicado ✓", color = Verde, fontSize = 12.sp, fontWeight = FontWeight.SemiBold)
                    }
                } else {
                    Box(Modifier.clip(RoundedCornerShape(50)).background(Arena).clickable { state.promoApplied = true }
                        .padding(horizontal = 12.dp, vertical = 5.dp)) {
                        Text("Aplicar", fontSize = 12.sp, fontWeight = FontWeight.SemiBold)
                    }
                }
            }

            AuroraCard {
                SummaryRow("Subtotal", money(state.subtotal))
                if (state.promoApplied) SummaryRow("${AuroraRepository.PROMO_CODE} · 10%", "– " + money(state.discount))
                SummaryRow("Envío", money(state.shipping))
                HorizontalDivider(color = Borde, modifier = Modifier.padding(vertical = 8.dp))
                SummaryRow("Total", money(state.total), bold = true)
            }
            InfoBanner("Aún no reservamos tus productos", "El stock se valida al confirmar el pedido, no al agregar al carrito.")
            Spacer(Modifier.height(8.dp))
        }
        BottomAction { PrimaryButton("Continuar · ${money(state.total)}", { nav.navigate(Routes.MODALITY) }) }
    }
}

// ---------------- Modalidad ----------------

@Composable
fun ModalityScreen(nav: NavHostController, state: AppState) {
    val options = listOf(
        Triple("Recojo en tienda", "Sin costo · Aurora Lince", Icons.Outlined.ShoppingBag),
        Triple("Disfrutar en local", "Disponible hoy · Mesa al llegar", Icons.Outlined.Chair),
        Triple("Delivery", "Habilitado · Desde S/ 4.00", Icons.Outlined.DeliveryDining)
    )
    val slots = listOf("09:55–10:00", "10:15", "10:30")

    Column(Modifier.fillMaxSize()) {
        ScreenHeader("¿Cómo lo disfrutarás?", "Paso 1 de 3 · Modalidad", onBack = { nav.popBackStack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)) {
            options.forEach { (name, desc, icon) ->
                AuroraCard(selected = state.modality == name, onClick = { state.modality = name }) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(icon, null)
                        Spacer(Modifier.width(14.dp))
                        Column(Modifier.weight(1f)) {
                            Text(name, fontWeight = FontWeight.Bold)
                            Text(desc, color = Muted, fontSize = 13.sp)
                        }
                        RadioButton(state.modality == name, { state.modality = name },
                            colors = RadioButtonDefaults.colors(selectedColor = Espresso))
                    }
                }
            }
            if (state.modality == "Delivery") {
                AuroraField("Dirección de entrega", state.address, { state.address = it },
                    icon = Icons.Outlined.LocationOn, hint = "Ej. Av. Arenales 1820, Lince")
            } else {
                AuroraCard {
                    Text("Aurora Lince", style = AuroraType.Subheading)
                    Text("Av. Arenales 1820 · Hoy 07:30–21:00", color = Muted, fontSize = 13.sp, modifier = Modifier.padding(vertical = 4.dp))
                    StatusTag("Abierto ahora", Tone.Ok)
                }
                Text("Horario", fontWeight = FontWeight.SemiBold, fontSize = 14.sp)
                Row(Modifier.horizontalScroll(rememberScrollState()), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    slots.forEach { slot -> AuroraChip(slot, state.pickupSlot == slot) { state.pickupSlot = slot } }
                }
            }
            Row(verticalAlignment = Alignment.CenterVertically) {
                Text(if (state.modality == "Delivery") "Total con envío" else "Total con ${AuroraRepository.PROMO_CODE}",
                    color = Muted, modifier = Modifier.weight(1f))
                Text(money(state.total), fontWeight = FontWeight.Bold, fontSize = 24.sp)
            }
        }
        BottomAction {
            PrimaryButton("Continuar · ${money(state.total)}", {
                if (state.modality == "Delivery" && state.payment == "Efectivo al recoger") state.payment = "Yape"
                nav.navigate(Routes.PAYMENT)
            }, enabled = !(state.modality == "Delivery" && state.address.isBlank()))
        }
    }
}

// ---------------- Pago (simulado) ----------------

@Composable
fun PaymentScreen(nav: NavHostController, state: AppState) {
    var problem by remember { mutableStateOf<String?>(null) }
    val methods = buildList<Triple<String, String, ImageVector>> {
        add(Triple("Yape", "Confirmación de muestra", Icons.Outlined.PhoneAndroid))
        add(Triple("Plin", "Confirmación de muestra", Icons.Outlined.PhoneAndroid))
        add(Triple("Tarjeta", "Sin ingresar datos bancarios", Icons.Outlined.CreditCard))
        if (state.modality != "Delivery") add(Triple("Efectivo al recoger", "Disponible solo para recojo en tienda", Icons.Outlined.Payments))
    }

    Column(Modifier.fillMaxSize()) {
        ScreenHeader("Elige cómo pagar", "Paso 2 de 3 · ${state.modality}", onBack = { nav.popBackStack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)) {
            InfoBanner("PAGOS SIMULADOS", "Esta maqueta no procesa cobros ni está conectada a bancos o billeteras.")
            if (problem != null) InfoBanner("Unidades insuficientes", problem!!, Tone.Bad, Icons.Outlined.WarningAmber)
            methods.forEach { (name, desc, icon) ->
                AuroraCard(selected = state.payment == name, onClick = { state.payment = name }) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(icon, null)
                        Spacer(Modifier.width(14.dp))
                        Column(Modifier.weight(1f)) {
                            Text(name, fontWeight = FontWeight.Bold)
                            Text(desc, color = Muted, fontSize = 13.sp)
                        }
                        RadioButton(state.payment == name, { state.payment = name },
                            colors = RadioButtonDefaults.colors(selectedColor = Espresso))
                    }
                }
            }
            AuroraCard {
                Text("Tu momento · ${state.cartCount} productos", fontWeight = FontWeight.Bold)
                Spacer(Modifier.height(6.dp))
                state.cart.forEach {
                    Text("${it.quantity} ${it.product.name} ${it.size.lowercase()} · ${money(it.lineTotal)}", color = Muted, fontSize = 13.sp)
                }
                Spacer(Modifier.height(6.dp))
                Row(verticalAlignment = Alignment.Bottom) {
                    if (state.promoApplied) Text("${AuroraRepository.PROMO_CODE} · – ${money(state.discount)}",
                        color = Verde, fontSize = 12.sp, modifier = Modifier.weight(1f))
                    else Spacer(Modifier.weight(1f))
                    Text(money(state.total), fontWeight = FontWeight.Bold, fontSize = 24.sp)
                }
            }
        }
        BottomAction {
            PrimaryButton("Continuar con ${state.payment.substringBefore(" ")}", {
                val p = state.stockProblem()
                if (p != null) problem = p
                else {
                    val order = state.placeOrder()
                    nav.navigate(Routes.confirmation(order.code)) { popUpTo(Routes.CART) { inclusive = true } }
                }
            })
        }
    }
}

// ---------------- Confirmación ----------------

@Composable
fun ConfirmationScreen(nav: NavHostController, state: AppState, code: String) {
    val order = state.orders.firstOrNull { it.code == code }
    Column(Modifier.fillMaxSize()) {
        ScreenHeader("¡Ya es tu momento!")
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(14.dp)) {
            Box(Modifier.size(84.dp).clip(CircleShape).background(VerdeBg), contentAlignment = Alignment.Center) {
                Icon(Icons.Outlined.Check, null, tint = Verde, modifier = Modifier.size(40.dp))
            }
            Text(code, style = AuroraType.Title.copy(fontSize = 36.sp))
            Text("Gracias, ${state.user?.firstName ?: ""}. Ya recibimos tu pedido.", color = Muted, textAlign = TextAlign.Center)
            if (order != null) {
                AuroraCard(selected = true) {
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(Icons.Outlined.ShoppingBag, null)
                        Spacer(Modifier.width(12.dp))
                        Column {
                            Text(if (order.modality == "Delivery") "Delivery" else "${order.modality} · ${state.pickupSlot}", fontWeight = FontWeight.Bold)
                            Text("Aurora Lince · Av. Arenales 1820", color = Muted, fontSize = 13.sp)
                        }
                    }
                }
                AuroraCard {
                    Text("Tu momento", fontWeight = FontWeight.Bold)
                    Spacer(Modifier.height(6.dp))
                    order.lines.lines().forEach { Text(it, color = Muted, fontSize = 13.sp) }
                    Text(money(order.total), fontWeight = FontWeight.Bold, fontSize = 24.sp,
                        modifier = Modifier.align(Alignment.End))
                }
                if (order.isPaymentConfirmed)
                    InfoBanner("Pago confirmado · ${order.payment} · SIMULADO",
                        "Total ${money(order.total)}. No se realizó ningún cobro real.", Tone.Ok, Icons.Outlined.CheckCircle)
                else
                    InfoBanner("Pago pendiente · ${order.payment}", "Pagarás al recoger. Total ${money(order.total)}.")
            }
            Text("Muestra este código al recoger. Preparación estimada: 15–20 minutos.", color = Muted,
                fontSize = 13.sp, textAlign = TextAlign.Center)
        }
        BottomAction { PrimaryButton("Seguir mi pedido", { nav.navigate(Routes.tracking(code)) { popUpTo(Routes.HOME) } }) }
    }
}

// ---------------- Seguimiento ----------------

@Composable
fun TrackingScreen(nav: NavHostController, state: AppState, code: String) {
    val order = state.orders.firstOrNull { it.code == code }
    if (order == null) { LaunchedEffect(Unit) { nav.popBackStack() }; return }

    val steps = listOf(
        "Pedido recibido" to "Código $code",
        "Pago confirmado" to "${order.payment}${if (order.isPaymentConfirmed) " · SIMULADO" else " · Pendiente"}",
        "En preparación" to "Tu barista está en ello",
        "Listo para recoger" to "Te avisaremos",
        "Entregado" to "Te esperamos en Aurora"
    )
    val doneUntil = when (order.status) {
        "En preparación" -> 2
        "Listo" -> 3
        "Entregado" -> 4
        else -> if (order.isPaymentConfirmed) 1 else 0
    }

    Column(Modifier.fillMaxSize()) {
        ScreenHeader("Tu pedido $code", onBack = { nav.popBackStack() })
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState()).padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)) {
            Column(Modifier.fillMaxWidth().clip(RoundedCornerShape(24.dp)).background(Espresso).padding(20.dp)) {
                Text("${order.modality.uppercase()} EN AURORA LINCE", color = Oro, fontSize = 11.sp, letterSpacing = 1.sp)
                Text(if (order.status == "Entregado") "Entregado" else "Listo en 15–20 min", color = Blanco,
                    style = AuroraType.Heading.copy(fontSize = 26.sp), modifier = Modifier.padding(vertical = 6.dp))
                Text("Hoy · Te avisaremos", color = Blanco, fontSize = 13.sp)
            }
            steps.forEachIndexed { i, (title, sub) ->
                val done = i <= doneUntil
                val active = i == doneUntil + 1
                Row(verticalAlignment = Alignment.Top) {
                    Box(
                        Modifier.size(32.dp).clip(CircleShape)
                            .background(if (done || active) Espresso else Arena),
                        contentAlignment = Alignment.Center
                    ) {
                        when {
                            done -> Icon(Icons.Outlined.Check, null, tint = Blanco, modifier = Modifier.size(18.dp))
                            active -> Icon(Icons.Outlined.LocalCafe, null, tint = Blanco, modifier = Modifier.size(18.dp))
                            else -> Box(Modifier.size(10.dp).clip(CircleShape).background(Muted))
                        }
                    }
                    Spacer(Modifier.width(14.dp))
                    Column {
                        Text(title, fontWeight = FontWeight.Bold, color = if (done || active) Espresso else Muted)
                        Text(sub, color = Muted, fontSize = 12.sp)
                    }
                }
            }
            AuroraCard {
                Text("Detalle del pedido", fontWeight = FontWeight.Bold)
                Spacer(Modifier.height(6.dp))
                order.lines.lines().forEach { Text(it, color = Muted, fontSize = 13.sp) }
                Text(money(order.total), fontWeight = FontWeight.Bold, fontSize = 22.sp, modifier = Modifier.align(Alignment.End))
            }
            InfoBanner("Avisos de estado · SIMULADOS", "En delivery, «Listo» cambia a «En camino» antes de «Entregado».")
            Spacer(Modifier.height(8.dp))
        }
    }
}
