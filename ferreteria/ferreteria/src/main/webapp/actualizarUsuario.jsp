<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.Usuario" %>

<%
    // Capturar parámetros del formulario
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String cedula = request.getParameter("cedula");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int perfil = Integer.parseInt(request.getParameter("perfil"));
    int estado = Integer.parseInt(request.getParameter("estado"));

    Usuario user = new Usuario();
    user.setId(Integer.parseInt(id));
    user.setNombre(nombre);
    user.setCedula(cedula);
    user.setCorreo(correo);
    user.setClave(clave);
    user.setPerfil(perfil);
    user.setEstado(estado);

    String mensaje = user.actualizarUsuario(user);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actualizar Usuario</title>
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
