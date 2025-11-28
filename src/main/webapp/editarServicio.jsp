<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.productos.negocio.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ServicioDAO dao = new ServicioDAO();
    Servicio s = dao.obtener(id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="fw-bold text-primary mb-4">✏ Editar Servicio</h2>

    <form method="post" action="servicioEditarController.jsp">

        <input type="hidden" name="id" value="<%= s.getId() %>">

        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" value="<%= s.getNombre() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <textarea name="descripcion" class="form-control" required><%= s.getDescripcion() %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" step="0.01" name="precio" value="<%= s.getPrecio() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Activo</label>
            <select name="activo" class="form-select">
                <option value="true" <%= s.getActivo() ? "selected" : "" %>>Activo</option>
                <option value="false" <%= !s.getActivo() ? "selected" : "" %>>Inactivo</option>
            </select>
        </div>

        <button class="btn btn-warning">Actualizar</button>
        <a href="adminServicios.jsp" class="btn btn-secondary">Cancelar</a>

    </form>

</div>

</body>
</html>