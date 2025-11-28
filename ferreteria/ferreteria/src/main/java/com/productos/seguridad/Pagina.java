package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import com.productos.datos.Conexion;

public class Pagina {

    private int id;
    private String nombre;
    private String path;

    // Método para mostrar el menú según el perfil del usuario
   /* public String mostrarMenu(Integer nperfil) 
    { 
    String menu=""; 
    String sql="SELECT * FROM tb_pagina pag, tb_perfil per, " 
    + "tb_perfilpagina pper " + 
    "WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per " 
    + "AND pper.id_per= "+nperfil; 
    Conexion con = new Conexion(); 
    ResultSet rs=null; 
    try 
    { 
    rs=con.Consulta(sql); 
    while(rs.next()) 
    { 
    menu+="<a href="+rs.getString(3)+"accesskey="+rs.getInt(1)+">"+rs.getString(2)+"</a>"; 
    }    
    } 
    catch(SQLException e) 
    { 
    System.out.print(e.getMessage()); 
    } 
    return menu; 
    } 
    */
    public String mostrarMenu(int perfil) {
        StringBuilder menu = new StringBuilder();
        Conexion con = new Conexion();
        ResultSet rs = null;

        try {
            String sql = "SELECT descripcion_pag, path_pag " +
                         "FROM tb_pagina p " +
                         "JOIN tb_perfilpagina pp ON p.id_pag = pp.id_pag " +
                         "WHERE pp.id_per = ? ORDER BY p.id_pag;";

            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, perfil);
            rs = ps.executeQuery();

            while (rs.next()) {
                menu.append("<li class='nav-item'>")
                    .append("<a class='nav-link' href='")
                    .append(rs.getString("path_pag"))
                    .append("'>")
                    .append(rs.getString("descripcion_pag"))
                    .append("</a></li>");
            }

        } catch (Exception e) {
            System.out.println("Error al generar menú: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (con.getConexion() != null) con.getConexion().close();
            } catch (Exception e) { }
        }

        return menu.toString();
    }
}
