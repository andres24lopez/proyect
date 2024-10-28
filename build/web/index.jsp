<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="modelo.productos" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@ page import="modelo.Cuenta" %>

<%
    // Recuperar el usuario de la sesión
    Cuenta usuario1 = (Cuenta) session.getAttribute("usuario");
    
%>

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
            background-attachment: fixed;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0;
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
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se envuelvan en múltiples líneas */
            gap: 30px; /* Espacio entre las tarjetas */
            justify-content: center; /* Centra las tarjetas horizontalmente */
            align-items: center; /* Centra las tarjetas verticalmente (opcional) */
            padding: 20px; /* Espacio alrededor del contenedor */
        }

        .card {
            background-color: rgba(211, 211, 240, 0.8); /* Gris claro */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px; /* Ancho fijo para las tarjetas */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Distribuir el contenido */
        }

        .card img {
            width: 100%;
            height: 200px; /* Altura fija */
            object-fit: cover; /* Ajuste de imagen */
            border-radius: 8px; /* Bordes redondeados */
        }

        .button-group {
            display: flex; /* Usar flexbox para los botones */
            flex-direction: column; /* Apilar botones verticalmente */
            margin-top: 10px; /* Espacio entre el contenido y los botones */
        }

        .button-group .btn {
            width: 100%; /* Los botones ocupan todo el ancho */
            margin: 5px 0; /* Espacio entre botones */
        }
        
        .welcome-text {
            color: white; /* Cambia el color del texto (en este caso, un azul) */
            font-size: 1.7rem; /* Cambia el tamaño de la fuente (puedes usar px, em, rem, etc.) */
            font-weight: bold; /* Cambia el grosor del texto (opcional) */
            margin: 0 15px;
        }
        
        .btn-long {
            display: inline-block;
            font-size: 1.5rem; /* Tamaño de texto grande */
            padding: 10px 30px; /* Espacio interno del botón */
            width: 100%; /* Hacer que el botón ocupe todo el ancho posible */
            max-width: 300px; /* Limitar el ancho máximo */
            text-align: center;
            background-color: #14f4f1; /* Color de fondo verde */
            color: black; /* Texto blanco */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            transition: background-color 0.3s ease; /* Efecto suave al cambiar el color */
        }

        .btn-long:hover {
            background-color: #40b6b4; /* Cambiar el color al pasar el mouse */
        }

        .btn-long:active {
            background-color: #91e0df; /* Cambiar el color al hacer clic */
        }

        .btn-long:focus {
            outline: none; /* Remover contorno de enfoque */
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.5); /* Sombra al hacer foco */
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
                           
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#.jsp"><img src="img/10.png">Compras</a>
                    </li>
                </ul>
                <form class="d-flex" action="buscarProductos.jsp" >
                    
                    <!-- Botón para Iniciar Sesión -->
                    <button type="button" class="btn btn-outline-success btn-long" data-bs-toggle="modal" data-bs-target="#loginModal" 
                            <%= (usuario1 != null) ? "style='display:none;'" : "" %>>
                        Iniciar Sesión
                    </button>

                    <!-- Mostrar el nombre del usuario si está logueado y agregar un enlace para cerrar sesión -->
                    <% if (usuario1 != null) { %>
                        <span class="welcome-text">
                            <a href="CerrarSesion.jsp" style="color:inherit; text-decoration:none;"><%= usuario1.getUsername() %></a>
                        </span>
                    <% } %>
                    
                    <input class="form-control me-2" type="search" name="nombreProducto" placeholder="Buscar por nombre" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">BUSCAR</button>
                </form>
            </div>
        </div>
    </nav>

    <br>

   <div class="card-container">
        <% 
            productos producto = new productos();  
            DefaultTableModel tabla1 = producto.leerPro(); 
            for (int t = 0; t < tabla1.getRowCount(); t++) {
                String idProducto = tabla1.getValueAt(t, 0).toString();
                String nombreProducto = tabla1.getValueAt(t, 1).toString();
                String marcaProducto = tabla1.getValueAt(t, 2).toString();
                String descripcionProducto = tabla1.getValueAt(t, 3).toString();
                String imagenProducto = tabla1.getValueAt(t, 4).toString();
                String precioVentaProducto = tabla1.getValueAt(t, 6).toString();
        %>
        <div class="card">
            <img src="<%= request.getContextPath() + "/admin/img_producto/" + imagenProducto %>" alt="<%= nombreProducto %>">
            <div class="card-content">
                <h3><%= nombreProducto %></h3>
                <p><strong>Marca:</strong> <%= marcaProducto %></p>
                <p><%= descripcionProducto %></p>
                <p><strong>Precio: </strong>$<%= precioVentaProducto %></p>
            </div>
            <div class="button-group"> <!-- Agrupar botones dentro de un contenedor -->
                <button class="btn btn-primary" onclick="comprarProducto('<%= idProducto %>')">Comprar</button>
                <button class="btn btn-secondary" onclick="anadirAFavoritos('<%= idProducto %>')">Añadir a Favoritos</button>
                <button class="btn btn-info" onclick="mostrarInformacion('<%= idProducto %>')">Más Información</button>
            </div>
        </div>
    <% } %>
