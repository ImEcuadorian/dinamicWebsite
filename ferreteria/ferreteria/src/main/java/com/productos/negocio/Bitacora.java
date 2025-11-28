package com.productos.negocio;

public class Bitacora {

    private int id;
    private String tabla;
    private String operacion;
    private String valorAnterior;
    private String valorNuevo;
    private String fecha;
    private String usuario;
    private String esquema;

    public Bitacora(int id, String tabla, String operacion,
                    String valorAnterior, String valorNuevo,
                    String fecha, String usuario, String esquema) {
        this.id = id;
        this.tabla = tabla;
        this.operacion = operacion;
        this.valorAnterior = valorAnterior;
        this.valorNuevo = valorNuevo;
        this.fecha = fecha;
        this.usuario = usuario;
        this.esquema = esquema;
    }

    public int getId() { return id; }
    public String getTabla() { return tabla; }
    public String getOperacion() { return operacion; }
    public String getValorAnterior() { return valorAnterior; }
    public String getValorNuevo() { return valorNuevo; }
    public String getFecha() { return fecha; }
    public String getUsuario() { return usuario; }
    public String getEsquema() { return esquema; }
}
