<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*"%>
<html>
<head>
    <title>Nuevo Cliente</title>
</head>
<body>
    <h2>Datos del Cliente Recibidos</h2>
    <p>
    <%
        // Capturamos los parámetros correctamente
        String nombre = request.getParameter("txtNombre");
        String cedula = request.getParameter("txtCedula");
        //
        String estadoParam = request.getParameter("cmbEstado");
		int estadoCivil = 0;
		if (estadoParam != null && !estadoParam.isEmpty()) {
		    try {
		        estadoCivil = Integer.parseInt(estadoParam);
		    } catch (NumberFormatException e) {
		        estadoCivil = 0; // Valor por defecto
		    }
		}
        //int estadoCivil = Integer.parseInt(request.getParameter("cmbEstado"));
        String residencia = request.getParameter("rdResidencia");
        String foto = request.getParameter("fileFoto");
        String fecha = request.getParameter("mFecha");
        String color = request.getParameter("cColor");
        String correo = request.getParameter("txtCorreo");
        String clave = request.getParameter("txtClave");
		
        //Los datos los recibira del formulario y la clase Usuario 
        //se intancia para insertar en la BD
         Usuario user = new Usuario();
	    user.setNombre(nombre);
	    user.setCedula(cedula);
	    user.setEstado(estadoCivil);
	    user.setCorreo(correo);
	    user.setClave(clave);
       
	    String resultado = user.ingresarCliente();
	    //verificacion de ingreso
	    
	    if (resultado.contains("correcta")) {
			%>
			  <div class="alert alert-success text-center mt-4" role="alert">
			    Usuario creado correctamente. Serás redirigido al login en 3 segundos...
			  </div>
			  <script>
			    setTimeout(function() {
			      window.location.href = "login.jsp";
			    }, 1000);
			  </script>
			<%
			} else {
			%>
			  <div class="alert alert-danger text-center mt-4" role="alert">
			     Ocurrió un error al registrar el usuario: <%= resultado %>
			  </div>
			<%
			}
	    
	    
        // Mostramos los datos en pantalla
    %>
    
    
    Nombre: <strong><%= nombre %></strong><br>
    Cédula: <%= cedula %><br>
    Estado Civil: <%= estadoCivil %><br>
    Residencia: <%= residencia %><br>
    Archivo Foto: <%= foto %><br>
    Fecha de nacimiento: <%= fecha %><br>
    Correo: <%= correo %><br>
    <font color="<%= color %>">Este es tu color favorito</font>

    </p>
</body>
</html>
