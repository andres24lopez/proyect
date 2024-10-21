<%@page import="java.sql.*" %>
<%@page import="modelo.productos" %>
<%@page import="modelo.Marca" %>
<%@page import="modelo.Puesto" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Compras" %>
<%@page import="modelo.Proveedores" %>
<%@page import="modelo.Clientes_adm" %>
<%@page import="modelo.Cuenta" %>
<%@page import="modelo.Empleados_adm" %>
<%@page import="modelo.ComprasDetalle_adm" %>
<%@page import="modelo.VentasDetalle_adm" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Acceder a la sesión y obtener la información del usuario
    HttpSession userSession = request.getSession();
    Cuenta usuario = (Cuenta) userSession.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../../login.jsp"); 
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>ISOTEX</title>
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="icon" href="../../img/aaa.ico" type="image/x-icon">


    <!-- Estilos de la página -->
    <style>
        /* Tu estilo CSS existente aquí */
        body {
            background-image: url('../../img/7.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }

        .navbar {
            padding: 20px 10px;
            position: relative;
        }

        .navbar-brand img {
            width: 250px;
            height: auto;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 250px;
            background-color: rgba(52, 58, 64, 0.9);
            padding: 20px;
            z-index: 1000;
            display: none;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .sidebar h3 {
            color: white;
        }

        .sidebar .nav-link {
            color: #ffffff;
            font-weight: bold;
            margin: 5px 0;
        }

        .sidebar .nav-link:hover {
            background-color: #495057;
            color: #f8f9fa;
            border-radius: 10px;
        }

        .content {
            margin-left: 260px;
            padding: 20px;
        }

        h1 {
            font-weight: bold;
            color: white;
            font-size: 36px;
        }

        .table {
            background-color: white;
            color: black;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }

        .table th, .table td {
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }

        .menu-icon {
            font-size: 55px;
            color: white;
            cursor: pointer;
            position: fixed;
            z-index: 1100;
            top: 20px;
            left: 20px;
        }

        .navbar-brand img {
            width: 13%;
            height: auto;
            margin: 0 80px 40px;
        }

        h3 {
            color: white;
            font-size: 42px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }

        .center-button {
            display: block;
            margin: 0 auto;
            font-size: 30px;
            font-weight: bold;
            color: white;
            background-color: #17a2b8;
        }

        .modal-custom {
            max-width: 90%;
        }
        
        .usuario {
            color: white; /* Color del texto */
            margin: 0 20px; /* Margen superior e inferior a 0, margen derecho de 20px */
            white-space: nowrap; /* Mantiene el texto en una sola línea */
            font-size: 50px; /* Tamaño de la fuente grande */
            overflow: visible; /* Asegúrate de que el contenido no esté oculto */
            text-overflow: clip; /* Desactiva los puntos suspensivos */
        }

        .usuario:hover {
            color: #00FFFF; /* Cambia el color al pasar el mouse */
            transform: scale(1.05); /* Aumenta ligeramente el tamaño al pasar el mouse */
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.7); /* Añade un efecto de resplandor */
        }

        .usuario::after {
            content: '\2606';
            margin-left: 10px; /* Espacio entre el nombre y la flecha */
            font-size: 50px; /* Tamaño de la flecha */
            vertical-align: middle; /* Alinea verticalmente la flecha con el texto */
            color: white; /* Color de la flecha */
            transition: transform 0.3s ease; /* Efecto de transición */
        }

        .usuario:hover::after {
            transform: rotate(180deg); /* Rota la flecha al pasar el mouse */
        }

    </style>
    
    
</head>
<body>
    <header>
        <div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
            <div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
            <a class="navbar-brand">
                <img src="../../img/as.png" alt="Logo" style="width: 150px; height: auto;">
            </a>
            <!--<h1 style="color: white; margin: 0; font-size: 24px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 250px;">  Ajusta max-width según sea necesario -->
                <<div class="usuario"><%= usuario.getUsername() %></div>
        <!--    </h1>-->
        </div>


        <div class="sidebar">
            <nav class="nav flex-column">
                <br><br><br>
                <a class="nav-link active" href="cuentaempleado.jsp"><h2>Mi Cuenta</h2></a>
                <a class="nav-link active" href="inventario.jsp"><h2>Inventario</h2></a>
                <a class="nav-link active" href="ventas.jsp"><h2>Ventas</h2></a>
                <a class="nav-link active" href="compras.jsp"><h2>Compras</h2></a>
                <a class="nav-link active" href="proveedores.jsp"><h2>Proveedores</h2></a>
                <a class="nav-link active" href="clientes.jsp"><h2>Clientes</h2></a>
                <a class="nav-link active" href="empleados.jsp"><h2>Empleados</h2></a>
                <a class="nav-link active" href="marcas.jsp"><h2>Marcas</h2></a>
                <a class="nav-link active" href="puestos.jsp"><h2>Puestos</h2></a>
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" id="detalleDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <h2>Detalles</h2>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="detalleDropdown">
                        <li><a class="dropdown-item" href="comprasDetalle.jsp">Detalle de Compras</a></li>
                        <li><a class="dropdown-item" href="ventasDetalles.jsp">Detalle de Ventas</a></li>
                    </ul>
                </div>
                <a class="nav-link active" href="reportes.jsp"><h2>Reportes</h2></a>
                <a class="nav-link active" href="cerrar.jsp"><h2>Cerrar Sesion</h2></a>
            </nav>
        </div>
    </header>
