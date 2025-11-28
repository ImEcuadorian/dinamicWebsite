<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.productos.negocio.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");

    // Datos enviados desde el form
    String numero = request.getParameter("numero");
    String nombre = request.getParameter("nombre");
    String fecha = request.getParameter("fecha");
    String cvv = request.getParameter("cvv");

    // ====================== VALIDACIONES ===========================

    boolean valido = true;
    String error = "";

    // Validación: Número de tarjeta
    if (numero == null || !numero.matches("\\d{16}")) {
        valido = false;
        error = "Número de tarjeta inválido";
    }

    // Validar tipo de tarjeta (regex)
    String tipo = "";

    if (numero.matches("^4[0-9]{15}$")) tipo = "VISA";
    else if (numero.matches("^5[1-5][0-9]{14}$")) tipo = "MASTERCARD";
    else if (numero.matches("^3[47][0-9]{13}$")) tipo = "AMEX";  // 15 dígitos
    else {
        valido = false;
        error = "Tipo de tarjeta no reconocido";
    }

    // Validar nombre
    if (nombre == null || nombre.length() < 3) {
        valido = false;
        error = "Nombre del titular inválido";
    }

    // Validar fecha MM/YY
    if (fecha == null || !fecha.matches("(0[1-9]|1[0-2])\\/\\d{2}")) {
        valido = false;
        error = "Fecha inválida";
    }

    // Validar CVV
    if (cvv == null || !cvv.matches("\\d{3}")) {
        valido = false;
        error = "CVV inválido";
    }

    // ====================== SI FALLA REDIRIGE =======================

    if (!valido) {
        response.sendRedirect("pagarTarjeta.jsp?error=" + error);
        return;
    }

    // ====================== PROCESAR PAGO REAL =======================

    Orden orden = new Orden();
    int idOrden = orden.procesarPago(idUsuario);

    if (idOrden <= 0) {
        response.sendRedirect("carrito.jsp?msg=No+hay+productos+para+pagar");
        return;
    }

    // REDIRIGE A MENSAJE DE ÉXITO COMO EN EL FLUJO NORMAL
    response.sendRedirect("mensajePago.jsp?id_orden=" + idOrden);
%>
