package com.productos.negocio;

import com.productos.datos.Conexion;

import java.sql.*;
import java.util.*;

public class HistorialServicioDAO {

    public void registrarServicio(int idUsuario, int idServicio, int cantidad, double subtotal) {
        Conexion con = new Conexion();
        try {
            String sql = """
                        INSERT INTO tb_historial_servicio (id_us, id_serv, cantidad, subtotal)
                        VALUES (?, ?, ?, ?)
                    """;

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ps.setInt(2, idServicio);
            ps.setInt(3, cantidad);
            ps.setDouble(4, subtotal);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error registrando servicio: " + e.getMessage());
        }
    }

    public List<HistorialServicio> obtenerHistorial(int idUsuario) {
        List<HistorialServicio> lista = new ArrayList<>();
        Conexion con = new Conexion();

        try {
            String sql = """
                        SELECT hs.id_hist, s.nombre_serv, hs.cantidad, hs.subtotal,
                               hs.fecha, hs.estado
                        FROM tb_historial_servicio hs
                        JOIN tb_servicio s ON s.id_serv = hs.id_serv
                        WHERE hs.id_us = ?
                        ORDER BY hs.fecha DESC
                    """;

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(
                        new HistorialServicio(
                                rs.getInt("id_hist"),
                                rs.getString("nombre_serv"),
                                rs.getInt("cantidad"),
                                rs.getDouble("subtotal"),
                                rs.getString("fecha"),
                                rs.getString("estado")
                        )
                );
            }

        } catch (Exception e) {
            System.out.println("Error obteniendo historial: " + e.getMessage());
        }

        return lista;
    }
}
