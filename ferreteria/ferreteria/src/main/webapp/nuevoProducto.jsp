<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.productos.negocio.*" %>
<%
    Producto p = new Producto();
    p.setNombre(request.getParameter("nombre"));
    p.setIdCat(Integer.parseInt(request.getParameter("categoria")));
    p.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
    p.setPrecio(Double.parseDouble(request.getParameter("precio")));

    String resultado = p.insertarProducto();
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>registro Producto</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container text-center mt-5">
    <h3><%= resultado %></h3>
    <a href="listProducts.jsp" class="btn btn-primary mt-3">Volver</a>
        <script>
      setTimeout(function() {
        window.location.href = "listProducts.jsp";
      }, 2500);
    </script>
</div>
</body>
</html>
