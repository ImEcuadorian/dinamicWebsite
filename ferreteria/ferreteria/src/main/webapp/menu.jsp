<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" import="com.productos.seguridad.*,java.util.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para acceder al sistema."/>
</jsp:forward>
<%
        return;
    }

    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    // Fecha de creación de sesión (hora de login)
    Date fechaLogin = new Date(sesion.getCreationTime());
    String fechaFormateada = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(fechaLogin);

    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);


%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú del Sistema</title>
    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>
    <!-- ESTILOS PROPIOS -->
    <link href="css/menu.css" rel="stylesheet" type="text/css">
</head>

<body>
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

      <!-- Usuario + ícono -->
      <span class="navbar-text text-white me-3">
        <i class="fa-solid fa-user-gear me-1"></i> <%= usuario %>
      </span>

      <form class="d-inline" action="cerrarSesion.jsp" method="post">
        <button class="btn btn-outline-light btn-sm">
          <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
        </button>
      </form>
    </div>
  </div>
</nav>


    <!-- CONTENIDO PRINCIPAL -->
    <div class="container my-5">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-primary">Bienvenido: <%= usuario %></h2>
            <p class="text-muted">
                <i class="fa-solid fa-calendar-days me-2"></i>Inicio de sesión: <%= fechaFormateada %>
            </p>
        </div>
    </div>

    <!-- FOOTER -->
 <footer class="bg-dark text-light text-center py-3">
            <ul class="list-unstyled mb-2">
                <li>Facebook <i class="fa-brands fa-facebook"></i></li>
                <li>Instagram <i class="fa-brands fa-instagram"></i></li>
                <li>Twitter <i class="fa-brands fa-twitter"></i></li>
            </ul>
            <p>&copy; 2025 Sunshine Dev Corp.</p>
            <p>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</p>
        </footer>

    <!-- BOOTSTRAP JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
