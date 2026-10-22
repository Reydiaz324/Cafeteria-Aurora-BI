package com.aurora.cafeteria.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import com.aurora.cafeteria.R
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
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
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.aurora.cafeteria.AppState
import com.aurora.cafeteria.ui.*
import com.aurora.cafeteria.ui.theme.AuroraColors.Arena
import com.aurora.cafeteria.ui.theme.AuroraColors.Blanco
import com.aurora.cafeteria.ui.theme.AuroraColors.Borde
import com.aurora.cafeteria.ui.theme.AuroraColors.Cafe
import com.aurora.cafeteria.ui.theme.AuroraColors.Crema
import com.aurora.cafeteria.ui.theme.AuroraColors.Espresso
import com.aurora.cafeteria.ui.theme.AuroraColors.Muted
import com.aurora.cafeteria.ui.theme.AuroraColors.Oro
import com.aurora.cafeteria.ui.theme.AuroraType
import kotlinx.coroutines.delay

@Composable
fun SplashScreen(nav: NavHostController) {
    LaunchedEffect(Unit) {
        delay(1800)
        nav.navClear(Routes.WELCOME)
    }
    Box(Modifier.fillMaxSize().background(Espresso), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Box(
                Modifier.size(104.dp).border(2.dp, Oro, CircleShape),
                contentAlignment = Alignment.Center
            ) { Icon(Icons.Outlined.LocalCafe, null, tint = Oro, modifier = Modifier.size(48.dp)) }
            Spacer(Modifier.height(24.dp))
            Text("AURORA", color = Crema, fontFamily = AuroraType.Display, fontSize = 36.sp, letterSpacing = 10.sp)
            Text("CAFETERÍA", color = Oro, fontSize = 13.sp, letterSpacing = 6.sp)
            Spacer(Modifier.height(12.dp))
            Text("CAFÉ · CONEXIÓN · MOMENTOS", color = Oro, fontSize = 11.sp, letterSpacing = 2.sp)
        }
        Text(
            "HECHO PARA TUS MOMENTOS", color = Crema, fontSize = 11.sp, letterSpacing = 1.sp,
            modifier = Modifier.align(Alignment.BottomCenter).padding(bottom = 48.dp)
        )
    }
}

@Composable
fun WelcomeScreen(nav: NavHostController) {
    Column(Modifier.fillMaxSize().background(Blanco)) {
        Box(Modifier.fillMaxWidth().weight(1f)) {
            Image(
                painter = painterResource(R.drawable.welcome_cafe),
                contentDescription = null,
                contentScale = ContentScale.Crop,
                modifier = Modifier.fillMaxSize()
            )
            Box(
                Modifier.padding(20.dp).clip(RoundedCornerShape(18.dp)).background(Espresso).padding(14.dp)
            ) { Text("AURORA", color = Crema, fontFamily = AuroraType.Display, letterSpacing = 4.sp) }
            Box(
                Modifier.align(Alignment.BottomStart).padding(20.dp)
                    .clip(RoundedCornerShape(50)).background(Arena).padding(horizontal = 14.dp, vertical = 8.dp)
            ) { Text("UN MOMENTO SOLO PARA TI", fontSize = 11.sp, fontWeight = FontWeight.Bold, color = Espresso) }
        }
        Column(Modifier.padding(24.dp)) {
            Text("Tu momento favorito comienza aquí", style = AuroraType.Title)
            Spacer(Modifier.height(8.dp))
            Text("Café de especialidad, antojos recién hechos y momentos que se quedan contigo.", color = Muted, fontSize = 15.sp)
            Spacer(Modifier.height(24.dp))
            PrimaryButton("Iniciar sesión", { nav.navigate(Routes.LOGIN) })
            Spacer(Modifier.height(12.dp))
            SecondaryButton("Crear cuenta", { nav.navigate(Routes.REGISTER) })
            Spacer(Modifier.height(16.dp))
            Text(
                "Al continuar aceptas nuestros Términos y la Política de privacidad.",
                color = Muted, fontSize = 11.sp, textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth()
            )
        }
    }
}