</div>



<!-- Modal de Iniciar Sesión -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Iniciar Sesión</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Removemos el action del formulario -->
                <form id="loginForm" method="post">
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
                <h5 class="modal-title">Registro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="registerForm">
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXlG7g6F+cC2pCJAckK+FR+A7nFdhcf7IOOeG2iC6dq5D1CFXz8bAT/NF7A4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGPrJ7UlqpeoP4n2R+pErf02zZ9WpgFZONpqhNfBvzzUK/d2G5c5PpVVvBy" crossorigin="anonymous"></script>
<script>
    function comprarProducto(id) {
        // Lógica para comprar el producto
        alert("Comprar producto con ID: " + id);
    }

    function anadirAFavoritos(id) {
        // Lógica para añadir el producto a favoritos
        alert("Añadir a favoritos el producto con ID: " + id);
    }

    function mostrarInformacion(id) {
        // Lógica para mostrar más información sobre el producto
        alert("Mostrar información del producto con ID: " + id);
    }
    
</script>
<script>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb", "root", "danigero");

                String sql = "SELECT id, password, attempts, lock_time, mec, idCliente FROM users WHERE username = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    int attempts = rs.getInt("attempts");
                    Timestamp lockTime = rs.getTimestamp("lock_time");
                    String role = rs.getString("mec");
                    int idEmpleado = rs.getInt("idCliente");

                    long currentTimeMillis = System.currentTimeMillis();
                    boolean locked = false;

                    if (lockTime != null && (currentTimeMillis - lockTime.getTime()) < 300000) {
                        out.println("<p style='color:red;'>Tienes varios intentos fallidos. Por favor espera 5 minutos.</p>");
                        locked = true;
                    }

                    if (!locked) {
                        if (password.equals(dbPassword)) {
                            // Crear objeto Cuenta y almacenar en la sesión
                            Cuenta usuario = new Cuenta(rs.getInt("id"), username, dbPassword);
                            session.setAttribute("usuario", usuario);  // Guardar el objeto Cuenta en la sesión

                            
                            response.sendRedirect("index.jsp");   
                            

                            // Resetear intentos
                            String resetAttemptsSql = "UPDATE users SET attempts = 0, lock_time = NULL WHERE username = ?";
                            PreparedStatement resetStmt = conn.prepareStatement(resetAttemptsSql);
                            resetStmt.setString(1, username);
                            resetStmt.executeUpdate();
                            resetStmt.close();
                            } else {
                                attempts++;
                                if (attempts >= 3) {
                                    String lockSql = "UPDATE users SET lock_time = NOW() WHERE username = ?";
                                    PreparedStatement lockStmt = conn.prepareStatement(lockSql);
                                    lockStmt.setString(1, username);
                                    lockStmt.executeUpdate();
                                    lockStmt.close();
                                    out.println("<p style='color:red;'>Demasiados intentos fallidos. Cuenta bloqueada por 5 minutos.</p>");
                                } else {
                                    String updateAttemptsSql = "UPDATE users SET attempts = ? WHERE username = ?";
                                    PreparedStatement updateStmt = conn.prepareStatement(updateAttemptsSql);
                                    updateStmt.setInt(1, attempts);
                                    updateStmt.setString(2, username);
                                    updateStmt.executeUpdate();
                                    updateStmt.close();
                                    out.println("<p style='color:red;'>Credenciales inválidas. Intento " + attempts + " de 3.</p>");
                                }
                            }
                        }
            } else {
                out.println("<p style='color:red;'>Usuario no existe.</p>");
            }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error conectando a la base de datos.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</script>
</body>
</html>
