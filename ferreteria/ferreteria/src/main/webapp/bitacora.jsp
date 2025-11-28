<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.productos.negocio.*" %>

<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("id_us") == null || (Integer)sesion.getAttribute("perfil") != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    String tabla = request.getParameter("tabla");
    if (tabla == null) tabla = "todos";

    String operacion = request.getParameter("operacion");
    if (operacion == null) operacion = "todos";

    String desde = request.getParameter("desde");
    String hasta = request.getParameter("hasta");

    BitacoraDAO dao = new BitacoraDAO();
    List<Bitacora> lista = dao.filtrar(tabla, operacion, desde, hasta);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bitácora del Sistema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .badge-insert { background-color: #198754; }
        .badge-update { background-color: #0d6efd; }
        .badge-delete { background-color: #dc3545; }
        tr:hover { background: #f1f3f5; }
    </style>
</head>

<body class="bg-light">

<div class="container mt-4">

    <h2 class="fw-bold text-primary mb-4">📘 Registro de Auditoría</h2>
	<div class="mb-3">
    <a href="menu.jsp" class="btn btn-secondary">
        ⬅ Volver al Menú
    </a>
	</div>
	
    <!-- Filtros -->
    <form class="card p-3 mb-4" method="GET">
        <div class="row g-3">

            <div class="col-md-3">
                <label class="form-label">Tabla</label>
                <select name="tabla" class="form-select">
                    <option value="todos">Todas</option>
                    <option value="tb_usuario">Usuarios</option>
                    <option value="tb_producto">Productos</option>
                    <option value="tb_carrito">Carrito</option>
                    <option value="tb_servicio">Servicios</option>
                    <option value="tb_orden">Órdenes</option>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label">Operación</label>
                <select name="operacion" class="form-select">
                    <option value="todos">Todas</option>
                    <option value="INSERT">INSERT</option>
                    <option value="UPDATE">UPDATE</option>
                    <option value="DELETE">DELETE</option>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label">Desde</label>
                <input type="date" name="desde" class="form-control" value="<%= desde %>">
            </div>

            <div class="col-md-3">
                <label class="form-label">Hasta</label>
                <input type="date" name="hasta" class="form-control" value="<%= hasta %>">
            </div>

        </div>

        <div class="text-end mt-3">
            <button class="btn btn-primary">Aplicar filtros</button>
        </div>
    </form>

    <!-- Buscador global -->
    <div class="mb-3">
        <input type="text" id="buscador" class="form-control" placeholder="🔍 Buscar en toda la tabla...">
    </div>

    <!-- Tabla -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped align-middle" id="tablaAuditoria">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tabla</th>
                    <th>Operación</th>
                    <th>Valor Anterior</th>
                    <th>Valor Nuevo</th>
                    <th>Fecha</th>
                    <th>Usuario</th>
                    <th>Esquema</th>
                </tr>
            </thead>
            <tbody>
                <% for (Bitacora b : lista) { %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getTabla() %></td>

                    <td>
                        <% String op = b.getOperacion(); %>
                        <% if(op.equals("INSERT")) { %>
                            <span class="badge badge-insert">INSERT</span>
                        <% } else if(op.equals("UPDATE")) { %>
                            <span class="badge badge-update">UPDATE</span>
                        <% } else { %>
                            <span class="badge badge-delete">DELETE</span>
                        <% } %>
                    </td>

                    <td><pre><%= b.getValorAnterior() %></pre></td>
                    <td><pre><%= b.getValorNuevo() %></pre></td>
                    <td><%= b.getFecha() %></td>
                    <td><%= b.getUsuario() %></td>
                    <td><%= b.getEsquema() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

<script>
document.getElementById("buscador").addEventListener("keyup", function () {
    let filtro = this.value.toLowerCase();
    let filas = document.querySelectorAll("#tablaAuditoria tbody tr");

    filas.forEach(fila => {
        let texto = fila.textContent.toLowerCase();
        fila.style.display = texto.includes(filtro) ? "" : "none";
    });
});
</script>

</body>
</html>
