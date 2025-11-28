<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.productos.negocio.*" %>

<%
    Servicio s = new Servicio();
    s.setNombre(request.getParameter("nombre"));
    s.setDescripcion(request.getParameter("descripcion"));
    s.setPrecio(Double.parseDouble(request.getParameter("precio")));

    ServicioDAO dao = new ServicioDAO();

    if (dao.agregar(s)) {
        response.sendRedirect("adminServicios.jsp?msg=ok");
    } else {
        response.sendRedirect("adminServicios.jsp?msg=err");
    }
%>
