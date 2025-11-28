<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="com.productos.negocio.Producto" %>

<%
    int idCat = Integer.parseInt(request.getParameter("categoria"));
    String nombre = request.getParameter("nombre");
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precio = Double.parseDouble(request.getParameter("precio"));
    boolean enOferta = Boolean.parseBoolean(request.getParameter("enOferta"));
    double descuento = Double.parseDouble(request.getParameter("descuento"));

    Producto p = new Producto();
    p.setIdCat(idCat);
    p.setNombre(nombre);
    p.setCantidad(cantidad);
    p.setPrecio(precio);
    p.setEnOferta(enOferta);
    p.setDescuento(descuento);

    String resultado = p.insertarProducto();
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Nuevo Producto</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light text-center mt-5">
  <div class="container">
    <div class="alert alert-info shadow-sm"><h4><%= resultado %></h4></div>
    <a href="listProducts.jsp" class="btn btn-primary mt-3">Volver</a>
  </div>
</body>
</html>
