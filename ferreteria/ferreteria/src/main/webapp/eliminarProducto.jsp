<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.productos.negocio.*" %>
<%
    String id = request.getParameter("id");
    Producto p = new Producto();
    String msg = p.eliminarProducto(id);
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container text-center mt-5">
    <h3><%= msg %></h3>
    <a href="listProducts.jsp" class="btn btn-primary mt-3">Volver</a>
       
        <script>
      setTimeout(function() {
        window.location.href = "listProducts.jsp";
      }, 2500);
    </script>
</div>
</body>
</html>
