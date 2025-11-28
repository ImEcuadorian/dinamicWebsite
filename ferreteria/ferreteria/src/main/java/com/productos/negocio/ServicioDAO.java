package com.productos.negocio;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.productos.datos.Conexion;

public class ServicioDAO {

    // LISTAR
    public List<Servicio> listar() {
        List<Servicio> lista = new ArrayList<>();
        Conexion con = new Conexion();

        try {
            String sql = "SELECT * FROM tb_servicio ORDER BY id_serv ASC";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setId(rs.getInt("id_serv"));
                s.setNombre(rs.getString("nombre_serv"));
                s.setDescripcion(rs.getString("descripcion_serv"));
                s.setPrecio(rs.getDouble("precio_serv"));
                s.setActivo(rs.getBoolean("activo"));
                lista.add(s);
            }

        } catch (Exception e) {
            System.out.println("Error listar servicios: " + e.getMessage());
        }
        return lista;
    }

    // OBTENER POR ID
    public Servicio obtener(int id) {
        Servicio s = null;
        Conexion con = new Conexion();

        try {
            String sql = "SELECT * FROM tb_servicio WHERE id_serv=?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Servicio();
                s.setId(rs.getInt("id_serv"));
                s.setNombre(rs.getString("nombre_serv"));
                s.setDescripcion(rs.getString("descripcion_serv"));
                s.setPrecio(rs.getDouble("precio_serv"));
                s.setActivo(rs.getBoolean("activo"));
            }

        } catch (Exception e) {
            System.out.println("Error obtener servicio: " + e.getMessage());
        }
        return s;
    }

    // AGREGAR
    public boolean agregar(Servicio s) {
        Conexion con = new Conexion();
        try {
            String sql = """
                INSERT INTO tb_servicio(nombre_serv, descripcion_serv, precio_serv, activo)
                VALUES (?, ?, ?, TRUE)
            """;
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, s.getNombre());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error agregar servicio: " + e.getMessage());
            return false;
        }
    }

    // EDITAR
    public boolean actualizar(Servicio s) {
        Conexion con = new Conexion();
        try {
            String sql = """
                UPDATE tb_servicio SET nombre_serv=?, descripcion_serv=?, precio_serv=?, activo=?
                WHERE id_serv=?
            """;
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, s.getNombre());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());
            ps.setBoolean(4, s.getActivo());
            ps.setInt(5, s.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error actualizar servicio: " + e.getMessage());
            return false;
        }
    }

    // ELIMINAR
    public boolean eliminar(int id) {
        Conexion con = new Conexion();
        try {
            PreparedStatement ps = con.getConexion().prepareStatement(
                "DELETE FROM tb_servicio WHERE id_serv=?"
            );
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error eliminar servicio: " + e.getMessage());
            return false;
        }
    }

}
