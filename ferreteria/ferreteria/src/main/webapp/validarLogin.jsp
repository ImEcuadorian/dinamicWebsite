<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true" import="com.productos.seguridad.*" %>

<%
Usuario usuario = new Usuario();

String nlogin = request.getParameter("usuario");
String nclave = request.getParameter("clave");

System.out.println("Intentando login: " + nlogin + " / " + nclave);

HttpSession sesion = request.getSession(); // Se crea la sesión
boolean respuesta = usuario.verificarUsuario(nlogin, nclave);

System.out.println("Respuesta del método verificarUsuario: " + respuesta);

if (respuesta) {
    sesion.setAttribute("usuario", usuario.getNombre());
    sesion.setAttribute("perfil", usuario.getPerfil());
    sesion.setAttribute("id_us", usuario.getId()); 
    response.sendRedirect("menu.jsp");
    System.out.println("ID guardado en sesión = " + usuario.getId());

} else {
    response.sendRedirect("login.jsp?error=Datos+incorrectos.+Vuelva+a+intentarlo.");
}

%>
