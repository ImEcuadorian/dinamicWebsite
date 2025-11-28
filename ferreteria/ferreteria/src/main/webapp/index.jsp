<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ferretería Todo Posi - Inicio</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <!-- ESTILOS PERSONALIZADOS -->
    <link href="css/estilos.css" rel="stylesheet" type="text/css">
</head>

<body class="bg-light">

    <!-- 🧭 NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-light" href="index.jsp">
                <i class="fa-solid fa-screwdriver-wrench me-2"></i>Ferretería Todo Posi
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="servicios.jsp" target="_blank">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp" target="_blank">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 🏠 HEADER -->
    <header class="bg-primary text-white text-center py-5 shadow-sm">
        <div class="container">
            <h1 class="display-5 fw-bold">Ferretería Todo Posi</h1>
            <h2 class="h5 mb-3">Encuentra todo lo que necesitas para tus proyectos</h2>
            <p class="lead">Construye tus sueños, nosotros ponemos las herramientas.</p>
        </div>
    </header>

    <!-- 📄 CONTENIDO PRINCIPAL -->
    <main class="container my-5">
        <div class="row g-4">

            <!-- SECCIÓN PRINCIPAL -->
            <section class="col-lg-8">
                <article class="mb-4">
                    <h3 class="text-primary fw-bold mb-3"><i class="fa-solid fa-bullseye me-2"></i>Nuestra Misión</h3>
                    <p>
                        En <strong>Ferretería Todo Posi</strong> encuentras todo lo que necesitas para tus proyectos: 
                        herramientas de calidad, materiales resistentes y el mejor asesoramiento. 
                        Somos tu aliado para construir, reparar y crear.
                        ¡Visítanos y descubre nuestras ofertas exclusivas!
                    </p>
                </article>

                <!-- CARRUSEL DE IMÁGENES -->
                <div id="carouselFerreteria" class="carousel slide carousel-fade shadow-sm mb-5" data-bs-ride="carousel">
                    <div class="carousel-inner rounded-3">
                        <div class="carousel-item active">
                            <img src="imgs/arrangement-old-objects-antiques-market.jpg" class="d-block w-100" alt="Ferretería antigua">
                        </div>
                        <div class="carousel-item">
                            <img src="imgs/ferreteria.jpg" class="d-block w-100" alt="Ferretería moderna">
                        </div>
                        <div class="carousel-item">
                            <img src="imgs/tools-2423826_1280.jpg" class="d-block w-100" alt="Herramientas">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselFerreteria" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselFerreteria" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Siguiente</span>
                    </button>
                </div>

                <!-- MAPA -->
                <article class="text-center">
                    <h4 class="text-secondary mb-3"><i class="fa-solid fa-map-location-dot me-2"></i>Nuestra Ubicación</h4>
                    <div class="ratio ratio-16x9 shadow-sm">
                        <iframe src="https://www.google.com/maps/d/u/0/embed?mid=1rOwFpMEHyK0rDH66ItcYDFTa1zJMduA&ehbc=2E312F" 
                            allowfullscreen></iframe>
                    </div>
                </article>
            </section>

            <!-- ASIDE: REDES Y PERFIL -->
            <aside class="col-lg-4 text-center">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0"><i class="fa-solid fa-user"></i> Desarrollador</h5>
                    </div>
                    <div class="card-body">
                        <p class="fw-bold mb-3">Conéctate conmigo</p>
                        <a href="https://www.linkedin.com/in/jossue-proa%C3%B1o-22ab62262/" target="_blank" class="me-3">
                            <img src="iconos/linkedIn50px.png" alt="LinkedIn" width="45">
                        </a>
                        <a href="https://github.com/Istinger" target="_blank">
                            <img src="iconos/github50px.png" alt="GitHub" width="45">
                        </a>
                    </div>
                </div>

                <div class="alert alert-info shadow-sm">
                    <i class="fa-solid fa-bell me-2"></i> ¡Nuevos productos en oferta cada semana!
                </div>
            </aside>
        </div>
    </main>

    <!-- ⚙️ FOOTER -->
    <footer class="bg-dark text-white text-center py-4">
        <ul class="list-inline mb-2">
            <li class="list-inline-item mx-2"><i class="fa-brands fa-facebook"></i> Facebook</li>
            <li class="list-inline-item mx-2"><i class="fa-brands fa-instagram"></i> Instagram</li>
            <li class="list-inline-item mx-2"><i class="fa-brands fa-twitter"></i> Twitter</li>
        </ul>
        <p class="mb-0">&copy; 2025 Sunshine Dev Corp.</p>
        <small>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</small>
    </footer>

    <!-- BOOTSTRAP JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
