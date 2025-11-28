<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Servicios - Ferretería Todo Posi</title>

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
          <li class="nav-item"><a class="nav-link active" href="servicios.jsp">Servicios</a></li>
          <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- SECCIÓN DE SERVICIOS -->
  <main class="container text-center my-5">
    <h1 class="fw-bold text-primary mb-4">
      <i class="fa-solid fa-toolbox me-2"></i>Nuestros Servicios
    </h1>
    <p class="text-muted mb-5">
      En Ferretería Todo Posi te ofrecemos más que herramientas: te brindamos soluciones.
    </p>

    <div class="row g-4">
      <div class="col-md-4">
        <div class="card shadow-sm h-100 border-0">
          <div class="card-body">
            <i class="fa-solid fa-hammer fa-3x text-primary mb-3"></i>
            <h5 class="fw-bold">Asesoría Técnica</h5>
            <p>Instalación sin complicaciones.Listo para usar, sin estrés.</p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card shadow-sm h-100 border-0">
          <div class="card-body">
            <i class="fa-solid fa-truck fa-3x text-success mb-3"></i>
            <h5 class="fw-bold">Corte de Materiales</h5>
            <p>Madera, metal o plástico. Tú eliges, nosotros cortamos.</p>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="card shadow-sm h-100 border-0">
          <div class="card-body">
            <i class="fa-solid fa-screwdriver-wrench fa-3x text-danger mb-3"></i>
            <h5 class="fw-bold">Mantenimiento y Reparación</h5>
            <p>Ofrecemos servicio técnico especializado para tus herramientas eléctricas.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- MODELO 3D -->
    <div class="mt-5">
        <model-viewer id="model-viewer" src="model3D/mike-1167.glb" ar ar-modes="scene-viewer quick-look" camera-controls touch-action="pan-y" alt="el mike" shadow-intensity="2" auto-rotate disable-pan skybox-image="model3D/workshop_4k.hdr" skybox-height="2m" max-camera-orbit="auto 90deg auto">
  <div id="error" class="hide">AR is not supported on this device</div>
</model-viewer>
<script>
  document.querySelector("#model-viewer").addEventListener('ar-status', (event) => {
    if(event.detail.status === 'failed'){
      const error = document.querySelector("#error");
      error.classList.remove('hide');
      error.addEventListener('transitionend',(event) => {
        error.classList.add('hide');
      });
    }
  });
</script>
<style>
  #error {
    background-color: #ffffffdd;
    border-radius: 16px;
    padding: 16px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate3d(-50%, -50%, 0);
    transition: opacity 0.3s;
  }
  #error.hide {
    opacity: 0;
    visibility: hidden;
    transition: visibility 2s, opacity 1s 1s;
  }
</style>
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
