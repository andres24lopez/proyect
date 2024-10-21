<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="modelo.productos" %>





<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-image: url('img/7.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }

        .navbar {
            padding: 10px 10px;
        }

        .navbar-brand img {
            width: 200px;
            height: auto;
        }

        .nav-link {
            font-size: 1.8rem;
            padding: 10px 15px;
        }

        .form-control {
            height: 50px;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px;
        }

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 120px;
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-night bg-night">
        <div class="container-fluid">
            <a class="navbar-brand" href="login.jsp">
                <img src="img/as.png">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button> 
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Catálogo</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#">Empleados</a></li>
                            <li><a class="dropdown-item" href="#">Clientes</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Puestos</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#.jsp"><img src="img/10.png">Compras</a>
                    </li>
                </ul>
                <button type="button" class="btn btn-link nav-link" data-bs-toggle="modal" data-bs-target="#loginModal">Iniciar Sesión</button>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">BUSCAR</button>
                </form>
            </div>
        </div>
    </nav>

    <br>

    <div class="card-container">
        <% 
            productos producto = new productos();  
            DefaultTableModel tabla = producto.leer(); 
            for (int t = 0; t < tabla.getRowCount(); t++) {
                String idProducto = tabla.getValueAt(t, 0).toString();
                String nombreProducto = tabla.getValueAt(t, 1).toString();
                String marcaProducto = tabla.getValueAt(t, 2).toString();
                String descripcionProducto = tabla.getValueAt(t, 3).toString();
                String imagenProducto = tabla.getValueAt(t, 4).toString();
                String precioVentaProducto = tabla.getValueAt(t, 6).toString();
        %>
        <div class="card">
            
            <img src="<%= request.getContextPath() + "/admin/img_producto/" + imagenProducto %>" alt="<%= nombreProducto %>">

            <h3><%= nombreProducto %></h3>
            <p><strong>Marca:</strong> <%= marcaProducto %></p>
            <p><%= descripcionProducto %></p>
            <p><strong>Precio: </strong>$<%= precioVentaProducto %></p>
        </div>
        <% } %>
    </div>

    <!-- Modal de Iniciar Sesión -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Iniciar Sesión</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="loginServlet" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                    </form>
                    <p class="mt-3">¿No tienes una cuenta? <a href="#" data-bs-toggle="modal" data-bs-target="#registerModal">Regístrate aquí</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Registro -->
    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Registro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="registerServlet" method="POST">
                        <div class="mb-3">
                            <label for="newUsername" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="newUsername" name="newUsername" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Correo Electrónico</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Registrarse</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXlG7g6F+cC2pCJAckK+FR+A7nFdhcf7IOOeG2iC6dq5D1CFXz8bAT/NF7A4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGPrJ7UlqpeoP4n2R+pErf02zZ9WpgFZONpqhNfBvzzUK/d2G5c5PpVVvBy" crossorigin="anonymous"></script>
</body>
</html>

