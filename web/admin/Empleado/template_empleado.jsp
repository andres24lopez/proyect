<%@page import="java.sql.*" %>
<%@page import="modelo.productos" %> <!-- Asegúrate de que esta clase existe en este paquete -->
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
                padding: 10px 10px; /* Aumenta el padding de la navbar */
            }

            .navbar-brand img {
                width: 200px; /* Aumenta el tamaño de la imagen */
                height: auto; /* Mantiene la proporción de la imagen */
            }

            .nav-link {
                font-size: 1.5rem; /* Aumenta el tamaño de la fuente */
                padding: 10px 15px; /* Aumenta el padding */
            }

            .form-control {
                height: 50px; /* Aumenta la altura del campo de búsqueda */
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }



            .card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 120px;
                text-align: center;
            }
            h1 {
                font-weight: bold; /* Hacer el texto grueso */
                color: white; /* Color del texto */
                font-size: 36px; /* Cambia el tamaño de la fuente a 36px */
            }

        </style>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-night bg-night">
                <div class="container-fluid">
                    <a class="navbar-brand">
                        <img src="../../img/as.png">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="inventario.jsp">Inventario</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="ventas.jsp">Ventas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="compras.jsp">Compras</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="proveedor.jsp">Proveedores</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <br>
        </header>