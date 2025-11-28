<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="true"
         import="com.productos.negocio.*,com.productos.seguridad.*,java.util.*" %>

<%
    // Verificar sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
%>
<jsp:forward page="../login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para ver el catálogo"/>
</jsp:forward>
<%
        return;
    }

    Integer perfil = (Integer) sesion.getAttribute("perfil");
    String usuario = (String) sesion.getAttribute("usuario");

    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);

    Producto prod = new Producto();
    String cards = prod.listarCatalogo();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Productos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

</head>
<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">

        <a class="navbar-brand fw-bold text-light" href="index.jsp">
            <i class="fa-solid fa-store"></i> Catálogo
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menuNavbar">
            <ul class="navbar-nav me-auto">
                <%= menu %>
            </ul>

            <span class="navbar-text text-white me-3">
        <i class="fa-solid fa-user"></i> <%= usuario %>
      </span>
        </div>
    </div>
</nav>

<!-- CONTENIDO -->
<div class="container my-5">

    <h2 class="fw-bold text-primary mb-4 text-center">
        <i class="fa-solid fa-boxes-stacked"></i> Catálogo de Productos
    </h2>

    <%= cards %>

</div>

</body>
</html>
