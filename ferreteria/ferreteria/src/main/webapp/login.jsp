<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ferretería Todo Posi</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <!-- ESTILOS GLOBALES -->
    <link href="css/estilos.css" rel="stylesheet" type="text/css">

    <!-- ESTILOS LOGIN -->
    <link href="css/login.css" rel="stylesheet" type="text/css">
</head>

<body>

    <!-- 🧭 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-light" href="index.jsp">
                <i class="fa-solid fa-screwdriver-wrench me-2"></i>Ferretería Todo Posi
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="servicios.jsp">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 💡 FORMULARIO LOGIN -->
    <main class="d-flex justify-content-center align-items-center min-vh-100">
        <div class="wrapper mt-5">
            <form action="validarLogin.jsp" method="post">
                <h1 class="text-light">Login</h1>

                <div class="input-box">
                    <input type="text" name="usuario" placeholder="Usuario" required>
                    <i class="fa-solid fa-user"></i>
                </div>

                <div class="input-box">
                    <input type="password" name="clave" placeholder="Contraseña" required>
                    <i class="fa-solid fa-lock"></i>
                </div>

                <div class="remember-forgot">
                    <label><input type="checkbox"> Recordarme</label>
                    <a href="#">¿Olvidaste tu contraseña?</a>
                </div>

                <% if (request.getParameter("error") != null) { %>
                    <p class="error-msg">
                        <%= request.getParameter("error") %>
                    </p>
                <% } %>

                <button type="submit" class="btn">Ingresar</button>

                <div class="register-link">
                    <p>¿No tienes cuenta? <a href="registro.jsp">Regístrate</a></p>
                </div>
            </form>
        </div>
    </main>

    <!-- ⚙️ FOOTER -->
    <footer class="bg-dark text-light text-center py-3 mt-auto">
        <ul class="list-unstyled mb-2">
            <li>Facebook <i class="fa-brands fa-facebook"></i></li>
            <li>Instagram <i class="fa-brands fa-instagram"></i></li>
            <li>Twitter <i class="fa-brands fa-twitter"></i></li>
        </ul>
        <p>&copy; 2025 Ferretería Todo Posi | Sunshine Dev Corp</p>
        <p>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</p>
    </footer>

    <!-- BOOTSTRAP JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
