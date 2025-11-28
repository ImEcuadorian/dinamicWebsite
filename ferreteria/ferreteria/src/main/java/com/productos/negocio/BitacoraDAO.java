package com.productos.negocio;

import com.productos.datos.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BitacoraDAO {

    public List<Bitacora> filtrar(String tabla, String operacion, String desde, String hasta) {

        List<Bitacora> lista = new ArrayList<>();
        Conexion con = new Conexion();

        StringBuilder sql = new StringBuilder("""
            SELECT id_aud, tabla_aud, operacion_aud,
                   valor_anterior, valor_nuevo,
                   fecha, usuario_db, esquema_db
            FROM auditoria.tb_auditoria
            WHERE 1=1
        """);

        // Filtros dinámicos
        if (tabla != null && !tabla.equals("todos"))
            sql.append(" AND tabla_aud = ? ");

        if (operacion != null && !operacion.equals("todos"))
            sql.append(" AND operacion_aud = ? ");

        if (desde != null && !desde.isEmpty())
            sql.append(" AND fecha >= ? ");

        if (hasta != null && !hasta.isEmpty())
            sql.append(" AND fecha <= ? ");

        sql.append(" ORDER BY fecha DESC ");

        try {
            PreparedStatement ps = con.getConexion().prepareStatement(sql.toString());

            int idx = 1;

            if (tabla != null && !tabla.equals("todos"))
                ps.setString(idx++, tabla);

            if (operacion != null && !operacion.equals("todos"))
                ps.setString(idx++, operacion);

            if (desde != null && !desde.isEmpty())
                ps.setTimestamp(idx++, Timestamp.valueOf(desde + " 00:00:00"));

            if (hasta != null && !hasta.isEmpty())
                ps.setTimestamp(idx++, Timestamp.valueOf(hasta + " 23:59:59"));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(
                    new Bitacora(
                        rs.getInt("id_aud"),
                        rs.getString("tabla_aud"),
                        rs.getString("operacion_aud"),
                        rs.getString("valor_anterior"),
                        rs.getString("valor_nuevo"),
                        rs.getTimestamp("fecha").toString(),
                        rs.getString("usuario_db"),
                        rs.getString("esquema_db")
                    )
                );
            }

        } catch (Exception e) {
            System.out.println("Error obteniendo bitácora: " + e.getMessage());
        }

        return lista;
    }
}
