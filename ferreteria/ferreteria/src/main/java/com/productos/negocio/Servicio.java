package com.productos.negocio;

import java.sql.*;
import com.productos.datos.Conexion;

public class Servicio {

    private int id;
    private String nombre;
    private String descripcion;
    private double precio;
    private boolean activo;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String n) { this.nombre = n; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String d) { this.descripcion = d; }

    public double getPrecio() { return precio; }
    public void setPrecio(double p) { this.precio = p; }

    public boolean getActivo() { return activo; }
    public void setActivo(boolean a) { this.activo = a; }

    // ================= LISTAR SERVICIOS PARA CLIENTE ==================
    public String listarServiciosCliente() {
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder html = new StringBuilder();

        try {
            rs = con.Consulta("SELECT * FROM tb_servicio WHERE activo = TRUE");

            while (rs.next()) {
                html.append("<div class='col-md-4 mb-4'>")
                    .append("<div class='card shadow h-100'>")
                    .append("<div class='card-body'>")
                    .append("<h5 class='text-primary fw-bold'>").append(rs.getString("nombre_serv")).append("</h5>")
                    .append("<p>").append(rs.getString("descripcion_serv")).append("</p>")
                    .append("<h6 class='text-success fw-bold'>$").append(rs.getDouble("precio_serv")).append("</h6>")
                    .append("<form action='agregarServicio.jsp' method='post'>")
                    .append("<input type='hidden' name='id_serv' value='").append(rs.getInt("id_serv")).append("'>")
                    .append("<button class='btn btn-outline-primary w-100'>")
                    .append("<i class='fa-solid fa-cart-plus'></i> Agregar Servicio")
                    .append("</button>")
                    .append("</form>")
                    .append("</div></div></div>");
            }

        } catch (Exception e) {
            html.append("<div class='alert alert-danger'>Error: ").append(e.getMessage()).append("</div>");
        }
        return html.toString();
    }
}
