<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    ServicioDAO dao = new ServicioDAO();
    Servicio s = dao.obtener(id);

    s.setActivo(false);

    if (dao.actualizar(s)) {
        response.sendRedirect("adminServicios.jsp?msg=del_ok");
    } else {
        response.sendRedirect("adminServicios.jsp?msg=del_err");
    }
%>