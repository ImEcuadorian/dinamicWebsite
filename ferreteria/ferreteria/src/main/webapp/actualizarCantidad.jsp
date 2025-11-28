<%@ page import="com.productos.negocio.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idCar = Integer.parseInt(request.getParameter("id_car"));
    String accion = request.getParameter("accion");

    Carrito car = new Carrito();
    String msg = "";

    if ("sumar".equals(accion)) {
        msg = car.aumentarCantidad(idCar);
    } else if ("restar".equals(accion)) {
        msg = car.disminuirCantidad(idCar);
    }

    response.sendRedirect("carrito.jsp?msg=" + msg);
%>
