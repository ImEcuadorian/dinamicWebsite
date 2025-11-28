<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registro de Empleado / Administrador</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    String nombre = request.getParameter("txtNombre");
    String cedula = request.getParameter("txtCedula");
    String correo = request.getParameter("txtCorreo");
    String clave = request.getParameter("txtClave");
    int perfil = Integer.parseInt(request.getParameter("cmbPerfil")); // 1 = Admin, 3 = Vendedor

    Usuario user = new Usuario();
    user.setNombre(nombre);
    user.setCedula(cedula);
    user.setCorreo(correo);
    user.setClave(clave);
    user.setPerfil(perfil);

    String resultado = user.ingresarEmpleado();
%>

<div class="container mt-5 text-center">
  <% if (resultado.contains("exitoso")) { %>
    <div class="alert alert-success">
       <%= resultado %> — Redirigiendo a lista de usuarios...
    </div>
    <script>
      setTimeout(function() {
        window.location.href = "usuarios.jsp";
      }, 2500);
    </script>
  <% } else { %>
    <div class="alert alert-danger">
       <%= resultado %>
    </div>
  <% } %>
</div>

</body>
</html>
