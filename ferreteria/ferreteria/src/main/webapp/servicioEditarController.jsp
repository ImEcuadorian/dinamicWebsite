<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>

<%
    Servicio s = new Servicio();
    s.setId(Integer.parseInt(request.getParameter("id")));
    s.setNombre(request.getParameter("nombre"));
    s.setDescripcion(request.getParameter("descripcion"));
    s.setPrecio(Double.parseDouble(request.getParameter("precio")));
    s.setActivo(Boolean.parseBoolean(request.getParameter("activo")));

    ServicioDAO dao = new ServicioDAO();

    if (dao.actualizar(s)) {
        response.sendRedirect("adminServicios.jsp?msg=edit_ok");
    } else {
        response.sendRedirect("adminServicios.jsp?msg=edit_err");
    }
%>