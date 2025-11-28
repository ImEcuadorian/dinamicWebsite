<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    ServicioDAO dao = new ServicioDAO();
    Servicio s = dao.obtener(id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="fw-bold text-danger">🗑 Confirmar Eliminación</h2>
    <p class="mt-3">¿Seguro que deseas eliminar el servicio?</p>

    <ul>
        <li><strong>ID:</strong> <%= s.getId() %></li>
        <li><strong>Nombre:</strong> <%= s.getNombre() %></li>
        <li><strong>Precio:</strong> <%= s.getPrecio() %></li>
    </ul>

    <form action="servicioEliminarController.jsp" method="post">
        <input type="hidden" name="id" value="<%= s.getId() %>">
        <button class="btn btn-danger">Eliminar</button>
        <a href="adminServicios.jsp" class="btn btn-secondary">Cancelar</a>
    </form>

</div>

</body>
</html>