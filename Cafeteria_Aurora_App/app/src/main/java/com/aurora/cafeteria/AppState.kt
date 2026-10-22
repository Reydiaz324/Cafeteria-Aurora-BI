package com.aurora.cafeteria

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import com.aurora.cafeteria.data.AuroraRepository
import com.aurora.cafeteria.model.CartItem
import com.aurora.cafeteria.model.Order
import com.aurora.cafeteria.model.Product
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

data class User(val name: String, val email: String, val phone: String, val isAdmin: Boolean) {
    val firstName: String get() = name.trim().split(" ").firstOrNull().orEmpty()
    val initials: String
        get() = name.trim().split(" ").filter { it.isNotEmpty() }.take(2)
            .joinToString("") { it.first().uppercase() }
}

/**
 * Estado global de la app (en memoria). Cuando conectes la base de datos,
 * las funciones de aquí (login, register, placeOrder, etc.) llamarán a tu API.
 */
class AppState {
    val products = mutableStateListOf<Product>().apply { addAll(AuroraRepository.getProducts()) }
    val orders = mutableStateListOf<Order>().apply { addAll(AuroraRepository.getOrders()) }
    val cart = mutableStateListOf<CartItem>()
    val favorites = mutableStateListOf<Int>()

    var user by mutableStateOf<User?>(null)
    var promoApplied by mutableStateOf(true)

    // Datos del checkout
    var modality by mutableStateOf("Recojo en tienda")
    var pickupSlot by mutableStateOf("09:55–10:00")
    var address by mutableStateOf("")
    var payment by mutableStateOf("Yape")

    private val accounts = mutableMapOf<String, User>()
    private var orderCounter = 1050

    // ---------- Sesión ----------

    /** Devuelve un mensaje de error o null si todo bien. */
    fun login(email: String, password: String): String? {
        val e = email.trim().lowercase()
        if (!e.contains("@") || !e.contains(".")) return "Ingresa un correo electrónico válido."
        if (password.length < 6) return "La contraseña debe tener al menos 6 caracteres."
        // DEMO: un correo que empiece con "admin" entra al panel de administración.
        user = accounts[e] ?: User(
            name = e.substringBefore("@").replaceFirstChar { it.uppercase() },
            email = e, phone = "", isAdmin = e.startsWith("admin")
        )
        return null
    }

    fun register(name: String, email: String, phone: String) {
        val u = User(name.trim(), email.trim().lowercase(), phone.trim(), false)
        accounts[u.email] = u
        user = u
    }

    fun logout() {
        user = null
        cart.clear()
    }

    // ---------- Carrito ----------

    fun addToCart(p: Product, qty: Int, size: String, temp: String, extras: String, unitPrice: Double) {
        val i = cart.indexOfFirst {
            it.product.id == p.id && it.size == size && it.temperature == temp && it.extras == extras
        }
        if (i >= 0) cart[i] = cart[i].withQuantity(cart[i].quantity + qty)
        else cart.add(CartItem(p, qty, size, temp, extras, unitPrice))
    }

    val cartCount: Int get() = cart.sumOf { it.quantity }
    val subtotal: Double get() = cart.sumOf { it.lineTotal }
    val discount: Double get() = if (promoApplied) subtotal * AuroraRepository.PROMO_PERCENT else 0.0
    val shipping: Double get() = if (modality == "Delivery" && cart.isNotEmpty()) AuroraRepository.DELIVERY_FEE else 0.0
    val total: Double get() = subtotal - discount + shipping

    /** El stock se valida al confirmar el pedido, no al agregar al carrito (como indica el diseño). */
    fun stockProblem(): String? {
        for (item in cart) {
            val p = products.firstOrNull { it.id == item.product.id } ?: return "Un producto ya no está disponible."
            if (item.quantity > p.stock) {
                return if (p.stock <= 0) "${p.name} está agotado. Quítalo del carrito."
                else "Queda ${p.stock} ${p.name}. Revisa la cantidad."
            }
        }
        return null
    }

    fun placeOrder(): Order {
        val code = "AU-${orderCounter++}"
        val lines = cart.joinToString("\n") {
            "${it.quantity} ${it.product.name} ${it.size.lowercase()} · ${com.aurora.cafeteria.ui.money(it.lineTotal)}"
        }
        val paid = payment != "Efectivo al recoger"
        val now = SimpleDateFormat("HH:mm", Locale.getDefault()).format(Date())
        val order = Order(code, user?.name ?: "Cliente", lines, total, modality, payment, paid, "Nuevo", now)

        cart.forEach { item ->
            val i = products.indexOfFirst { it.id == item.product.id }
            if (i >= 0) products[i] = products[i].withStock(products[i].stock - item.quantity)
        }
        orders.add(0, order)
        cart.clear()
        return order
    }

    // ---------- Favoritos ----------

    fun toggleFavorite(id: Int) {
        if (favorites.contains(id)) favorites.remove(id) else favorites.add(id)
    }

    // ---------- Administración ----------

    fun updateOrder(code: String, transform: (Order) -> Order) {
        val i = orders.indexOfFirst { it.code == code }
        if (i >= 0) orders[i] = transform(orders[i])
    }

    fun saveProduct(id: Int, name: String, description: String, price: Double, category: String, stock: Int) {
        val i = products.indexOfFirst { it.id == id }
        if (i >= 0) {
            products[i] = products[i].edited(name, description, price, category, stock)
        } else {
            val newId = (products.maxOfOrNull { it.id } ?: 0) + 1
            products.add(Product(newId, name, description, price, category, stock, 5))
        }
    }

    fun deleteProduct(id: Int) {
        products.removeAll { it.id == id }
        favorites.remove(id)
    }

    fun adjustStock(id: Int, delta: Int) {
        val i = products.indexOfFirst { it.id == id }
        if (i >= 0) products[i] = products[i].withStock(products[i].stock + delta)
    }
}
