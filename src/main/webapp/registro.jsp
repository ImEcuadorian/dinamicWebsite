<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Ferretería Todo Posi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/registro.css" rel="stylesheet" type="text/css">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <script>

        // ================== VALIDACIÓN DE CÉDULA ECUATORIANA ==================
        function validarCedulaEcuatoriana(cedula) {
            if (!/^\d{10}$/.test(cedula)) return false;

            let provincia = parseInt(cedula.substring(0, 2));
            if (provincia < 1 || provincia > 24) return false;

            let digitoVerificador = parseInt(cedula[9]);
            let suma = 0;

            for (let i = 0; i < 9; i++) {
                let num = parseInt(cedula[i]);

                // posiciones pares (0,2,4...)
                if (i % 2 === 0) {
                    num = num * 2;
                    if (num > 9) num -= 9;
                }

                suma += num;
            }

            let decenaSuperior = Math.ceil(suma / 10) * 10;
            let digitoCalculado = decenaSuperior - suma;

            if (digitoCalculado === 10) digitoCalculado = 0;

            return digitoCalculado === digitoVerificador;
        }

        // ================== VALIDACIÓN FECHA (≥ 18 años) ==================
        function validarFechaNacimiento(fecha) {
            let fechaIngresada = new Date(fecha);
            let hoy = new Date();
            let fechaMin = new Date("1900-01-01");

            if (fechaIngresada > hoy) return false;
            if (fechaIngresada < fechaMin) return false;

            // Calcular edad exacta
            let edad = hoy.getFullYear() - fechaIngresada.getFullYear();
            let m = hoy.getMonth() - fechaIngresada.getMonth();
            if (m < 0 || (m === 0 && hoy.getDate() < fechaIngresada.getDate())) {
                edad--;
            }

            return edad >= 18;
        }

        // ================== VALIDACIÓN FINAL DEL FORMULARIO ==================
        function validarFormulario() {
            let cedula = document.getElementById("cedula").value.trim();
            let fecha = document.getElementById("fecha").value;

            // Validar cédula ecuatoriana
            if (!validarCedulaEcuatoriana(cedula)) {
                alert("La cédula ingresada NO es válida.");
                return false;
            }

            // Validar fecha nacimiento (mayor de 18)
            if (!validarFechaNacimiento(fecha)) {
                alert("Debe ser mayor de 18 años y la fecha no debe ser futura.");
                return false;
            }

            return true;
        }

        // Limitar fecha máxima al día de hoy
        window.onload = () => {
            document.getElementById("fecha").max = new Date().toISOString().split("T")[0];
        };

    </script>


</head>
<body class="bg-light">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fa-solid fa-screwdriver-wrench me-2"></i>Ferretería Todo Posi
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="servicios.jsp">Servicios</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fa-solid fa-user"></i> Iniciar
                    Sesión</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- CONTENEDOR PRINCIPAL -->
<main class="container mt-5 mb-5">
    <div class="card shadow-lg mx-auto" style="max-width: 700px;">
        <div class="card-header bg-primary text-white text-center">
            <h4>Registro de Cliente</h4>
        </div>
        <div class="card-body">

            <form action="nuevoCliente.jsp" method="post" id="formCliente" onsubmit="return validarFormulario();">

                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label">Nombre completo</label>
                        <input type="text" class="form-control" name="txtNombre" required>
                    </div>

                    <div class="col">
                        <label class="form-label">Cédula</label>
                        <input type="text" class="form-control" id="cedula"
                               name="txtCedula" maxlength="10"
                               pattern="^[0-9]{10}$"
                               title="Debe tener exactamente 10 dígitos numéricos"
                               required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label">Estado Civil</label>
                        <select class="form-select" name="cmbEstado" required>
                            <option value="">Selecciona una opción</option>
                            <option value="1">Casado</option>
                            <option value="2">Soltero</option>
                            <option value="3">Divorciado</option>
                            <option value="4">Amigos</option>
                            <option value="5">Viudo</option>
                        </select>
                    </div>

                    <div class="col">
                        <label class="form-label">Lugar de Residencia</label><br>
                        <label><input type="radio" name="rdResidencia" value="Sur" required> Sur</label>
                        <label class="ms-3"><input type="radio" name="rdResidencia" value="Norte"> Norte</label>
                        <label class="ms-3"><input type="radio" name="rdResidencia" value="Centro"> Centro</label>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label">Fecha de nacimiento</label>
                        <input type="date" class="form-control" id="fecha"
                               name="mFecha"
                               min="1900-01-01"
                               required>
                    </div>

                    <div class="col">
                        <label class="form-label">Color Favorito</label>
                        <input type="color" class="form-control form-control-color" name="cColor" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Correo electrónico</label>
                    <input type="email" class="form-control" name="txtCorreo" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <input type="password" class="form-control" name="txtClave" required>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">
                        <i class="fa-solid fa-check"></i> Registrar
                    </button>
                    <button type="reset" class="btn btn-secondary px-4">
                        <i class="fa-solid fa-eraser"></i> Limpiar
                    </button>
                </div>

            </form>
        </div>
    </div>
</main>

<footer class="bg-dark text-white text-center py-3 mt-auto">
    <small>&copy; 2025 Ferretería Todo Posi | Todos los derechos reservados</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
