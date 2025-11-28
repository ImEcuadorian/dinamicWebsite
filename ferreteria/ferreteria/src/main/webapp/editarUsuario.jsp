<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.Usuario" %>

<%
    String id = request.getParameter("id");
    Usuario user = new Usuario().buscarUsuarioPorId(id);

    if (user == null) {
%>
    <h2>No se encontró el usuario.</h2>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">
        <i class="fa-solid fa-user-pen"></i> Editar Usuario
    </h2>

    <form action="actualizarUsuario.jsp" method="post" class="shadow p-4 bg-white rounded">
        <input type="hidden" name="id" value="<%= user.getId() %>">


        <div class="mb-3">
            <label class="form-label">Nombre:</label>
            <input type="text" class="form-control" name="nombre" value="<%= user.getNombre() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Cédula:</label>
            <input type="text" class="form-control" name="cedula" value="<%= user.getCedula() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Correo:</label>
            <input type="email" class="form-control" name="correo" value="<%= user.getCorreo() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Clave:</label>
            <input type="password" class="form-control" name="clave" value="<%= user.getClave() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Perfil:</label>
            <select class="form-select" name="perfil">
                <option value="1" <%= (user.getPerfil() == 1 ? "selected" : "") %>>Administrador</option>
                <option value="2" <%= (user.getPerfil() == 2 ? "selected" : "") %>>Cliente</option>
                <option value="3" <%= (user.getPerfil() == 3 ? "selected" : "") %>>Empleado</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Estado Civil:</label>
            <select class="form-select" name="estado">
                <option value="1" <%= (user.getEstado() == 1 ? "selected" : "") %>>Casado</option>
                <option value="2" <%= (user.getEstado() == 2 ? "selected" : "") %>>Soltero</option>
                <option value="3" <%= (user.getEstado() == 3 ? "selected" : "") %>>Divorciado</option>
                <option value="4" <%= (user.getEstado() == 4 ? "selected" : "") %>>Amigos</option>
                <option value="5" <%= (user.getEstado() == 5 ? "selected" : "") %>>Viudo</option>
            </select>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-success px-4">
                <i class="fa-solid fa-floppy-disk"></i> Guardar Cambios
            </button>
            <a href="usuarios.jsp" class="btn btn-secondary px-4">
                <i class="fa-solid fa-arrow-left"></i> Cancelar
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
