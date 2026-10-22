package com.aurora.cafeteria.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.unit.sp

/** Paleta tomada del Figma: "Una paleta que sabe a café". */
object AuroraColors {
    val Espresso = Color(0xFF2B1B14)
    val Cafe = Color(0xFF493024)
    val Oro = Color(0xFFC69A58)
    val Crema = Color(0xFFF5EFE5)
    val Blanco = Color(0xFFFFFCF7)

    val Borde = Color(0xFFE9DFCD)
    val Muted = Color(0xFF7A6C62)
    val Arena = Color(0xFFF2E4CC)
    val Verde = Color(0xFF2F6B4F)
    val VerdeBg = Color(0xFFE6EEE6)
    val Rojo = Color(0xFFA33A2E)
    val RojoBg = Color(0xFFF8E8E2)
}


object AuroraType {
    val Display: FontFamily = FontFamily.Serif
    val Body: FontFamily = FontFamily.SansSerif

    val Title = TextStyle(fontFamily = Display, fontSize = 28.sp, lineHeight = 34.sp)
    val Heading = TextStyle(fontFamily = Display, fontSize = 22.sp, lineHeight = 28.sp)
    val Subheading = TextStyle(fontFamily = Display, fontSize = 18.sp)
}

@Composable
fun AuroraTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = lightColorScheme(
            primary = AuroraColors.Espresso,
            onPrimary = AuroraColors.Blanco,
            secondary = AuroraColors.Oro,
            background = AuroraColors.Crema,
            onBackground = AuroraColors.Espresso,
            surface = AuroraColors.Blanco,
            onSurface = AuroraColors.Espresso,
            error = AuroraColors.Rojo
        ),
        content = content
    )
}
