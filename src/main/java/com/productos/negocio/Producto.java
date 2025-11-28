package com.productos.negocio;

import java.sql.*;

import com.productos.datos.Conexion;

public class Producto {
    int id;
    int id_cat;
    String nombre;
    int cantidad;
    double precio;
    String categoria;
    boolean enOferta;
    double descuento;

    public Producto() {
    }

    // Getters y Setters

    public boolean getEnOferta() {
        return enOferta;
    }

    public void setEnOferta(boolean enOferta) {
        this.enOferta = enOferta;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCat() {
        return id_cat;
    }

    public void setIdCat(int id_cat) {
        this.id_cat = id_cat;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    // ============ LISTAR PRODUCTOS ============
    public String listarProductos() {
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder tabla = new StringBuilder();

        tabla.append("<div class='table-responsive'>");
        tabla.append("<table class='table table-striped table-hover align-middle'>");
        tabla.append("<thead class='table-dark text-center'>");
        tabla.append("<tr>")
                .append("<th>ID</th>")
                .append("<th>Nombre</th>")
                .append("<th>Categoría</th>")
                .append("<th>Cantidad</th>")
                .append("<th>Precio</th>")
                .append("<th>Oferta</th>")
                .append("<th>Acciones</th>")
                .append("</tr>")
                .append("</thead><tbody>");

        try {
            String sql = """
                        SELECT p.id_pr, p.nombre_pr, c.descripcion_cat, 
                               p.cantidad_pr, p.precio_pr, 
                               p.en_oferta, p.descuento
                        FROM tb_producto p
                        JOIN tb_categoria c ON p.id_cat = c.id_cat
                        ORDER BY p.id_pr;
                    """;

            rs = con.Consulta(sql);

            while (rs.next()) {
                boolean enOferta = rs.getBoolean("en_oferta");
                double descuento = rs.getDouble("descuento");
                double precio = rs.getDouble("precio_pr");
                double precioFinal = precio - (precio * descuento / 100);

                // Si está en oferta, aplicamos un color distinto
                String rowClass = enOferta ? "table-warning" : "";

                tabla.append("<tr class='").append(rowClass).append("'>")
                        .append("<td class='text-center'>").append(rs.getInt("id_pr")).append("</td>")
                        .append("<td>").append(rs.getString("nombre_pr")).append("</td>")
                        .append("<td>").append(rs.getString("descripcion_cat")).append("</td>")
                        .append("<td class='text-center'>").append(rs.getInt("cantidad_pr")).append("</td>");

                if (enOferta) {
                    tabla.append("<td>")
                            .append("<span class='text-decoration-line-through text-danger'>$").append(precio).append("</span> ")
                            .append("<span class='fw-bold text-success'>$").append(String.format("%.2f", precioFinal)).append("</span>")
                            .append("</td>")
                            .append("<td class='text-center'><span class='badge bg-warning text-dark'>-")
                            .append((int) descuento).append("%</span></td>");
                } else {
                    tabla.append("<td>$").append(String.format("%.2f", precio)).append("</td>")
                            .append("<td class='text-center text-muted'>—</td>");
                }

                tabla.append("<td class='text-center'>")
                        .append("<a href='editarProducto.jsp?id=").append(rs.getInt("id_pr"))
                        .append("' class='btn btn-sm btn-warning me-2'><i class='fa-solid fa-pen'></i> Editar</a>")
                        .append("<button class='btn btn-sm btn-danger' ")
                        .append("onclick=\"if(confirm('¿Desea eliminar este producto?')) ")
                        .append("window.location.href='eliminarProducto.jsp?id=").append(rs.getInt("id_pr")).append("';\">")
                        .append("<i class='fa-solid fa-trash'></i> Eliminar</button>")
                        .append("</td>")
                        .append("</tr>");
            }

        } catch (Exception e) {
            tabla.append("<tr><td colspan='7' class='text-danger text-center'>Error: ")
                    .append(e.getMessage())
                    .append("</td></tr>");
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception ex) {
            }
        }

        tabla.append("</tbody></table></div>");
        return tabla.toString();
    }


    // ============ INSERTAR PRODUCTO ============
//    public String insertarProducto() {
//        String result = "";
//        Conexion con = new Conexion();
//        try {
//            String sql = "INSERT INTO tb_producto (id_cat, nombre_pr, cantidad_pr, precio_pr) VALUES (?, ?, ?, ?)";
//            PreparedStatement ps = con.getConexion().prepareStatement(sql);
//            ps.setInt(1, this.getIdCat());
//            ps.setString(2, this.getNombre());
//            ps.setInt(3, this.getCantidad());
//            ps.setDouble(4, this.getPrecio());
//            int filas = ps.executeUpdate();
//            result = (filas > 0) ? "Producto agregado correctamente." : "Error al insertar producto.";
//            ps.close();
//        } catch (Exception e) {
//            result = "Error: " + e.getMessage();
//        }
//        return result;
//    }
    // ============ INSERTAR PRODUCTO ============
    public String insertarProducto() {
        String result = "";
        Conexion con = new Conexion();
        try {
            String sql = "INSERT INTO tb_producto (id_cat, nombre_pr, cantidad_pr, precio_pr, en_oferta, descuento) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, this.getIdCat());
            ps.setString(2, this.getNombre());
            ps.setInt(3, this.getCantidad());
            ps.setDouble(4, this.getPrecio());
            ps.setBoolean(5, this.getEnOferta());
            ps.setDouble(6, this.getDescuento());

            int filas = ps.executeUpdate();
            result = (filas > 0) ? "✅ Producto agregado correctamente." : "⚠️ No se insertó el producto.";
            ps.close();
        } catch (Exception e) {
            result = "❌ Error al insertar producto: " + e.getMessage();
        } finally {
            try {
                con.getConexion().close();
            } catch (Exception ex) {
            }
        }
        return result;
    }


    // ============ ELIMINAR PRODUCTO ============
    public String eliminarProducto(String id) {
        String result = "";
        Conexion con = new Conexion();
        try {
            String sql = "DELETE FROM tb_producto WHERE id_pr = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            int filas = ps.executeUpdate();
            result = (filas > 0) ? "Producto eliminado correctamente." : "No se encontró el producto.";
            ps.close();
        } catch (Exception e) {
            result = "Error al eliminar: " + e.getMessage();
        }
        return result;
    }

    // ============ BUSCAR PRODUCTO ============
    // ============ BUSCAR PRODUCTO ============
    public Producto buscarProductoPorId(String id) {
        Producto p = null;
        Conexion con = new Conexion();
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM tb_producto WHERE id_pr = ?";
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Producto();
                p.setId(rs.getInt("id_pr"));
                p.setIdCat(rs.getInt("id_cat"));
                p.setNombre(rs.getString("nombre_pr"));
                p.setCantidad(rs.getInt("cantidad_pr"));
                p.setPrecio(rs.getDouble("precio_pr"));
                p.setEnOferta(rs.getBoolean("en_oferta"));
                p.setDescuento(rs.getDouble("descuento"));
            }

            ps.close();

        } catch (Exception e) {
            System.out.println("Error buscarProductoPorId: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception ex) {
            }
        }
        return p;
    }

    // ============ ACTUALIZAR PRODUCTO ============
