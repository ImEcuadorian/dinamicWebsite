<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="true" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion != null) {
        sesion.invalidate(); // destruir la sesión
    }
    //response.sendRedirect("login.jsp?error=Sesión cerrada correctamente.");//solucion clean en lugar de forward
%>

<jsp:forward page="login.jsp">
    <jsp:param name="error" value="Sesión cerrada correctamente."/>
</jsp:forward>