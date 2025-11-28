<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.productos.seguridad.*" %>
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

    // Recuperar usuario y perfil desde sesión
    String usuario = (String) sesion.getAttribute("usuario");
    Integer perfil = (Integer) sesion.getAttribute("perfil");

    // Generar el menú dinámico según el perfil
    Pagina pag = new Pagina();
    String menu = pag.mostrarMenu(perfil);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - Ferretería Todo Posi</title>

    <!-- BOOTSTRAP CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <!-- ESTILOS PROPIOS -->
    <link href="css/estilos.css" rel="stylesheet" type="text/css">

    <!-- JAVASCRIPT SCRIP VERIFICACION ELIMINACION USUARIO -->
    <script>
        function confirmarEliminacion(id) {
            const confirmacion = confirm("¿Está seguro que desea eliminar este usuario?");
            if (confirmacion) {
                window.location.href = "eliminarUsuario.jsp?id=" + id;
            }
        }
    </script>

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

            <!-- Usuario y botón de cierre -->
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

<!-- 📋 LISTA DE USUARIOS -->
<main class="container my-5">
    <section class="mb-5">
        <h2 class="text-center text-primary mb-4">
            <i class="fa-solid fa-users"></i> Lista de Usuarios
        </h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <%
                    Usuario u = new Usuario();
                    out.println(u.consultarUsuarios());
                %>
            </div>
        </div>
    </section>

    <!-- 🧾 FORMULARIO DE REGISTRO -->
    <section>
        <div class="card shadow-lg mx-auto" style="max-width: 700px;">
            <div class="card-header bg-primary text-white text-center">
                <h3 class="mb-0">
                    <i class="fa-solid fa-user-tie me-2"></i>Registrar Administrador / Vendedor
                </h3>
            </div>

            <div class="card-body">
                <form action="nuevoEmpleado.jsp" method="post" id="formEmpleado">
                    <div class="row mb-3">
                        <div class="col">
                            <label for="nombre" class="form-label">Nombre completo</label>
                            <input type="text" class="form-control" id="nombre" name="txtNombre" required>
                        </div>
                        <div class="col">
                            <label for="cedula" class="form-label">Cédula</label>
                            <input type="text" class="form-control" id="cedula" name="txtCedula" maxlength="10"
                                   required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="perfil" class="form-label">Tipo de Perfil</label>
                        <select class="form-select" id="perfil" name="cmbPerfil" required>
                            <option value="">Selecciona un tipo de perfil</option>
                            <option value="1">Administrador</option>
                            <option value="3">Vendedor</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="email" name="txtCorreo"
                               placeholder="usuario@correo.com" required>
                    </div>

                    <div class="mb-3">
                        <label for="clave" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="clave" name="txtClave" required>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-success px-4 me-2">
                            <i class="fa-solid fa-check"></i> Registrar
                        </button>
                        <button type="reset" class="btn btn-secondary px-4">
                            <i class="fa-solid fa-eraser"></i> Limpiar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </section>
</main>

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
