package com.productos.negocio;

public class HistorialServicio {

    private int idHist;
    private String nombreServicio;
    private int cantidad;
    private double subtotal;
    private String fecha;
    private String estado;

    public HistorialServicio(int idHist, String nombreServicio, int cantidad, double subtotal, String fecha, String estado) {
        this.idHist = idHist;
        this.nombreServicio = nombreServicio;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
        this.fecha = fecha;
        this.estado = estado;
    }

    public int getIdHist() {
        return idHist;
    }

    public String getNombreServicio() {
        return nombreServicio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public String getFecha() {
        return fecha;
    }

    public String getEstado() {
        return estado;
    }

}
