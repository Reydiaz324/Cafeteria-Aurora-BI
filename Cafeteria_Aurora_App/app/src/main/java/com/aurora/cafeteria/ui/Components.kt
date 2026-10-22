package com.aurora.cafeteria.ui

import android.content.Context
import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.aurora.cafeteria.model.Product
import com.aurora.cafeteria.ui.theme.AuroraColors.Arena
import com.aurora.cafeteria.ui.theme.AuroraColors.Blanco
import com.aurora.cafeteria.ui.theme.AuroraColors.Borde
import com.aurora.cafeteria.ui.theme.AuroraColors.Cafe
import com.aurora.cafeteria.ui.theme.AuroraColors.Crema
import com.aurora.cafeteria.ui.theme.AuroraColors.Espresso
import com.aurora.cafeteria.ui.theme.AuroraColors.Muted
import com.aurora.cafeteria.ui.theme.AuroraColors.Oro
import com.aurora.cafeteria.ui.theme.AuroraColors.Rojo
import com.aurora.cafeteria.ui.theme.AuroraColors.RojoBg
import com.aurora.cafeteria.ui.theme.AuroraColors.Verde
import com.aurora.cafeteria.ui.theme.AuroraColors.VerdeBg
import com.aurora.cafeteria.ui.theme.AuroraType
import java.util.Locale

// ---------- Utilidades ----------

fun money(v: Double): String = "S/ " + String.format(Locale.US, "%.2f", v)

fun Context.toast(msg: String) = Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()

fun Product.isOut() = stock <= 0
fun Product.isLow() = stock in 1..minStock

// ---------- Botones ----------

@Composable
fun PrimaryButton(text: String, onClick: () -> Unit, modifier: Modifier = Modifier, enabled: Boolean = true) {
    Button(
        onClick = onClick,
        enabled = enabled,
        modifier = modifier.fillMaxWidth().height(50.dp),
        shape = RoundedCornerShape(18.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = Espresso, contentColor = Blanco,
            disabledContainerColor = Color(0xFFEDE6DA), disabledContentColor = Muted
        )
    ) { Text(text, fontWeight = FontWeight.SemiBold, fontSize = 15.sp) }
}

@Composable
fun SecondaryButton(text: String, onClick: () -> Unit, modifier: Modifier = Modifier) {
    OutlinedButton(
        onClick = onClick,
        modifier = modifier.fillMaxWidth().height(50.dp),
        shape = RoundedCornerShape(18.dp),
        border = androidx.compose.foundation.BorderStroke(1.dp, Borde),
        colors = ButtonDefaults.outlinedButtonColors(containerColor = Blanco, contentColor = Espresso)
    ) { Text(text, fontWeight = FontWeight.SemiBold, fontSize = 15.sp) }
}

// ---------- Campos ----------

