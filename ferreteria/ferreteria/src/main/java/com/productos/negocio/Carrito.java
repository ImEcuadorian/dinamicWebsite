package com.productos.negocio;

import java.sql.*;
import com.productos.datos.Conexion;

public class Carrito {

	public String listarCarrito(int idUsuario) {
	    Conexion con = new Conexion();
	    ResultSet rs = null;
	    StringBuilder tabla = new StringBuilder();
	    double total = 0;

	    tabla.append("<div class='table-responsive'>");
	    tabla.append("<table class='table table-striped table-hover align-middle'>");
	    tabla.append("<thead class='table-dark text-center'>")
	         .append("<tr>")
	         .append("<th>Item</th>")
	         .append("<th>Precio</th>")
	         .append("<th>Cantidad</th>")
	         .append("<th>Subtotal</th>")
	         .append("<th>Acciones</th>")
	         .append("</tr>")
	         .append("</thead><tbody>");

	    try {

	        String sql = """
	            (
	                SELECT 
	                    c.id_car,
	                    p.nombre_pr AS nombre,
	                    p.precio_pr AS precio,
	                    p.en_oferta,
	                    p.descuento,
	                    c.cantidad,
	                    (CASE 
	                        WHEN p.en_oferta THEN (p.precio_pr - (p.precio_pr * p.descuento / 100))
	                        ELSE p.precio_pr
	                    END) * c.cantidad AS subtotal,
	                    'producto' AS tipo
	                FROM tb_carrito c
	                JOIN tb_producto p ON p.id_pr = c.id_pr
	                WHERE c.id_us = ?
	            )
	            UNION ALL
	            (
	                SELECT 
	                    c.id_car,
	                    s.nombre_serv AS nombre,
	                    s.precio_serv AS precio,
	                    FALSE AS en_oferta,
	                    0 AS descuento,
	                    c.cantidad,
	                    (s.precio_serv * c.cantidad) AS subtotal,
	                    'servicio' AS tipo
	                FROM tb_carrito c
	                JOIN tb_servicio s ON s.id_serv = c.id_serv
	                WHERE c.id_us = ?
	            )
	        """;

	        PreparedStatement ps = con.getConexion().prepareStatement(sql);
	        ps.setInt(1, idUsuario);
	        ps.setInt(2, idUsuario);
	        rs = ps.executeQuery();

	        while (rs.next()) {

	            String nombre = rs.getString("nombre");
	            int cantidad = rs.getInt("cantidad");
	            double precio = rs.getDouble("precio");
	            boolean oferta = rs.getBoolean("en_oferta");
	            double desc = rs.getDouble("descuento");
	            double subtotal = rs.getDouble("subtotal");

	            total += subtotal;

	            tabla.append("<tr>")
	                 .append("<td>").append(nombre).append("</td>");

	            if (oferta) {
	                double precioFinal = precio - (precio * desc / 100);
	                tabla.append("<td>")
	                     .append("<span class='text-decoration-line-through text-danger'>$")
	                     .append(precio).append("</span> ")
	                     .append("<span class='fw-bold text-success'>$")
	                     .append(String.format("%.2f", precioFinal)).append("</span>")
	                     .append("</td>");
	            } else {
	                tabla.append("<td>$").append(String.format("%.2f", precio)).append("</td>");
	            }

	            tabla.append("<td class='text-center'>")
	                 .append("<a href='actualizarCantidad.jsp?accion=restar&id_car=")
	                 .append(rs.getInt("id_car"))
	                 .append("' class='btn btn-sm btn-outline-danger'>-</a> ")

	                 .append("<span class='mx-2 fw-bold'>")
	                 .append(cantidad)
	                 .append("</span>")

	                 .append("<a href='actualizarCantidad.jsp?accion=sumar&id_car=")
	                 .append(rs.getInt("id_car"))
	                 .append("' class='btn btn-sm btn-outline-success'>+</a>")
	                 .append("</td>")

	                 .append("<td class='fw-bold'>$").append(String.format("%.2f", subtotal)).append("</td>")

	                 .append("<td class='text-center'>")
	                 .append("<a href='eliminarCarrito.jsp?id=").append(rs.getInt("id_car"))
	                 .append("' class='btn btn-danger btn-sm' ")
	                 .append("onclick=\"return confirm('¿Desea eliminar este ítem?');\">")
	                 .append("<i class='fa-solid fa-trash'></i></a>")
	                 .append("</td>")
	                 .append("</tr>");
	        }

	        tabla.append("<tr class='table-success fw-bold'>")
	             .append("<td colspan='3' class='text-end'>TOTAL:</td>")
	             .append("<td>$").append(String.format("%.2f", total)).append("</td>")
	             .append("<td></td>")
	             .append("</tr>");

	    } catch (Exception e) {
	        tabla.append("<tr><td colspan='5' class='text-danger'>Error: ")
	             .append(e.getMessage()).append("</td></tr>");
	    }

	    tabla.append("</tbody></table></div>");
	    return tabla.toString();
	}



