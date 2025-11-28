package com.productos.negocio;

import java.sql.*;

import com.productos.datos.Conexion;

import java.util.ArrayList;
import java.util.List;

public class Orden {

    public int procesarPago(int idUsuario) {
        Conexion con = new Conexion();
        Connection cn = con.getConexion();


        int idOrden = -1;

        try {

            // 1️ Calcular total
            double total = 0;
            String sqlTotal = "SELECT subtotal FROM tb_carrito WHERE id_us=?";
            PreparedStatement psTotal = cn.prepareStatement(sqlTotal);
            psTotal.setInt(1, idUsuario);
            ResultSet rsT = psTotal.executeQuery();
            while (rsT.next()) total += rsT.getDouble("subtotal");
            rsT.close();
            psTotal.close();

            if (total <= 0) {
                return -1; // carrito vacío
            }

            // 2️ Crear la orden
            String sqlOrden =
                    "INSERT INTO tb_orden (id_us, total) VALUES (?, ?) RETURNING id_orden";

            PreparedStatement psOrden = cn.prepareStatement(sqlOrden);
            psOrden.setInt(1, idUsuario);
            psOrden.setDouble(2, total);

            ResultSet rsO = psOrden.executeQuery();
            if (rsO.next()) {
                idOrden = rsO.getInt(1);
            }
            rsO.close();
            psOrden.close();


            // 3️ Agregar PRODUCTOS al detalle
            String sqlProd =
                    "SELECT id_pr, cantidad, subtotal FROM tb_carrito WHERE id_us=? AND id_pr IS NOT NULL";

            PreparedStatement psProd = cn.prepareStatement(sqlProd);
            psProd.setInt(1, idUsuario);
            ResultSet rsP = psProd.executeQuery();

            while (rsP.next()) {
                PreparedStatement psIns = cn.prepareStatement(
                        "INSERT INTO tb_detalle_orden (id_orden, id_pr, cantidad, subtotal) VALUES (?, ?, ?, ?)"
                );
                psIns.setInt(1, idOrden);
                psIns.setInt(2, rsP.getInt("id_pr"));
                psIns.setInt(3, rsP.getInt("cantidad"));
                psIns.setDouble(4, rsP.getDouble("subtotal"));
                psIns.executeUpdate();
                psIns.close();
            }

            rsP.close();
            psProd.close();


            // 4️ Agregar SERVICIOS al detalle y al historial
            String sqlServ =
                    "SELECT id_serv, cantidad, subtotal FROM tb_carrito WHERE id_us=? AND id_serv IS NOT NULL";

            PreparedStatement psServ = cn.prepareStatement(sqlServ);
            psServ.setInt(1, idUsuario);
            ResultSet rsS = psServ.executeQuery();

            while (rsS.next()) {

                int idServ = rsS.getInt("id_serv");
                int cantidad = rsS.getInt("cantidad");
                double subtotal = rsS.getDouble("subtotal");

                // Insertar detalle servicio
                PreparedStatement psInsS = cn.prepareStatement(
                        "INSERT INTO tb_detalle_servicio (id_orden, id_serv, cantidad, subtotal) VALUES (?, ?, ?, ?)"
                );
                psInsS.setInt(1, idOrden);
                psInsS.setInt(2, idServ);
                psInsS.setInt(3, cantidad);
                psInsS.setDouble(4, subtotal);
                psInsS.executeUpdate();
                psInsS.close();

                // Insertar historial
                PreparedStatement psHist = cn.prepareStatement(
                        "INSERT INTO tb_historial_servicio (id_us, id_serv, cantidad, subtotal) VALUES (?, ?, ?, ?)"
                );
                psHist.setInt(1, idUsuario);
                psHist.setInt(2, idServ);
                psHist.setInt(3, cantidad);
                psHist.setDouble(4, subtotal);
                psHist.executeUpdate();
                psHist.close();
            }

            rsS.close();
            psServ.close();

            // Descontar stock de los productos comprados
            Checkout chk = new Checkout();
            chk.descontarStock(idUsuario);

            // 5️⃣ Vaciar carrito
            PreparedStatement psVaciar = cn.prepareStatement("DELETE FROM tb_carrito WHERE id_us=?");
            psVaciar.setInt(1, idUsuario);
            psVaciar.executeUpdate();
            psVaciar.close();


        } catch (Exception e) {
            System.out.println("Error procesarPago: " + e.getMessage());
        } finally {
            try {
                cn.close();
            } catch (Exception ex) {
            }
        }

        return idOrden;
    }
}
