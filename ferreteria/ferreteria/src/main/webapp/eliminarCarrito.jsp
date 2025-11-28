<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="com.productos.negocio.Carrito,java.util.*" pageEncoding="UTF-8"%>

<%
    // Validación de sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para modificar el carrito"/>
</jsp:forward>
<%
        return;
    }

    // Obtener id del carrito (PK)
    String idCarrito = request.getParameter("id");

    Carrito car = new Carrito();
    String mensaje = car.eliminarProducto(idCarrito);
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Eliminando...</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light text-center mt-5">

<div class="container">
    <div class="alert alert-info shadow-sm"><h4><%= mensaje %></h4></div>

    <a class="btn btn-primary mt-3" href="carrito.jsp">
        Volver al carrito
    </a>
</div>

<script>
    setTimeout(function() {
        window.location.href = "carrito.jsp";
    }, 1500);
</script>

</body>
</html>
