<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*, com.productos.negocio.*" %>
<%
    ServicioDAO dao = new ServicioDAO();
    List<Servicio> servicios = dao.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestionar Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-4">

    <h2 class="fw-bold text-primary mb-4">🔧 Gestión de Servicios</h2>
    <div class="mb-3 text-end">
        <a href="menu.jsp" class="btn btn-dark">
            <i class="fa-solid fa-arrow-left"></i> Volver al Menú
        </a>
    </div>


    <a href="nuevoServicio.jsp" class="btn btn-success mb-3">➕ Nuevo Servicio</a>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Activo</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>
        <% for (Servicio s : servicios) { %>
        <tr>
            <td><%= s.getId() %>
            </td>
            <td><%= s.getNombre() %>
            </td>
            <td><%= s.getDescripcion() %>
            </td>
            <td>$<%= s.getPrecio() %>
            </td>
            <td>
                <% if (s.getActivo()) { %>
                <span class="badge bg-success">Activo</span>
                <% } else { %>
                <span class="badge bg-secondary">Inactivo</span>
                <% } %>
            </td>
            <td>
                <a href="editarServicio.jsp?id=<%= s.getId() %>" class="btn btn-warning btn-sm">✏ Editar</a>
                <a href="eliminarServicio.jsp?id=<%= s.getId() %>" class="btn btn-danger btn-sm">🗑 Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

</div>

</body>
</html>