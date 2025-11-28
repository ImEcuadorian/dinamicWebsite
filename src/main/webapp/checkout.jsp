<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.productos.negocio.*, java.util.*" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");

    Checkout chk = new Checkout();
    List<CheckoutItem> lista = chk.obtenerItems(idUsuario);

    double total = chk.calcularTotal(lista);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center text-primary">Resumen de compra</h2>

    <table class="table table-bordered table-striped mt-4">
        <thead class="table-dark">
        <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
        </tr>
        </thead>
        <tbody>
        <% for (CheckoutItem item : lista) { %>
        <tr>
            <td>
                <%= item.getNombre() %>
                <% if (item.isServicio()) { %>
                <span class="badge bg-info">Servicio</span>
                <% } %>
            </td>

            <td><%= item.getCantidad() %>
            </td>
            <td>$<%= String.format("%.2f", item.getSubtotal()) %>
            </td>
        </tr>
        <% } %>
        </tbody>
        <tfoot>
        <tr class="table-success fw-bold">
            <td colspan="2" class="text-end">TOTAL:</td>
            <td>$<%= String.format("%.2f", total) %>
            </td>
        </tr>
        </tfoot>
    </table>

    <div class="text-center mt-3">
        <a href="carrito.jsp" class="btn btn-secondary">Volver al carrito</a>
        <a href="pagarTarjeta.jsp" class="btn btn-success">Pagar ahora</a>
    </div>

</div>

</body>
</html>