	public String agregarProducto(int idUsuario, int idProducto) {
	    Conexion con = new Conexion();
	    String msg = "";
	    ResultSet rs = null;

	    try {
	        // 1) Obtener precio real (con descuento si aplica)
	        String sqlProd = """
	            SELECT precio_pr, en_oferta, descuento
	            FROM tb_producto
	            WHERE id_pr = ?
	        """;

	        PreparedStatement psProd = con.getConexion().prepareStatement(sqlProd);
	        psProd.setInt(1, idProducto);
	        rs = psProd.executeQuery();

	        double precioFinal = 0;

	        if (rs.next()) {
	            double precio = rs.getDouble("precio_pr");
	            boolean oferta = rs.getBoolean("en_oferta");
	            double desc = rs.getDouble("descuento");

	            precioFinal = oferta ? (precio - (precio * desc / 100)) : precio;
	        }
	        rs.close();
	        psProd.close();

	        // 2) Verificar si el producto ya está en el carrito
	        String sqlExiste = """
	            SELECT cantidad 
	            FROM tb_carrito 
	            WHERE id_us = ? AND id_pr = ?
	        """;

	        PreparedStatement psExiste = con.getConexion().prepareStatement(sqlExiste);
	        psExiste.setInt(1, idUsuario);
	        psExiste.setInt(2, idProducto);
	        rs = psExiste.executeQuery();

	        if (rs.next()) {
	            int nuevaCantidad = rs.getInt("cantidad") + 1;
	            double nuevoSubtotal = precioFinal * nuevaCantidad;

	            String update = """
	                UPDATE tb_carrito
	                SET cantidad = ?, subtotal = ?
	                WHERE id_us = ? AND id_pr = ?
	            """;

	            PreparedStatement psUp = con.getConexion().prepareStatement(update);
	            psUp.setInt(1, nuevaCantidad);
	            psUp.setDouble(2, nuevoSubtotal);
	            psUp.setInt(3, idUsuario);
	            psUp.setInt(4, idProducto);
	            psUp.executeUpdate();
	            psUp.close();

	            msg = "Cantidad actualizada en el carrito.";
	        } else {
	            // 3) Insertar nuevo producto con subtotal correcto
	            String insert = """
	                INSERT INTO tb_carrito (id_us, id_pr, cantidad, subtotal)
	                VALUES (?, ?, 1, ?)
	            """;

	            PreparedStatement psIn = con.getConexion().prepareStatement(insert);
	            psIn.setInt(1, idUsuario);
	            psIn.setInt(2, idProducto);
	            psIn.setDouble(3, precioFinal);
	            psIn.executeUpdate();
	            psIn.close();

	            msg = "Producto agregado al carrito.";
	        }

	        psExiste.close();
	        rs.close();

	    } catch (Exception e) {
	        msg = "Error al agregar al carrito: " + e.getMessage();
	    } finally {
	        try { con.getConexion().close(); } catch (Exception e) {}
	    }

	    return msg;
	}



