<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.Usuario" %>

<%
    // Obtener el ID del usuario a eliminar
    String id = request.getParameter("id");
    Usuario user = new Usuario();

    String mensaje = user.eliminarUsuario(id);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Eliminar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5 text-center">
    <div class="alert alert-info shadow-sm">
        <h4 class="alert-heading"><%= mensaje %></h4>
    </div>
    <a href="usuarios.jsp" class="btn btn-primary mt-3">
        <i class="fa-solid fa-arrow-left"></i> Volver a Usuarios
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
