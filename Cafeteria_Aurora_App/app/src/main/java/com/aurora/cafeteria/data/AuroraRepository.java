package com.aurora.cafeteria.data;

import com.aurora.cafeteria.model.Order;
import com.aurora.cafeteria.model.Product;

import java.util.ArrayList;
import java.util.List;

/**
 * Datos de ejemplo EN MEMORIA.
 *
 * Cuando conectes la base de datos, reemplaza el contenido de estos métodos por
 * llamadas HTTP (Volley + PHP/MySQL) que devuelvan los mismos objetos.
 * Las pantallas no cambian: solo consumen Product / Order / CartItem.
 */
public final class AuroraRepository {
    private AuroraRepository() { }

    public static final String PROMO_CODE = "AURORA10";
    public static final double PROMO_PERCENT = 0.10;
    public static final double DELIVERY_FEE = 4.0;

    public static List<Product> getProducts() {
        List<Product> list = new ArrayList<>();
        list.add(new Product(1, "Latte", "Espresso de origen peruano y leche vaporizada.", 8.00, "Cafés", 24, 5));
        list.add(new Product(2, "Cappuccino", "Espresso intenso, espuma delicada.", 7.50, "Cafés", 18, 5));
        list.add(new Product(3, "Frappé de chocolate", "Chocolate, hielo y un toque de felicidad.", 12.00, "Frappés", 4, 5));
        list.add(new Product(4, "Brownie", "Chocolate intenso, corazón suave.", 6.00, "Postres", 3, 3));
        list.add(new Product(5, "Frappé de caramelo", "Caramelo cremoso con hielo frappé.", 12.50, "Frappés", 15, 5));
        list.add(new Product(6, "Cheesecake de maracuyá", "Base crocante y crema suave de maracuyá.", 9.50, "Postres", 0, 3));
        return list;
    }

    public static List<Order> getOrders() {
        List<Order> list = new ArrayList<>();
        list.add(new Order("AU-1048", "Valeria Mendoza",
                "1 Latte regular · S/ 8.00\n1 Frappé de chocolate · S/ 12.00\n1 Brownie · S/ 6.00",
                23.40, "Recojo en tienda", "Yape", true, "Nuevo", "09:41"));
        list.add(new Order("AU-1049", "Diego Ramos",
                "1 Latte regular · S/ 8.00\n1 Cappuccino · S/ 7.50",
                15.50, "Recojo en tienda", "Efectivo al recoger", false, "Nuevo", "09:43"));
        list.add(new Order("AU-1047", "Camila Torres",
                "2 Cappuccino · S/ 15.00",
                15.00, "Delivery", "Plin", true, "En preparación", "09:20"));
        list.add(new Order("AU-1046", "Luis Paredes",
                "1 Cheesecake de maracuyá · S/ 9.50",
                9.50, "Disfrutar en local", "Tarjeta", true, "Entregado", "08:55"));
        return list;
    }
}