@Composable
fun AuroraField(
    label: String,
    value: String,
    onValueChange: (String) -> Unit,
    modifier: Modifier = Modifier,
    icon: ImageVector? = null,
    password: Boolean = false,
    keyboardType: KeyboardType = KeyboardType.Text,
    hint: String? = null,
    error: String? = null
) {
    var visible by remember { mutableStateOf(false) }
    val shape = RoundedCornerShape(14.dp)
    Column(modifier) {
        Row(
            Modifier.fillMaxWidth().clip(shape).background(Blanco)
                .border(1.dp, if (error != null) Rojo else Borde, shape)
                .padding(start = 14.dp, end = 8.dp, top = 10.dp, bottom = 10.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column(Modifier.weight(1f)) {
                Text(label, fontSize = 12.sp, color = Muted, fontWeight = FontWeight.SemiBold)
                BasicTextField(
                    value = value,
                    onValueChange = onValueChange,
                    singleLine = true,
                    textStyle = TextStyle(fontSize = 16.sp, color = Espresso),
                    cursorBrush = SolidColor(Espresso),
                    visualTransformation = if (password && !visible) PasswordVisualTransformation() else VisualTransformation.None,
                    keyboardOptions = KeyboardOptions(keyboardType = if (password) KeyboardType.Password else keyboardType),
                    modifier = Modifier.fillMaxWidth().padding(top = 4.dp)
                )
            }
            if (password) {
                IconButton(onClick = { visible = !visible }, modifier = Modifier.size(36.dp)) {
                    Icon(if (visible) Icons.Outlined.Visibility else Icons.Outlined.VisibilityOff, "Mostrar u ocultar", tint = Muted)
                }
            } else if (icon != null) {
                Icon(icon, null, tint = Muted, modifier = Modifier.padding(end = 6.dp))
            }
        }
        if (error != null) {
            Text(error, color = Rojo, fontSize = 12.sp, modifier = Modifier.padding(start = 4.dp, top = 4.dp))
        } else if (hint != null) {
            Text(hint, color = Muted, fontSize = 12.sp, modifier = Modifier.padding(start = 4.dp, top = 4.dp))
        }
    }
}

// ---------- Contenedores ----------

@Composable
fun AuroraCard(
    modifier: Modifier = Modifier,
    selected: Boolean = false,
    onClick: (() -> Unit)? = null,
    content: @Composable ColumnScope.() -> Unit
) {
    val shape = RoundedCornerShape(18.dp)
    var m = modifier.fillMaxWidth().clip(shape).background(Blanco)
        .border(if (selected) 1.5.dp else 1.dp, if (selected) Oro else Borde, shape)
    if (onClick != null) m = m.clickable(onClick = onClick)
    Column(m.padding(16.dp), content = content)
}

enum class Tone { Neutral, Ok, Warn, Bad }

@Composable
fun StatusTag(text: String, tone: Tone) {
    val (bg, fg) = when (tone) {
        Tone.Ok -> VerdeBg to Verde
        Tone.Warn -> Arena to Cafe
        Tone.Bad -> RojoBg to Rojo
        Tone.Neutral -> Arena to Espresso
    }
    Box(Modifier.clip(RoundedCornerShape(50)).background(bg).padding(horizontal = 12.dp, vertical = 5.dp)) {
        Text(text, color = fg, fontSize = 12.sp, fontWeight = FontWeight.SemiBold)
    }
}

@Composable
fun InfoBanner(title: String, text: String, tone: Tone = Tone.Warn, icon: ImageVector = Icons.Outlined.Info) {
    val (bg, fg) = when (tone) {
        Tone.Ok -> VerdeBg to Verde
        Tone.Bad -> RojoBg to Rojo
        else -> Arena to Espresso
    }
    Row(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(bg).padding(14.dp),
        verticalAlignment = Alignment.Top
    ) {
        Icon(icon, null, tint = fg, modifier = Modifier.size(22.dp))
        Spacer(Modifier.width(10.dp))
        Column {
            Text(title, fontWeight = FontWeight.Bold, fontSize = 13.sp, color = fg)
            Text(text, fontSize = 13.sp, color = fg)
        }
    }
}

@Composable
fun AuroraChip(text: String, selected: Boolean, onClick: () -> Unit) {
    val shape = RoundedCornerShape(50)
    Box(
        Modifier.clip(shape).background(if (selected) Espresso else Blanco)
            .border(1.dp, if (selected) Espresso else Borde, shape)
            .clickable(onClick = onClick).padding(horizontal = 16.dp, vertical = 9.dp)
    ) {
        Text(text, color = if (selected) Blanco else Espresso, fontSize = 13.sp,
            fontWeight = if (selected) FontWeight.SemiBold else FontWeight.Normal)
    }
}

@Composable
fun QuantityStepper(value: Int, onChange: (Int) -> Unit, max: Int = 99) {
    val shape = RoundedCornerShape(14.dp)
    Row(
        Modifier.clip(shape).background(Blanco).border(1.dp, Borde, shape),
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(onClick = { if (value > 1) onChange(value - 1) }, modifier = Modifier.size(40.dp)) {
            Icon(Icons.Outlined.Remove, "Menos")
        }
        Text("$value", fontWeight = FontWeight.SemiBold, modifier = Modifier.widthIn(min = 24.dp))
        IconButton(onClick = { if (value < max) onChange(value + 1) }, modifier = Modifier.size(40.dp)) {
            Icon(Icons.Outlined.Add, "Más")
        }
    }
}

// ---------- Imagen de producto (placeholder) ----------

@Composable
fun ProductImage(category: String, modifier: Modifier = Modifier) {
    val icon = when (category) {
        "Postres" -> Icons.Outlined.Cake
        "Frappés" -> Icons.Outlined.LocalDrink
        else -> Icons.Outlined.LocalCafe
    }
    Box(
        modifier.clip(RoundedCornerShape(18.dp))
            .background(Brush.linearGradient(listOf(Cafe, Color(0xFF8A5A3C), Oro))),
        contentAlignment = Alignment.Center
    ) { Icon(icon, null, tint = Crema, modifier = Modifier.size(34.dp)) }
}

// ---------- Fila de producto ----------

@Composable
fun ProductRow(product: Product, onClick: () -> Unit, onAdd: () -> Unit) {
    Row(
        Modifier.fillMaxWidth().clickable(onClick = onClick).padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        ProductImage(product.category, Modifier.size(80.dp))
        Spacer(Modifier.width(12.dp))
        Column(Modifier.weight(1f)) {
            Text(product.name, fontWeight = FontWeight.Bold, fontSize = 15.sp)
            val desc = when {
                product.isOut() -> "Agotado por hoy"
                product.isLow() -> "Pocas unidades · Quedan ${product.stock}"
                else -> product.description
            }
            Text(desc, fontSize = 12.sp, color = Muted, maxLines = 2)
            Text(money(product.price), fontWeight = FontWeight.Bold, fontSize = 15.sp, modifier = Modifier.padding(top = 2.dp))
        }
        Spacer(Modifier.width(8.dp))
        Box(
            Modifier.size(44.dp).clip(RoundedCornerShape(14.dp))
                .background(if (product.isOut()) Color(0xFFEDE6DA) else Espresso)
                .clickable(enabled = !product.isOut(), onClick = onAdd),
            contentAlignment = Alignment.Center
        ) {
            Icon(Icons.Outlined.Add, "Agregar", tint = if (product.isOut()) Muted else Blanco)
        }
    }
}

// ---------- Encabezado ----------

@Composable
fun CartButton(count: Int, onClick: () -> Unit) {
    Box(
        Modifier.size(44.dp).clip(RoundedCornerShape(14.dp)).background(Blanco).clickable(onClick = onClick),
        contentAlignment = Alignment.Center
    ) {
        Icon(Icons.Outlined.ShoppingBag, "Carrito")
        if (count > 0) {
            Box(
                Modifier.align(Alignment.TopEnd).padding(top = 4.dp, end = 6.dp).size(16.dp)
                    .clip(CircleShape).background(Espresso),
                contentAlignment = Alignment.Center
            ) { Text("$count", color = Blanco, fontSize = 10.sp, fontWeight = FontWeight.Bold) }
        }
    }
}

@Composable
fun ScreenHeader(
    title: String,
    subtitle: String? = null,
    onBack: (() -> Unit)? = null,
    cartCount: Int? = null,
    onCart: (() -> Unit)? = null,
    trailing: (@Composable () -> Unit)? = null
) {
    Row(
        Modifier.fillMaxWidth().padding(horizontal = 20.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        if (onBack != null) {
            IconButton(onClick = onBack, modifier = Modifier.size(36.dp)) { Icon(Icons.Outlined.ArrowBack, "Volver") }
            Spacer(Modifier.width(8.dp))
        }
        Column(Modifier.weight(1f)) {
            Text(title, style = AuroraType.Title)
            if (subtitle != null) Text(subtitle, fontSize = 12.sp, color = Muted)
        }
        if (trailing != null) trailing()
        if (cartCount != null && onCart != null) CartButton(cartCount, onCart)
    }
}

// ---------- Barra inferior ----------

data class NavItem(val route: String, val label: String, val icon: ImageVector)

@Composable
fun AuroraBottomBar(items: List<NavItem>, current: String?, onSelect: (String) -> Unit) {
    Column {
        HorizontalDivider(color = Borde)
        Row(
            Modifier.fillMaxWidth().background(Blanco).padding(vertical = 8.dp),
            horizontalArrangement = Arrangement.SpaceAround
        ) {
            items.forEach { item ->
                val sel = item.route == current
                Column(
                    Modifier.clickable { onSelect(item.route) }.padding(horizontal = 6.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Box(
                        Modifier.clip(RoundedCornerShape(50))
                            .background(if (sel) Arena else Color.Transparent)
                            .padding(horizontal = 16.dp, vertical = 6.dp)
                    ) { Icon(item.icon, item.label, tint = Espresso) }
                    Text(item.label, fontSize = 11.sp, color = if (sel) Espresso else Muted,
                        fontWeight = if (sel) FontWeight.SemiBold else FontWeight.Normal)
                }
            }
        }
    }
}
