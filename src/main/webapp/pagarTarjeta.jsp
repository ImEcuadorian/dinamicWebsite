<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pagar con Tarjeta</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/9fccc9a50e.js" crossorigin="anonymous"></script>

    <style>
        body {
            background: linear-gradient(to right, #1d3557, #457b9d);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card-pago {
            background: #ffffff;
            border-radius: 15px;
            padding: 30px;
            max-width: 450px;
            width: 100%;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            animation: fadeIn .5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .input-group-text {
            background: #e9ecef;
            font-size: 1.3rem;
        }

        .btn-pagar {
            background: #1d3557;
            color: white;
            font-weight: bold;
            transition: .3s;
        }

        .btn-pagar:hover {
            background: #457b9d;
            transform: scale(1.02);
        }

        .tarjetas img {
            width: 55px;
            margin-right: 10px;
            opacity: .9;
        }

    </style>
</head>

<body>

<div class="card card-pago">

    <h3 class="text-center fw-bold text-primary mb-4">
        <i class="fa-solid fa-credit-card"></i> Pago con Tarjeta
    </h3>

    <!-- Iconos -->
    <div class="tarjetas text-center mb-4">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg">
        <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg">
        <img src="https://upload.wikimedia.org/wikipedia/commons/3/30/American_Express_logo.svg">
    </div>

    <!-- Mostrar error -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="alert alert-danger text-center">
        <%= error %>
    </div>
    <%
        }
    %>

    <form action="validarPagoTarjeta.jsp" method="post">

        <!-- Número -->
        <label class="fw-semibold">Número de tarjeta</label>
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-regular fa-credit-card"></i></span>
            <input type="text" maxlength="16" name="numero" class="form-control form-control-lg"
                   placeholder="•••• •••• •••• ••••" required>
        </div>

        <!-- Nombre -->
        <label class="fw-semibold">Nombre del titular</label>
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="nombre" class="form-control form-control-lg" placeholder="Ej: Juan Pérez" required>
        </div>

        <!-- Fecha -->
        <label class="fw-semibold">Fecha de expiración</label>
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-calendar"></i></span>
            <input type="text" name="fecha" class="form-control form-control-lg" placeholder="MM/YY" required>
        </div>

        <!-- CVV -->
        <label class="fw-semibold">CVV</label>
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" maxlength="4" name="cvv" class="form-control form-control-lg" placeholder="•••"
                   required>
        </div>

        <button class="btn btn-pagar w-100 mt-2 py-3">
            <i class="fa-solid fa-shield-halved"></i> Confirmar Pago Seguro
        </button>

    </form>

    <!-- Botón volver -->
    <div class="text-center mt-3">
        <a href="checkout.jsp" class="text-decoration-none fw-bold text-dark">
            <i class="fa-solid fa-arrow-left"></i> Volver al carrito
        </a>
    </div>

</div>

</body>
</html>