@Composable
fun LoginScreen(nav: NavHostController, state: AppState) {
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var error by remember { mutableStateOf<String?>(null) }

    Column(Modifier.fillMaxSize()) {
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState())) {
            ScreenHeader("Qué bueno verte", "Tu pausa favorita te espera", onBack = { nav.popBackStack() })
            Column(Modifier.padding(horizontal = 20.dp), verticalArrangement = Arrangement.spacedBy(14.dp)) {
                Text("Entra a tu cuenta", style = AuroraType.Heading, modifier = Modifier.padding(top = 12.dp))
                AuroraField("Correo electrónico", email, { email = it; error = null },
                    icon = Icons.Outlined.Mail, keyboardType = KeyboardType.Email)
                AuroraField("Contraseña", password, { password = it; error = null },
                    password = true, error = error)
                Text("¿Olvidaste tu contraseña?", fontWeight = FontWeight.SemiBold, fontSize = 14.sp,
                    modifier = Modifier.clickable { nav.navigate(Routes.RECOVER) })
                InfoBanner(
                    "Un solo acceso, tu espacio correcto",
                    "El rol de tu cuenta autenticada determina si entras a la tienda o al panel de administración."
                )
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    Text("¿Es tu primera visita?  ", color = Muted, fontSize = 14.sp)
                    Text("Crear cuenta", fontSize = 14.sp, modifier = Modifier.clickable { nav.navigate(Routes.REGISTER) })
                }
            }
        }
        Box(Modifier.background(Blanco).padding(20.dp)) {
            PrimaryButton("Iniciar sesión", {
                val err = state.login(email, password)
                if (err != null) error = err
                else nav.navClear(if (state.user?.isAdmin == true) Routes.ADMIN_DASHBOARD else Routes.HOME)
            })
        }
    }
}

@Composable
fun RegisterScreen(nav: NavHostController, state: AppState) {
    var name by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var phone by remember { mutableStateOf("") }
    var pass by remember { mutableStateOf("") }
    var confirm by remember { mutableStateOf("") }
    var accepted by remember { mutableStateOf(false) }
    var submitted by remember { mutableStateOf(false) }

    val nameErr = if (submitted && name.isBlank()) "Ingresa tu nombre." else null
    val emailErr = if (submitted && !(email.contains("@") && email.contains("."))) "Ingresa un correo electrónico válido." else null
    val phoneErr = if (submitted && phone.filter { it.isDigit() }.length < 9) "Ingresa un celular válido." else null
    val passOk = pass.length >= 8 && pass.any { it.isLetter() } && pass.any { it.isDigit() }
    val passErr = if (submitted && !passOk) "Mínimo 8 caracteres, letras y números." else null
    val confirmErr = if (submitted && confirm != pass) "Las contraseñas no coinciden." else null

    Column(Modifier.fillMaxSize()) {
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState())) {
            ScreenHeader("Hazlo tu momento", "Crea tu cuenta de cliente", onBack = { nav.popBackStack() })
            Column(Modifier.padding(horizontal = 20.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                AuroraField("Nombre completo", name, { name = it }, error = nameErr)
                AuroraField("Correo electrónico", email, { email = it }, icon = Icons.Outlined.Mail,
                    keyboardType = KeyboardType.Email, error = emailErr)
                AuroraField("Celular", phone, { phone = it }, icon = Icons.Outlined.Phone,
                    keyboardType = KeyboardType.Phone, error = phoneErr)
                AuroraField("Contraseña", pass, { pass = it }, password = true,
                    hint = "Mínimo 8 caracteres, letras y números.", error = passErr)
                AuroraField("Confirmar contraseña", confirm, { confirm = it }, password = true, error = confirmErr)
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Checkbox(accepted, { accepted = it }, colors = CheckboxDefaults.colors(checkedColor = Espresso))
                    Text("Acepto los Términos y la Política de privacidad. Mis datos se usarán para gestionar mis pedidos.",
                        color = Muted, fontSize = 12.sp)
                }
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    Text("¿Ya tienes cuenta?  ", fontSize = 14.sp)
                    Text("Iniciar sesión", fontSize = 14.sp, fontWeight = FontWeight.SemiBold,
                        modifier = Modifier.clickable { nav.navigate(Routes.LOGIN) })
                }
            }
        }
        Box(Modifier.background(Blanco).padding(20.dp)) {
            PrimaryButton("Crear cuenta", {
                submitted = true
                val ok = name.isNotBlank() && email.contains("@") && email.contains(".") &&
                        phone.filter { it.isDigit() }.length >= 9 && passOk && confirm == pass && accepted
                if (ok) {
                    state.register(name, email, phone)
                    nav.navClear(Routes.HOME)
                }
            })
        }
    }
}

@Composable
fun RecoverScreen(nav: NavHostController) {
    var email by remember { mutableStateOf("") }
    var sent by remember { mutableStateOf(false) }
    Column(Modifier.fillMaxSize()) {
        Column(Modifier.weight(1f).verticalScroll(rememberScrollState())) {
            ScreenHeader("Recupera tu acceso", "Te enviaremos un enlace", onBack = { nav.popBackStack() })
            Column(Modifier.padding(horizontal = 20.dp), verticalArrangement = Arrangement.spacedBy(14.dp)) {
                AuroraField("Correo electrónico", email, { email = it; sent = false },
                    icon = Icons.Outlined.Mail, keyboardType = KeyboardType.Email)
                if (sent) InfoBanner("Revisa tu correo", "Si la cuenta existe, recibirás un enlace para crear una nueva contraseña.",
                    Tone.Ok, Icons.Outlined.CheckCircle)
            }
        }
        Box(Modifier.background(Blanco).padding(20.dp)) {
            PrimaryButton("Enviar enlace", { if (email.contains("@")) sent = true })
        }
    }
}
