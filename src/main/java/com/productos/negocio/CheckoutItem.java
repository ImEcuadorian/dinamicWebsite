package com.productos.negocio;

public class CheckoutItem {

    private String nombre;
    private int cantidad;
    private double subtotal;
    private boolean esServicio;

    public CheckoutItem(String nombre, int cantidad, double subtotal) {
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
        this.esServicio = false; // por defecto es producto
    }

    // Constructor para servicio
    public CheckoutItem(String nombre, int cantidad, double subtotal, boolean esServicio) {
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
        this.esServicio = esServicio;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCantidad() {
        return cantidad;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public boolean isServicio() {
        return esServicio;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public void setEsServicio(boolean esServicio) {
        this.esServicio = esServicio;
    }
}
