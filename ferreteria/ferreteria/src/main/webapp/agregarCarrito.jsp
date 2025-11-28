<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="com.productos.negocio.Carrito,java.util.*" %>

<%
    // Validar sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
%>
<jsp:forward page="../login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para agregar productos al carrito"/>
</jsp:forward>
<%
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");
    int idProducto = Integer.parseInt(request.getParameter("id"));

    Carrito car = new Carrito();
    String mensaje = car.agregarProducto(idUsuario, idProducto);
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Carrito</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light text-center mt-5">
<div class="container">
    <div class="alert alert-info shadow-sm"><h4><%= mensaje %></h4></div>

    <a class="btn btn-primary mt-3" href="catalogo.jsp">
        Volver al catálogo
    </a>

    <a class="btn btn-success mt-3" href="carrito.jsp">
        Ir al carrito
    </a>
</div>

<script>
    setTimeout(function(){
        window.location.href = "carrito.jsp";
    }, 2000);
</script>

</body>
</html>
