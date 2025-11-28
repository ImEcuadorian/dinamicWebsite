<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos - Ferretería Todo Posi</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ICONOS -->
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <!-- ESTILOS PERSONALIZADOS -->
    <link href="css/estilos.css" rel="stylesheet" type="text/css">

    <!-- MODEL VIEWER -->
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js"></script>
</head>

<body class="bg-light">
<!-- 🧭 NAVBAR -->
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
                <li class="nav-item"><a class="nav-link active" href="productos.jsp">Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🛠 CATÁLOGO DE PRODUCTOS -->
<main class="container my-5">
    <header class="text-center mb-5">
        <h1 class="fw-bold text-primary"><i class="fa-solid fa-store me-2"></i>Catálogo de Productos</h1>
        <p class="text-muted">Explora nuestros modelos 3D en tiempo real</p>
    </header>

    <div class="row g-4">
        <!-- Cada producto -->
        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/small-hammer-599.glb" alt="Martillo" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Martillo</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/screwdriver-591.glb" alt="Destornillador" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Destornillador</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/bucket.glb" alt="Cubo" camera-controls shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Cubo</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/minecraft_axe.glb" alt="Hacha" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Hacha</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/minecraft_shovel.glb" alt="Pala" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Pala</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/garden-rake-2047.glb" alt="Rastrillo" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Rastrillo de Jardín</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/minecraft_carrito.glb" alt="Carretilla" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Carretilla</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/minecraft_pickaxe.glb" alt="Pico" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Pico</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/toothed-spatula-618.glb" alt="Espátula Dentada" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Espátula Dentada</h6>
                </div>
            </div>
        </div>

        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card producto shadow-sm">
                <model-viewer src="model3D/door-920.glb" alt="Puerta de Madera" camera-controls
                              shadow-intensity="1"></model-viewer>
                <div class="card-body text-center">
                    <h6 class="card-title fw-bold">Puerta de Madera</h6>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 🧾 INFORMACIÓN -->
<aside class="bg-primary text-white text-center py-4">
    <div class="container">
        <h4><i class="fa-solid fa-truck-fast me-2"></i>Envíos y Garantías</h4>
        <p class="mb-1">🚚 Envío gratis en compras superiores a $100</p>
        <p>🛡 Garantía de satisfacción en todos nuestros productos</p>
    </div>
</aside>

<!-- ⚙️ FOOTER -->
<footer class="bg-dark text-white text-center py-3 mt-auto">
    <p>&copy; 2025 Ferretería Todo Posi - Todos los derechos reservados</p>
    <p>Teléfono: (123) 456-7890 | Email: info@sunshinedevcorp.com</p>
</footer>

<!-- BOOTSTRAP JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
