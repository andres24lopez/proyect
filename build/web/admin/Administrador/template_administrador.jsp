<%@page import="java.sql.*" %>
<%@page import="modelo.productos" %>
<%@page import="modelo.Marca" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Compras" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <title>Página con Encabezado</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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

        /* Sidebar */
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

        /* Contenido principal */
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

        /* Icono del menú */
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
    </style>
    <script>
        let timeout; // Variable para rastrear el tiempo de inactividad
        const timeoutDuration = 600000; // 10 minutos en milisegundos

        // Función para redirigir al usuario a la página de inicio de sesión
        function redirectToLogin() {
            alert("Has estado inactivo durante 10 minutos. Se cerrará la sesión.");
            window.location.href = "../../login.jsp"; // Cambia esto por la ruta de tu página de login
        }

        // Función para restablecer el temporizador de inactividad
        function resetTimeout() {
            clearTimeout(timeout);
            timeout = setTimeout(redirectToLogin, timeoutDuration);
        }

        // Escucha eventos de actividad del usuario
        window.onload = resetTimeout; // Restablece el temporizador al cargar la página
        document.onmousemove = resetTimeout;
        document.onkeypress = resetTimeout;
        document.onclick = resetTimeout;
    </script>
</head>
<body>
    <header>
        <div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
        <a class="navbar-brand">
            <img src="../../img/as.png">
        </a>
        <div class="sidebar">
            <nav class="nav flex-column">
                <br><br><br>
                <a class="nav-link active" href="cuenta.jsp"><h2>Mi Cuenta</h2></a>
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
                        <li><a class="dropdown-item" href="ventasDetalle.jsp">Detalle de Ventas</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" id="detalleDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <h2>Usuarios</h2>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="detalleDropdown">
                        <li><a class="dropdown-item" href="usuarios_clientes.jsp">Usuario Cliente</a></li>
                        <li><a class="dropdown-item" href="usuarios_empleados.jsp">Usuario Empleado</a></li>
                    </ul>
                </div>
                <a class="nav-link active" href="reportes.jsp"><h2>Reportes</h2></a>
            </nav>
        </div>
    </header>

