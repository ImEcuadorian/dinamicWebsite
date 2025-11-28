package com.productos.seguridad;

import java.sql.*;

import com.productos.datos.Conexion;

public class Usuario {

    int id;
    int perfil;
    String cedula;
    String nombre;
    String correo;
    String clave;
    int estadoCivil;


    // Constructor vacío
    public Usuario() {
    }

    // Getters y Setters
    public int getEstado() {
        return estadoCivil;
    }

    public void setEstado(int estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPerfil() {
        return perfil;
    }

    public void setPerfil(int perfil) {
        this.perfil = perfil;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean verificarUsuario(String ncorreo, String nclave) {
        boolean respuesta = false;
        String sentencia = "SELECT * FROM tb_usuario WHERE correo_us='" + ncorreo + "' AND clave_us='" + nclave + "';";

        try {
            Conexion clsCon = new Conexion();
            ResultSet rs = clsCon.Consulta(sentencia);

            if (rs.next()) {
                respuesta = true;

                // 🚀 ESTA ERA LA LÍNEA FALTANTE
                this.id = rs.getInt("id_us");

                this.correo = rs.getString("correo_us");
                this.clave = rs.getString("clave_us");
                this.perfil = rs.getInt("id_per");
                this.nombre = rs.getString("nombre_us");

                System.out.println("Usuario encontrado => ID: " + this.id +
                                   ", Nombre: " + this.nombre +
                                   ", Perfil: " + this.perfil);
            }

            rs.close();
        } catch (Exception ex) {
            System.out.println("Error en verificarUsuario: " + ex.getMessage());
        }

        return respuesta;
    }

    //consultar tabla bootstrap
//    public String consultarUsuarios() {
//    	Conexion con = new Conexion();
//    	ResultSet rs= null;
//    	String tabla ="<table class-table-success> <tr><th scope = row>Nombre<\th><th>Correo<\th><tr>";
//    	try {
//    	String sql="SELECT nombre_us,correo_us FROM tb_usuario";
//    	rs = con.Consulta(sql);
//    	while(rs.next()) {
//    		tabla+="<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td><a href=../modificar.jsp?id="+rs.getString(1)+"><a src=../iconos/github50px.png></a>"+rs.getString(3)+"<tr>";
//    	}
//    	tabla+="</table>";
//    	}catch(Exception ex){
//    		System.out.print(ex);
//    	}
//		return tabla;
//    }


    public String consultarUsuarios() {
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder tabla = new StringBuilder();

        tabla.append("<div class='table-responsive'>");
        tabla.append("<table class='table table-success table-striped'>");
        tabla.append("<thead class='table-dark text-center'>");
        tabla.append("<tr><th>ID</th><th>Nombre</th><th>Correo</th><th>Perfil</th><th>Acciones</th></tr>");
        tabla.append("</thead><tbody>");

        try {
            String sql = """
                        SELECT u.id_us, u.nombre_us, u.correo_us, p.descripcion_per
                        FROM tb_usuario u
                        JOIN tb_perfil p ON u.id_per = p.id_per
                        ORDER BY u.id_us;
                    """;
            rs = con.Consulta(sql);

            while (rs.next()) {
                tabla.append("<tr>")
                        .append("<td class='text-center'>").append(rs.getInt("id_us")).append("</td>")
                        .append("<td>").append(rs.getString("nombre_us")).append("</td>")
                        .append("<td>").append(rs.getString("correo_us")).append("</td>")
                        .append("<td>").append(rs.getString("descripcion_per")).append("</td>")
                        .append("<td class='text-center'>")
                        .append("<a href='editarUsuario.jsp?id=").append(rs.getInt("id_us"))
                        .append("' class='btn btn-sm btn-warning me-2'><i class='fa-solid fa-pen-to-square'></i> Editar</a>")
                        .append("<button class='btn btn-sm btn-danger' onclick=\"confirmarEliminacion(")//parte confirmacion con javascript
                        .append(rs.getInt("id_us"))
                        .append(")\"><i class='fa-solid fa-trash'></i> Eliminar</button>")
                        .append("</td></tr>");
            }

        } catch (Exception ex) {
            tabla.append("<tr><td colspan='5' class='text-danger text-center'>Error: ")
                    .append(ex.getMessage()).append("</td></tr>");
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }

        tabla.append("</tbody></table></div>");
        return tabla.toString();
    }


    //metodo insercionDatos
    public String ingresarCliente() {
        String result = "";
        Conexion con = new Conexion();
        PreparedStatement pr = null;
        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us,"
                     + "cedula_us,correo_us,clave_us) "
                     + "VALUES(?,?,?,?,?,?)";
        try {
            pr = con.getConexion().prepareStatement(sql);
            pr.setInt(1, 2);
            pr.setInt(2, this.getEstado());
            pr.setString(3, this.getNombre());
            pr.setString(4, this.getCedula());
            pr.setString(5, this.getCorreo());
            pr.setString(6, this.getClave());
            if (pr.executeUpdate() == 1) {
                result = "Insercion correcta";
            } else {
                result = "Error en insercion";
            }
        } catch (Exception ex) {
            result = ex.getMessage();
            System.out.print(result);
        } finally {
            try {
                pr.close();
                con.getConexion().close();
            } catch (Exception ex) {
                System.out.print(ex.getMessage());
            }
        }
        return result;
    }
    //eliminar usuario 11/11/2025 fecha realizada
//    public String eliminarUsuario(String id) {
//    	String sql="DELETE FROM tb_usuario WHERE id_pr="+id;
//    	Conexion con = new Conexion();
//    	String msg= con.Ejecutar(sql);
//    	return msg;
//    }


    public String eliminarUsuario(String id) {
        String msg = "";
        String sql = "DELETE FROM tb_usuario WHERE id_us = ?";
        Conexion con = new Conexion();
        try {
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            int filas = ps.executeUpdate();
            msg = (filas > 0) ? "Usuario eliminado correctamente" : "No se encontró el usuario";
            ps.close();
        } catch (Exception ex) {
            msg = "Error al eliminar usuario: " + ex.getMessage();
        } finally {
            try {
                con.getConexion().close();
            } catch (Exception e) {
            }
        }
        return msg;
    }


    public Usuario buscarUsuarioPorId(String id) {
        Usuario user = null;
        Conexion con = new Conexion();
        ResultSet rs = null;

        try {
            String sql = "SELECT id_us, id_per, id_est, nombre_us, cedula_us, correo_us, clave_us " +
                         "FROM tb_usuario WHERE id_us = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new Usuario();
                user.id = rs.getInt("id_us");
                user.perfil = rs.getInt("id_per");
                user.estadoCivil = rs.getInt("id_est");
                user.nombre = rs.getString("nombre_us");
                user.cedula = rs.getString("cedula_us");
                user.correo = rs.getString("correo_us");
                user.clave = rs.getString("clave_us");
            }

        } catch (Exception e) {
            System.out.println("Error al buscar usuario: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }
        return user;
    }


    public String actualizarUsuario(Usuario user) {
        String result = "";
        Conexion con = new Conexion();
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE tb_usuario SET id_per=?, id_est=?, nombre_us=?, cedula_us=?, correo_us=?, clave_us=? WHERE id_us=?";
            ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, user.getPerfil());
            ps.setInt(2, user.getEstado());
            ps.setString(3, user.getNombre());
            ps.setString(4, user.getCedula());
            ps.setString(5, user.getCorreo());
            ps.setString(6, user.getClave());
            ps.setInt(7, user.id);

            int filas = ps.executeUpdate();
            result = (filas > 0) ? "Usuario actualizado correctamente." : "No se encontró el usuario.";

        } catch (Exception e) {
            result = "Error al actualizar usuario: " + e.getMessage();
        } finally {
            try {
                if (ps != null) ps.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }
        return result;
    }


    public String ingresarEmpleado() {
        String result = "";
        Conexion con = new Conexion();
        PreparedStatement pr = null;

        String sql = "INSERT INTO tb_usuario (id_per, id_est, nombre_us, cedula_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            pr = con.getConexion().prepareStatement(sql);
            pr.setInt(1, this.getPerfil());   // Perfil: 1 = Admin, 3 = Vendedor
            pr.setInt(2, 1);                 // Estado por defecto (por ejemplo: Casado)
            pr.setString(3, this.getNombre());
            pr.setString(4, this.getCedula());
            pr.setString(5, this.getCorreo());
            pr.setString(6, this.getClave());

            int filas = pr.executeUpdate();
            result = (filas > 0) ? "Registro exitoso del empleado o administrador." : "No se pudo registrar.";

        } catch (Exception ex) {
            result = "Error en ingresarEmpleado: " + ex.getMessage();
            System.out.println(result);
        } finally {
            try {
                if (pr != null) pr.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }

        return result;
    }


}
