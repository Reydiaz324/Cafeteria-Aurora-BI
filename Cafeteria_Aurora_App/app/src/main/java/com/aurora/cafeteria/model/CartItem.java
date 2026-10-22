package com.aurora.cafeteria.model;

/** Línea del carrito. */
public class CartItem {
    private final Product product;
    private final int quantity;
    private final String size;        // "Regular" | "Grande" | "Una porción"
    private final String temperature; // "Caliente" | "Tibio" | ""
    private final String extras;      // "Espresso extra, Leche de avena" | ""
    private final double unitPrice;

    public CartItem(Product product, int quantity, String size, String temperature,
                    String extras, double unitPrice) {
        this.product = product;
        this.quantity = quantity;
        this.size = size;
        this.temperature = temperature;
        this.extras = extras;
        this.unitPrice = unitPrice;
    }

    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    public String getSize() { return size; }
    public String getTemperature() { return temperature; }
    public String getExtras() { return extras; }
    public double getUnitPrice() { return unitPrice; }
    public double getLineTotal() { return unitPrice * quantity; }

    public CartItem withQuantity(int q) {
        return new CartItem(product, q, size, temperature, extras, unitPrice);
    }

    /** Texto corto de opciones: "Regular · Caliente · Espresso extra". */
    public String getOptionsLabel() {
        StringBuilder sb = new StringBuilder(size);
        if (temperature != null && !temperature.isEmpty()) sb.append(" · ").append(temperature);
        if (extras != null && !extras.isEmpty()) sb.append(" · ").append(extras);
        return sb.toString();
    }
}
