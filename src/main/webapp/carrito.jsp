<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="com.productos.negocio.*,com.productos.seguridad.*,java.util.*" %>

<%
    // Validación de sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para ver el carrito."/>
</jsp:forward>
<%
        return;
    }

    String usuario = (String) sesion.getAttribute("usuario");
    int idUsuario = (Integer) sesion.getAttribute("id_us");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);

    Carrito car = new Carrito();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Carrito</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js"></script>

</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">

        <a class="navbar-brand fw-bold text-light" href="index.jsp">
            <i class="fa-solid fa-cart-shopping me-2"></i>Carrito
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

            <form action="cerrarSesion.jsp" method="post">
                <button class="btn btn-outline-light btn-sm">
                    <i class="fa-solid fa-right-from-bracket"></i> Salir
                </button>
            </form>
        </div>

    </div>
</nav>

<div class="container my-5">
    <h2 class="fw-bold text-primary mb-4 text-center">
        <i class="fa-solid fa-basket-shopping"></i> Carrito de Compras
    </h2>

    <div class="card shadow-sm">
        <div class="card-body">
            <%= car.listarCarrito(idUsuario) %>

            <div class="mt-4 text-center">
                <a href="catalogo.jsp" class="btn btn-secondary me-2">
                    <i class="fa-solid fa-arrow-left"></i> Seguir comprando
                </a>

                <a href="checkout.jsp" class="btn btn-success">
                    <i class="fa-solid fa-credit-card"></i> Pagar
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
