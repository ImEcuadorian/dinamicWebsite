<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="com.productos.negocio.*, com.productos.seguridad.*" pageEncoding="UTF-8" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Servicio serv = new Servicio();
    String lista = serv.listarServiciosCliente();

    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Servicios Disponibles</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold text-light" href="index.jsp">
            <i class="fa-solid fa-toolbox me-2"></i> Servicios
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

<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">
        <i class="fa-solid fa-screwdriver-wrench"></i> Servicios Disponibles
    </h2>

    <div class="row">
        <%= lista %>
    </div>
</div>

</body>
</html>
