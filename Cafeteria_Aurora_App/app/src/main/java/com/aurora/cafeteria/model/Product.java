package com.aurora.cafeteria.model;

/** Producto de la carta. Inmutable: para "editar" se crea una copia. */
public class Product {
    private final int id;
    private final String name;
    private final String description;
    private final double price;
    private final String category; // "Cafés", "Frappés", "Postres"
    private final int stock;
    private final int minStock;

    public Product(int id, String name, String description, double price,
                   String category, int stock, int minStock) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.stock = stock;
        this.minStock = minStock;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public String getCategory() { return category; }
    public int getStock() { return stock; }
    public int getMinStock() { return minStock; }

    public Product withStock(int newStock) {
        return new Product(id, name, description, price, category, Math.max(newStock, 0), minStock);
    }

    public Product edited(String newName, String newDescription, double newPrice,
                          String newCategory, int newStock) {
        return new Product(id, newName, newDescription, newPrice, newCategory, newStock, minStock);
    }
}
