<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.productos.negocio.*" %>
<%
    String id = request.getParameter("id");
    Producto p = new Producto().buscarProductoPorId(id);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3 class="text-center text-primary mb-4">
        <i class="fa-solid fa-pen-to-square"></i> Editar Producto
    </h3>

    <form action="actualizarProducto.jsp" method="post" class="shadow-lg p-4 bg-white rounded">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <!-- Nombre -->
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= p.getNombre() %>" required>
        </div>

        <!-- Categoría -->
        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <select class="form-select" name="categoria" required>
                <option value="1" <%= (p.getIdCat() == 1 ? "selected" : "") %>>Herramientas</option>
                <option value="2" <%= (p.getIdCat() == 2 ? "selected" : "") %>>Electricidad</option>
                <option value="3" <%= (p.getIdCat() == 3 ? "selected" : "") %>>Pintura</option>
                <option value="4" <%= (p.getIdCat() == 4 ? "selected" : "") %>>Fontanería</option>
                <option value="5" <%= (p.getIdCat() == 5 ? "selected" : "") %>>Construcción</option>
            </select>
        </div>

        <!-- Cantidad -->
        <div class="mb-3">
            <label class="form-label">Cantidad</label>
            <input type="number" name="cantidad" class="form-control" value="<%= p.getCantidad() %>" required>
        </div>

        <!-- Precio -->
        <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" step="0.01" name="precio" class="form-control" value="<%= p.getPrecio() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">¿En oferta?</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="enOferta"
                       value="true" <%= (p.getEnOferta() ? "checked" : "") %>> Sí
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="enOferta"
                       value="false" <%= (!p.getEnOferta() ? "checked" : "") %>> No
            </div>
        </div>

        <div class="mb-3">
            <label for="descuento" class="form-label">Descuento (%)</label>
            <input type="number" name="descuento" step="1" min="0" max="100" value="<%= p.getDescuento() %>"
                   class="form-control">
        </div>


        <div class="text-center">
            <button type="submit" class="btn btn-success px-4">
                <i class="fa-solid fa-floppy-disk"></i> Guardar cambios
            </button>
            <a href="listProducts.jsp" class="btn btn-secondary px-4">
                <i class="fa-solid fa-arrow-left"></i> Volver
            </a>
        </div>
    </form>
</div>

</body>
</html>
