package com.aurora.cafeteria.model;

/** Pedido. Estados: Nuevo, En preparación, Listo, Entregado, Cancelado. */
public class Order {
    private final String code;
    private final String customerName;
    private final String lines;      // una línea por producto, separadas por \n
    private final double total;
    private final String modality;   // "Recojo en tienda" | "Disfrutar en local" | "Delivery"
    private final String payment;    // "Yape" | "Plin" | "Tarjeta" | "Efectivo al recoger"
    private final boolean paymentConfirmed;
    private final String status;
    private final String time;       // "09:41"

    public Order(String code, String customerName, String lines, double total,
                 String modality, String payment, boolean paymentConfirmed,
                 String status, String time) {
        this.code = code;
        this.customerName = customerName;
        this.lines = lines;
        this.total = total;
        this.modality = modality;
        this.payment = payment;
        this.paymentConfirmed = paymentConfirmed;
        this.status = status;
        this.time = time;
    }

    public String getCode() { return code; }
    public String getCustomerName() { return customerName; }
    public String getLines() { return lines; }
    public double getTotal() { return total; }
    public String getModality() { return modality; }
    public String getPayment() { return payment; }
    public boolean isPaymentConfirmed() { return paymentConfirmed; }
    public String getStatus() { return status; }
    public String getTime() { return time; }

    public Order withStatus(String newStatus) {
        return new Order(code, customerName, lines, total, modality, payment,
                paymentConfirmed, newStatus, time);
    }

    public Order withPaymentConfirmed(boolean confirmed) {
        return new Order(code, customerName, lines, total, modality, payment,
                confirmed, status, time);
    }
}
