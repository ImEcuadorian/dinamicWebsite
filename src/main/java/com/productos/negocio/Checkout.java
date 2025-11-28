package com.productos.negocio;

import com.productos.datos.Conexion;
import com.productos.negocio.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Checkout {

    // Obtener los productos del carrito
    public List<CheckoutItem> obtenerItems(int idUsuario) {

        List<CheckoutItem> lista = new ArrayList<>();
        Conexion con = new Conexion();
        ResultSet rs = null;

        try {

            String sql =
                    "SELECT c.cantidad, c.subtotal, " +
                    "       p.nombre_pr, s.nombre_serv, c.id_serv " +
                    "FROM tb_carrito c " +
                    "LEFT JOIN tb_producto p ON p.id_pr = c.id_pr " +
                    "LEFT JOIN tb_servicio s ON s.id_serv = c.id_serv " +
                    "WHERE c.id_us = ?";

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            while (rs.next()) {

                String nombreProd = rs.getString("nombre_pr");
                String nombreServ = rs.getString("nombre_serv");

                String nombreFinal = (nombreServ != null) ? nombreServ : nombreProd;

                int cantidad = rs.getInt("cantidad");
                double subtotal = rs.getDouble("subtotal");
                boolean esServicio = (nombreServ != null);

                lista.add(
                        new CheckoutItem(
                                nombreFinal,
                                cantidad,
                                subtotal,
                                esServicio
                        )
                );
            }

        } catch (Exception e) {
            System.out.println("Error en obtenerItems: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception ex) {
            }
        }

        return lista;
    }


    // Calcular total del carrito
    public double calcularTotal(List<CheckoutItem> items) {
        double total = 0;
        for (CheckoutItem item : items) {
            total += item.getSubtotal();
        }
        return total;
    }

    public void descontarStock(int idUsuario) {
        Conexion con = new Conexion();
        ResultSet rs = null;

        try {
            // Obtener productos comprados
            String sql = """
                        SELECT c.id_pr, c.cantidad
                        FROM tb_carrito c
                        WHERE c.id_us = ?
                        AND c.id_pr IS NOT NULL
                    """;

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            while (rs.next()) {
                int idProducto = rs.getInt("id_pr");
                int cantidadComprada = rs.getInt("cantidad");

                String update = """
                            UPDATE tb_producto
                            SET cantidad_pr = cantidad_pr - ?
                            WHERE id_pr = ?
                        """;

                PreparedStatement psUp = con.getConexion().prepareStatement(update);
                psUp.setInt(1, cantidadComprada);
                psUp.setInt(2, idProducto);
                psUp.executeUpdate();
            }

        } catch (Exception e) {
            System.out.println("Error descontando stock: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }
    }


}
