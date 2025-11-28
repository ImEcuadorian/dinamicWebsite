package com.productos.negocio;

import java.sql.*;
import java.util.*;
import com.productos.datos.Conexion;

public class Compra {

    // Procesa toda la compra del usuario
    public String procesarCompra(int idUsuario) {
        Conexion con = new Conexion();
        Connection cn = con.getConexion();

        try {

            // 1️⃣ Calcular total
            String sqlTotal = """
                SELECT SUM(subtotal) AS total FROM tb_carrito
                WHERE id_us = ?
            """;

            PreparedStatement psTotal = cn.prepareStatement(sqlTotal);
            psTotal.setInt(1, idUsuario);
            ResultSet rsTotal = psTotal.executeQuery();

            double total = 0;
            if (rsTotal.next()) total = rsTotal.getDouble("total");

            if (total <= 0) return "El carrito está vacío.";

            // 2️⃣ Crear orden
            String sqlOrden = """
                INSERT INTO tb_orden (id_us, total)
                VALUES (?, ?)
                RETURNING id_orden
            """;

            PreparedStatement psOrd = cn.prepareStatement(sqlOrden);
            psOrd.setInt(1, idUsuario);
            psOrd.setDouble(2, total);
            ResultSet rsOrd = psOrd.executeQuery();

            int idOrden = 0;
            if (rsOrd.next()) idOrden = rsOrd.getInt("id_orden");

            // 3️⃣ Insertar detalle de PRODUCTOS
            String sqlProductos = """
                SELECT id_pr, cantidad, subtotal
                FROM tb_carrito
                WHERE id_us=? AND id_pr IS NOT NULL
            """;

            PreparedStatement psProd = cn.prepareStatement(sqlProductos);
            psProd.setInt(1, idUsuario);
            ResultSet rsProd = psProd.executeQuery();

            while (rsProd.next()) {
                PreparedStatement psDet = cn.prepareStatement("""
                    INSERT INTO tb_detalle_orden (id_orden, id_pr, cantidad, subtotal)
                    VALUES (?, ?, ?, ?)
                """);
                psDet.setInt(1, idOrden);
                psDet.setInt(2, rsProd.getInt("id_pr"));
                psDet.setInt(3, rsProd.getInt("cantidad"));
                psDet.setDouble(4, rsProd.getDouble("subtotal"));
                psDet.executeUpdate();
            }

            // 4️⃣ Insertar detalle de SERVICIOS + historial
            String sqlServicios = """
                SELECT id_serv, cantidad, subtotal
                FROM tb_carrito
                WHERE id_us=? AND id_serv IS NOT NULL
            """;

            PreparedStatement psServ = cn.prepareStatement(sqlServicios);
            psServ.setInt(1, idUsuario);
            ResultSet rsServ = psServ.executeQuery();

            while (rsServ.next()) {

                int idServ = rsServ.getInt("id_serv");
                int cant = rsServ.getInt("cantidad");
                double sub = rsServ.getDouble("subtotal");

                // Insertar detalle orden
                PreparedStatement psDetServ = cn.prepareStatement("""
                    INSERT INTO tb_detalle_servicio (id_orden, id_serv, cantidad, subtotal)
                    VALUES (?, ?, ?, ?)
                """);
                psDetServ.setInt(1, idOrden);
                psDetServ.setInt(2, idServ);
                psDetServ.setInt(3, cant);
                psDetServ.setDouble(4, sub);
                psDetServ.executeUpdate();

                // Historial
                PreparedStatement psHist = cn.prepareStatement("""
                    INSERT INTO tb_historial_servicio (id_us, id_serv, cantidad, subtotal)
                    VALUES (?, ?, ?, ?)
                """);
                psHist.setInt(1, idUsuario);
                psHist.setInt(2, idServ);
                psHist.setInt(3, cant);
                psHist.setDouble(4, sub);
                psHist.executeUpdate();
            }

            // 5️⃣ Vaciar carrito
            PreparedStatement psDel = cn.prepareStatement("DELETE FROM tb_carrito WHERE id_us=?");
            psDel.setInt(1, idUsuario);
            psDel.executeUpdate();

            return "OK";

        } catch (Exception e) {
            return "Error al procesar compra: " + e.getMessage();
        }
    }
}
