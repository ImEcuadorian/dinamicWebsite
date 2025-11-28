<%@ page import="com.productos.negocio.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (Integer) sesion.getAttribute("id_us");
    int idServicio = Integer.parseInt(request.getParameter("id_serv"));

    Carrito c = new Carrito();
    String mensaje = c.agregarServicio(idUsuario, idServicio);
%>

<script>
    alert("<%= mensaje %>");
    window.location.href = "listServicios.jsp";
</script>
