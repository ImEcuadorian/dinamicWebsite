<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto - Ferretería Todo Posi</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <!-- ESTILOS -->
    <link href="css/estilos.css" rel="stylesheet" type="text/css">

    <!-- MODEL VIEWER -->
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js"></script>
</head>

<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
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
                <li class="nav-item"><a class="nav-link active" href="contacto.jsp">Contacto</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- SECCIÓN CONTACTO -->
<main class="container my-5">
    <div class="row align-items-center">
        <div class="col-lg-6 text-center mb-4 mb-lg-0">
            <model-viewer class="contact-model shadow-sm rounded-4"
                          camera-controls touch-action="pan-y" autoplay
                          ar ar-modes="webxr scene-viewer"
                          scale="0.2 0.2 0.2" shadow-intensity="1"
                          src="model3D/female-character-809.glb"
                          alt="Modelo 3D de asistente virtual"></model-viewer>
        </div>

        <div class="col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <h3 class="text-primary mb-4">
                        <i class="fa-solid fa-envelope-open-text me-2"></i>Contáctanos
                    </h3>
                    <p>📧 Escríbenos a: <a href="mailto:info@ferreteria.com">info@ferreteria.com</a></p>
                    <p>📞 Teléfono: (123) 456-7890</p>
                    <p>🕘 Horario: Lunes a Viernes 9:00 – 18:00</p>
                    <hr>
                    <p class="text-muted">
                        O visítanos en nuestras redes sociales para conocer ofertas y novedades.
                    </p>
                    <div>
                        <a href="https://www.facebook.com/jossue.proano" class="text-primary me-3"><i
                                class="fa-brands fa-facebook fa-2x"></i></a>
                        <a href="https://www.instagram.com/jossh_8/" class="text-danger me-3"><i
                                class="fa-brands fa-instagram fa-2x"></i></a>
                        <a href="https://x.com/" class="text-info"><i class="fa-brands fa-twitter fa-2x"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center py-3 mt-5">
    <p>&copy; 2025 Ferretería Todo Posi - Todos los derechos reservados</p>
    <p>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</p>
</footer>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
