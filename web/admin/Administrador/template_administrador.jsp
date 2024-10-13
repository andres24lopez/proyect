<%@page import="java.sql.*" %>
<%@page import="modelo.productos" %>
<%@page import="modelo.Marca" %>
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
        body {
            background-image: url('../../img/7.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed; /* Mantiene el fondo fijo */
            height: 100%; /* Asegura que el cuerpo tenga un 100% de altura */
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0; /* Elimina el margen por defecto */
        }

        .navbar {
            padding: 20px 10px;
            position: relative;
        }

        .navbar-brand img {
            width: 250px; /* Ajustar tamaño del logo */
            height: auto;
        }

        /* Sidebar */
        .sidebar {
            position: fixed; /* Mantiene la barra lateral fija */
            top: 0;
            left: 0;
            height: 100%; /* Altura completa */
            width: 250px; /* Ancho de la barra lateral */
            background-color: rgba(52, 58, 64, 0.9); /* Gris oscuro casi transparente */
            padding: 20px;
            z-index: 1000; /* Asegura que esté por encima de otros elementos */
            display: none; /* Ocultar por defecto */
            overflow-y: auto; /* Habilita el scroll vertical */
            overflow-x: hidden; /* Oculta el scroll horizontal para evitar desplazamiento lateral */
        }

        .sidebar h3 {
            color: white; /* Color del título de la barra lateral */
        }

        .sidebar .nav-link {
            color: #ffffff; /* Color de los enlaces */
            font-weight: bold;
            margin: 5px 0; /* Espaciado entre enlaces */
        }

        .sidebar .nav-link:hover {
            background-color: #495057; /* Color de fondo en hover */
            color: #f8f9fa; /* Color del texto en hover */
            border-radius: 10px;
        }

        /* Contenido principal */
        .content {
            margin-left: 260px; /* Deja espacio para la barra lateral */
            padding: 20px;
        }

        h1 {
            font-weight: bold;
            color: white;
            font-size: 36px;
        }

        .table {
            background-color: white; /* Cambia el fondo de la tabla a blanco */
            color: black; /* Cambia el texto de la tabla a negro para que sea legible */
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9; /* Color de fondo para filas impares (opcional) */
        }

        .table th, .table td {
            vertical-align: middle; /* Alineación vertical de las celdas */
            border: 1px solid #dee2e6; /* Color de borde de las celdas */
        }

        /* Icono del menú */
        .menu-icon {
            font-size: 55px; /* Tamaño del icono de menú */
            color: white; /* Color del icono */
            cursor: pointer; /* Cambia el cursor al pasar por encima */
            position: fixed; /* Fija el icono en la esquina superior izquierda */
            z-index: 1100; /* Asegura que esté por encima del sidebar */
            top: 20px; /* Espacio desde la parte superior */
            left: 20px; /* Espacio desde la izquierda */
        }
        
        .navbar-brand img {
            width: 13%; /* Ajustar el tamaño de la imagen */
            height: auto; /* Mantener la proporción de la imagen */
            margin: 0 80px 40px; /* Margen superior e inferior, margen izquierdo y derecho */
        }
        
        h3 {
            color: white; /* Cambia el color del texto */
            font-size: 42px; /* Cambia el tamaño de la fuente */
            font-weight: bold; /* Cambia el grosor de la fuente */
            text-align: center; /* Centra el texto (opcional) */
            margin: 10px 0; /* Margen superior e inferior (opcional) */
        }
        
        .center-button {
            display: block; /* Hace que el botón sea un bloque */
            margin: 0 auto; /* Margen automático para centrar horizontalmente */
            font-size: 30px; /* Tamaño de la letra */
            font-weight: bold; /* Grosor de la letra */
            color: white; /* Color de la letra */
            background-color: #17a2b8; /* Color de fondo (el mismo que btn-info) */
        }
    </style>
</head>
<body>
    <header>
        <div class="menu-icon" onclick="toggleMenu()">&#9776;</div> <!-- Icono del menú -->
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

 
