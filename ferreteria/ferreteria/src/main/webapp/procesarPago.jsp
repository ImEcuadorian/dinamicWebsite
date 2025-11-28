<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>
    <%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");

    Orden orden = new Orden();
    int idOrden = orden.procesarPago(idUsuario);

    if (idOrden <= 0) {
        response.sendRedirect("carrito.jsp?msg=No+hay+productos+para+pagar");
        return;
    }

    response.sendRedirect("mensajePago.jsp?id_orden=" + idOrden);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>