//    public String actualizarProducto() {
//        String result = "";
//        Conexion con = new Conexion();
//        try {
//            String sql = "UPDATE tb_producto SET id_cat=?, nombre_pr=?, cantidad_pr=?, precio_pr=? WHERE id_pr=?";
//            PreparedStatement ps = con.getConexion().prepareStatement(sql);
//            ps.setInt(1, this.getIdCat());
//            ps.setString(2, this.getNombre());
//            ps.setInt(3, this.getCantidad());
//            ps.setDouble(4, this.getPrecio());
//            ps.setInt(5, this.getId());
//            int filas = ps.executeUpdate();
//            result = (filas > 0) ? "Producto actualizado correctamente." : "No se encontró el producto.";
//            ps.close();
//        } catch (Exception e) {
//            result = "Error: " + e.getMessage();
//        }
//        return result;
//    }
    // ============ ACTUALIZAR PRODUCTO ============
    public String actualizarProducto() {
        String result = "";
        Conexion con = new Conexion();
        try {
            String sql = """
                        UPDATE tb_producto
                        SET id_cat = ?, nombre_pr = ?, cantidad_pr = ?, precio_pr = ?, en_oferta = ?, descuento = ?
                        WHERE id_pr = ?
                    """;
            PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, this.getIdCat());
            ps.setString(2, this.getNombre());
            ps.setInt(3, this.getCantidad());
            ps.setDouble(4, this.getPrecio());
            ps.setBoolean(5, this.getEnOferta());
            ps.setDouble(6, this.getDescuento());
            ps.setInt(7, this.getId());

            int filas = ps.executeUpdate();
            result = (filas > 0) ? "✅ Producto actualizado correctamente." : "⚠️ No se encontró el producto.";
            ps.close();
        } catch (Exception e) {
            result = "❌ Error al actualizar producto: " + e.getMessage();
        } finally {
            try {
                con.getConexion().close();
            } catch (Exception ex) {
            }
        }
        return result;

    }

    public String listarCatalogo() {
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder html = new StringBuilder();

        try {
            String sql = """
                        SELECT id_pr, id_cat, nombre_pr, cantidad_pr, precio_pr,
                               en_oferta, descuento
                        FROM tb_producto
                        ORDER BY id_pr;
                    """;

            rs = con.Consulta(sql);

            html.append("<div class='row row-cols-1 row-cols-md-3 g-4'>");

            while (rs.next()) {
                int id = rs.getInt("id_pr");
                String nombre = rs.getString("nombre_pr");
                int stock = rs.getInt("cantidad_pr");
                double precio = rs.getDouble("precio_pr");
                boolean oferta = rs.getBoolean("en_oferta");
                double descuento = rs.getDouble("descuento");

                double precioFinal = oferta ?
                        (precio - (precio * descuento / 100)) :
                        precio;

                html.append("<div class='col'>");
                html.append("<div class='card shadow-sm h-100'>");

                // Imagen temporal (si en el futuro quieres cargar fotos desde BD se puede)
                html.append("<img src='img/producto.png' class='card-img-top' style='height:180px; object-fit:contain;'>");

                html.append("<div class='card-body text-center'>");
                html.append("<h5 class='card-title fw-bold'>").append(nombre).append("</h5>");

                // Mostrar precio
                if (oferta) {
                    html.append("<p class='card-text'>");
                    html.append("<span class='text-decoration-line-through text-danger'>$").append(precio).append("</span> ");
                    html.append("<span class='text-success fw-bold'>$").append(String.format("%.2f", precioFinal)).append("</span>");
                    html.append("<br><span class='badge bg-warning text-dark'>Oferta -").append((int) descuento).append("%</span>");
                    html.append("</p>");
                } else {
                    html.append("<p class='card-text fw-bold'>$").append(String.format("%.2f", precio)).append("</p>");
                }

                // Stock
                html.append("<p class='text-muted'>Stock: ").append(stock).append("</p>");

                // Botón agregar al carrito
                if (stock > 0) {
                    html.append("<a href='agregarCarrito.jsp?id=").append(id)
                            .append("' class='btn btn-primary w-100'>")
                            .append("<i class='fa-solid fa-cart-plus'></i> Agregar al carrito</a>");
                } else {
                    html.append("<button class='btn btn-secondary w-100' disabled>Sin stock</button>");
                }

                html.append("</div></div></div>");
            }

            html.append("</div>");

        } catch (Exception ex) {
            html.append("<div class='alert alert-danger'>Error: ").append(ex.getMessage()).append("</div>");
        } finally {
            try {
                if (rs != null) rs.close();
                con.getConexion().close();
            } catch (Exception e) {
            }
        }

        return html.toString();
    }

    public String listarOfertas() {
        Conexion con = new Conexion();
        ResultSet rs = null;
        StringBuilder html = new StringBuilder();

        try {
            String sql = """
                        SELECT id_pr, nombre_pr, precio_pr, descuento
                        FROM tb_producto
                        WHERE en_oferta = TRUE
                    """;
            rs = con.Consulta(sql);

            while (rs.next()) {
                double precio = rs.getDouble("precio_pr");
                double descuento = rs.getDouble("descuento");
                double precioFinal = precio - (precio * descuento / 100);

                html.append("<div class='col-md-4 mb-4'>")
                        .append("<div class='card shadow h-100'>")
                        .append("<div class='card-body text-center'>")

                        .append("<h5 class='text-primary'>")
                        .append(rs.getString("nombre_pr"))
                        .append("</h5>")

                        .append("<p>")
                        .append("<span class='text-decoration-line-through text-danger'>$")
                        .append(precio)
                        .append("</span><br>")

                        .append("<strong class='text-success'>$")
                        .append(String.format("%.2f", precioFinal))
                        .append("</strong><br>")

                        .append("<span class='badge bg-warning text-dark'>-")
                        .append((int) descuento)
                        .append("%</span>")
                        .append("</p>")

                        // BOTÓN DE AGREGAR AL CARRITO
                        .append("<form action='agregarCarrito.jsp' method='post'>")
                        .append("<input type='hidden' name='id' value='").append(rs.getInt("id_pr")).append("'>")
                        .append("<input type='hidden' name='cantidad' value='1'>")
                        .append("<button class='btn btn-outline-primary btn-sm'>")
                        .append("<i class='fa-solid fa-cart-shopping'></i> Agregar")
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
