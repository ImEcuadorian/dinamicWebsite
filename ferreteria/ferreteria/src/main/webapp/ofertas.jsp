<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*,com.productos.negocio.*" %>

<%
    // 🔹 Validación de sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para ver las ofertas."/>
</jsp:forward>
<%
        return;
    }

    // 🔹 Datos de sesión
    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    // 🔹 Menú según el perfil
    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);

    // 🔹 Obtener HTML de ofertas desde la clase Producto
    Producto prod = new Producto();
    String htmlOfertas = prod.listarOfertas();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ofertas - Ferretería Todo Posi</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>
</head>

<body class="bg-light">

<!-- 🧭 NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
  <div class="container-fluid">

    <a class="navbar-brand fw-bold text-light" href="index.jsp">
      <i class="fa-solid fa-house me-2"></i>Home
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="menuNavbar">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <%= menu %>
      </ul>

      <span class="navbar-text text-white me-3">
        <i class="fa-solid fa-user me-1"></i> <%= usuario %>
      </span>

      <form class="d-inline" action="cerrarSesion.jsp" method="post">
        <button class="btn btn-outline-light btn-sm">
          <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
        </button>
      </form>
    </div>
  </div>
</nav>

<!-- 🏷️ CONTENIDO PRINCIPAL -->
<div class="container my-5">

  <h2 class="text-center text-primary mb-4">
    <i class="fa-solid fa-tags"></i> Productos en Oferta
  </h2>

  <div class="row">
      <%= htmlOfertas %>
  </div>

</div>

<!-- ⚙️ FOOTER -->
<footer class="bg-dark text-light text-center py-3 mt-5">
  <ul class="list-unstyled mb-2">
    <li>Facebook <i class="fa-brands fa-facebook"></i></li>
    <li>Instagram <i class="fa-brands fa-instagram"></i></li>
    <li>Twitter <i class="fa-brands fa-twitter"></i></li>
  </ul>
  <p>&copy; 2025 Sunshine Dev Corp.</p>
  <p>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