    public String eliminarProducto(String id) {
        Conexion con = new Conexion();
        String sql = "DELETE FROM tb_carrito WHERE id_car = ?";
        String msg = "";
        try (PreparedStatement ps = con.getConexion().prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(id));
            int filas = ps.executeUpdate();
            msg = (filas > 0) ? "Producto eliminado del carrito." : "No se encontró el producto.";
        } catch (Exception e) {
            msg = "Error al eliminar: " + e.getMessage();
        }
        return msg;
    }
    
    public String aumentarCantidad(int idCarrito) {
        Conexion con = new Conexion();
        String msg = "";

        try {
            // Obtener cantidad y precio final
            String sqlGet = """
                SELECT c.cantidad, p.precio_pr, p.en_oferta, p.descuento
                FROM tb_carrito c
                JOIN tb_producto p ON p.id_pr = c.id_pr
                WHERE c.id_car = ?
            """;

            PreparedStatement ps1 = con.getConexion().prepareStatement(sqlGet);
            ps1.setInt(1, idCarrito);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                int cantidad = rs.getInt("cantidad") + 1;

                double precio = rs.getDouble("precio_pr");
                boolean oferta = rs.getBoolean("en_oferta");
                double desc = rs.getDouble("descuento");

                double precioFinal = oferta ? (precio - (precio * desc / 100)) : precio;
                double nuevoSubtotal = precioFinal * cantidad;

                String sqlUpdate = "UPDATE tb_carrito SET cantidad=?, subtotal=? WHERE id_car=?";
                PreparedStatement ps2 = con.getConexion().prepareStatement(sqlUpdate);
                ps2.setInt(1, cantidad);
                ps2.setDouble(2, nuevoSubtotal);
                ps2.setInt(3, idCarrito);
                ps2.executeUpdate();
            }

            msg = "Cantidad aumentada correctamente";

        } catch (Exception e) {
            msg = "Error al aumentar la cantidad: " + e.getMessage();
        }

        return msg;
    }


    public String disminuirCantidad(int idCarrito) {
        Conexion con = new Conexion();
        String msg = "";

        try {
            String sqlGet = """
                SELECT c.cantidad, p.precio_pr, p.en_oferta, p.descuento
                FROM tb_carrito c
                JOIN tb_producto p ON p.id_pr = c.id_pr
                WHERE c.id_car = ?
            """;

            PreparedStatement ps1 = con.getConexion().prepareStatement(sqlGet);
            ps1.setInt(1, idCarrito);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                int cantidad = rs.getInt("cantidad");

                if (cantidad <= 1) {
                    return eliminarProducto(String.valueOf(idCarrito));
                }

                cantidad--;

                double precio = rs.getDouble("precio_pr");
                boolean oferta = rs.getBoolean("en_oferta");
                double desc = rs.getDouble("descuento");

                double precioFinal = oferta ? (precio - (precio * desc / 100)) : precio;
                double nuevoSubtotal = precioFinal * cantidad;

                String sqlUpdate = "UPDATE tb_carrito SET cantidad=?, subtotal=? WHERE id_car=?";
                PreparedStatement ps2 = con.getConexion().prepareStatement(sqlUpdate);
                ps2.setInt(1, cantidad);
                ps2.setDouble(2, nuevoSubtotal);
                ps2.setInt(3, idCarrito);
                ps2.executeUpdate();
            }

            msg = "Cantidad disminuida correctamente";

        } catch (Exception e) {
            msg = "Error al disminuir cantidad: " + e.getMessage();
        }
        return msg;
    }

    public String agregarServicio(int idUsuario, int idServicio) {
        Conexion con = new Conexion();
        String msg = "";

        try {
            // 1. Obtener precio del servicio
            String sqlPrecio = "SELECT precio_serv FROM tb_servicio WHERE id_serv=?";
            PreparedStatement psPrecio = con.getConexion().prepareStatement(sqlPrecio);
            psPrecio.setInt(1, idServicio);
            ResultSet rs = psPrecio.executeQuery();

            double precio = 0;
            if (rs.next()) {
                precio = rs.getDouble("precio_serv");
            }
            rs.close();
            psPrecio.close();

            // 2. Ver si ya existe en carrito
            String sqlExiste = """
                SELECT cantidad FROM tb_carrito
                WHERE id_us=? AND id_serv=?
            """;
            PreparedStatement ps1 = con.getConexion().prepareStatement(sqlExiste);
            ps1.setInt(1, idUsuario);
            ps1.setInt(2, idServicio);
            rs = ps1.executeQuery();

            if (rs.next()) {
                int cantidad = rs.getInt("cantidad") + 1;
                double subtotal = precio * cantidad;

                PreparedStatement psUp = con.getConexion().prepareStatement(
                    "UPDATE tb_carrito SET cantidad=?, subtotal=? WHERE id_us=? AND id_serv=?"
                );
                psUp.setInt(1, cantidad);
                psUp.setDouble(2, subtotal);
                psUp.setInt(3, idUsuario);
                psUp.setInt(4, idServicio);
                psUp.executeUpdate();

                msg = "Cantidad del servicio actualizada.";
            } else {
                // 3. Insertar servicio con subtotal correcto
                PreparedStatement psIn = con.getConexion().prepareStatement(
                    "INSERT INTO tb_carrito(id_us, id_serv, cantidad, subtotal) VALUES (?, ?, 1, ?)"
                );
                psIn.setInt(1, idUsuario);
                psIn.setInt(2, idServicio);
                psIn.setDouble(3, precio);
                psIn.executeUpdate();

                msg = "Servicio agregado al carrito.";
            }

        } catch (Exception e) {
            msg = "Error al agregar servicio: " + e.getMessage();
        }

        return msg;
    }


    
}
