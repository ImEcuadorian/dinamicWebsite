<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.productos.negocio.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");

    Compra procesar = new Compra();
    String resultado = procesar.procesarCompra(idUsuario);

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra realizada</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light text-center mt-5">

<div class="container">
    <% if ("OK".equals(resultado)) { %>

    <div class="alert alert-success p-4 shadow">
        <h2><i class="fa-solid fa-circle-check"></i> ¡Compra realizada con éxito!</h2>
        <p>Gracias por su compra. Su pedido ha sido registrado.</p>
    </div>

    <% } else { %>

    <div class="alert alert-danger p-4 shadow">
        <h2><i class="fa-solid fa-triangle-exclamation"></i> Error</h2>
        <p><%= resultado %>
        </p>
    </div>

    <% } %>

    <a href="catalogo.jsp" class="btn btn-primary mt-3">
        <i class="fa-solid fa-store"></i> Volver al catálogo
    </a>
</div>

</body>
</html>
