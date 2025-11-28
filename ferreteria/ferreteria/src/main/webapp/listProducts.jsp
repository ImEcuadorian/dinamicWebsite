<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" session="true" import="com.productos.negocio.*,java.util.*,com.productos.seguridad.*" %>

<%
    // ================= VALIDACIÓN DE SESIÓN ===================
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Debe iniciar sesión para acceder al sistema."/>
</jsp:forward>
<%
        return;
    }

    // ================= DATOS DE SESIÓN ===================
    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    Date fechaLogin = new Date(sesion.getCreationTime());
    String fechaFormateada = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(fechaLogin);

    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Productos</title>

<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- ICONOS -->
<script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>
<!-- CSS PERSONALIZADO -->
<link href="css/menu.css" rel="stylesheet" type="text/css">
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

<!-- 📦 CONTENIDO PRINCIPAL -->
<div class="container my-5">

  <div class="text-center mb-4">
    <h2 class="fw-bold text-primary">
      <i class="fa-solid fa-boxes-stacked"></i> Gestión de Productos
    </h2>
    <p class="text-muted">
      <i class="fa-solid fa-calendar-days me-2"></i>Inicio de sesión: <%= fechaFormateada %>
    </p>
  </div>

  <!-- 📋 LISTADO DE PRODUCTOS -->
  <div class="card shadow-sm mb-5">
    <div class="card-body">
      <%
        Producto p = new Producto();
        out.println(p.listarProductos());
      %>
    </div>
  </div>

  <!-- 🧾 FORMULARIO DE REGISTRO -->
  <div class="card shadow-lg mx-auto" style="max-width:700px;">
    <div class="card-header bg-primary text-white text-center">
      <h3 class="mb-0"><i class="fa-solid fa-box-open me-2"></i>Registrar Nuevo Producto</h3>
    </div>
    <div class="card-body">
      <form action="nuevoProducto.jsp" method="post">
        <div class="mb-3">
          <label for="nombre" class="form-label">Nombre</label>
          <input type="text" name="nombre" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="categoria" class="form-label">Categoría</label>
          <select class="form-select" name="categoria" required>
            <option value="1">Herramientas</option>
            <option value="2">Electricidad</option>
            <option value="3">Pintura</option>
            <option value="4">Fontanería</option>
            <option value="5">Construcción</option>
          </select>
        </div>
        <div class="mb-3">
          <label for="cantidad" class="form-label">Cantidad</label>
          <input type="number" name="cantidad" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="precio" class="form-label">Precio</label>
          <input type="number" step="0.01" name="precio" class="form-control" required>
        </div>
        <div class="text-center">
          <button type="submit" class="btn btn-success px-4"><i class="fa-solid fa-plus"></i> Agregar</button>
          <button type="reset" class="btn btn-secondary px-4"><i class="fa-solid fa-eraser"></i> Limpiar</button>
        </div>
      </form>
    </div>
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

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
