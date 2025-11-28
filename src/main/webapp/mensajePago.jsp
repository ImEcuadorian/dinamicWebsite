<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idOrden = request.getParameter("id_orden");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pago Exitoso</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5 text-center">

    <div class="alert alert-success shadow p-4">
        <h1 class="fw-bold">¡Pago realizado con éxito! 🎉</h1>
        <p class="mt-3">
            Su orden ha sido registrada correctamente.
        </p>

        <h4 class="mt-3 text-primary">
            Número de orden: <strong>#<%= idOrden %>
        </strong>
        </h4>

        <p class="mt-3">Gracias por su compra en <strong>Ferretería Todo Posi</strong>.</p>
    </div>

    <a href="menu.jsp" class="btn btn-primary mt-4">Volver al inicio</a>
    <a href="historialServicios.jsp" class="btn btn-secondary mt-4">Ver historial de servicios</a>
</div>

</body>
</html>
