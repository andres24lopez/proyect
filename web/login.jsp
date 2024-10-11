<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                background-image: url('img/Cover.png');
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
            }

            .card-container {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: rgba(50, 50, 50, 0.5);
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .card {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 300px;
                text-align: center;
            }
            
            h1 {
                color: #333;
            }

            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            p {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="card-container">
            <div class="card">
                <h1>Login</h1>
                <form method="POST">
                    Username: <input type="text" name="username" required><br>
                    Password: <input type="password" name="password" required><br>
                    <input type="submit" value="Login">
                </form>

                <%
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    if (username != null && password != null) {
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Establecer la conexión a la base de datos
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_emp", "root", "danigero");

                            // Consulta para obtener los datos del usuario
                            String sql = "SELECT id, password, attempts, lock_time, mec FROM users WHERE username = ?";
                            stmt = conn.prepareStatement(sql);
                            stmt.setString(1, username);
                            rs = stmt.executeQuery();

                            if (rs.next()) {
                                String dbPassword = rs.getString("password");
                                int attempts = rs.getInt("attempts");
                                Timestamp lockTime = rs.getTimestamp("lock_time");
                                String role = rs.getString("mec");

                                long currentTimeMillis = System.currentTimeMillis();
                                boolean locked = false;

                                if (lockTime != null && (currentTimeMillis - lockTime.getTime()) < 300000) {
                                    // Usuario bloqueado por menos de 5 minutos
                                    out.println("<p style='color:red;'>Tienes varios intentos Fallidos. Por favor esperar 5 minutos.</p>");
                                    locked = true;
                                }

                                if (!locked) {
                                    // Verificar si la contraseña es correcta
                                    if (password.equals(dbPassword)) {
                                        // Redirigir según el rol del usuario
                                        if (role.equalsIgnoreCase("admin")) {
                                            response.sendRedirect("admin/Administrador/inventario.jsp");
                                        } else if (role.equalsIgnoreCase("empleado")) {
                                            response.sendRedirect("admin/Empleado/admin.jsp");
                                        } else if (role.equalsIgnoreCase("cliente")) {
                                            response.sendRedirect("admin/cliente.jsp");
                                        }

                                        // Restablecer intentos fallidos
                                        String resetAttemptsSql = "UPDATE users SET attempts = 0, lock_time = NULL WHERE username = ?";
                                        PreparedStatement resetStmt = conn.prepareStatement(resetAttemptsSql);
                                        resetStmt.setString(1, username);
                                        resetStmt.executeUpdate();
                                        resetStmt.close();
                                    } else {
                                        // Contraseña incorrecta, aumentar contador de intentos fallidos
                                        attempts++;
                                        if (attempts >= 3) {
                                            // Bloquear usuario y registrar la hora
                                            String lockSql = "UPDATE users SET lock_time = NOW() WHERE username = ?";
                                            PreparedStatement lockStmt = conn.prepareStatement(lockSql);
                                            lockStmt.setString(1, username);
                                            lockStmt.executeUpdate();
                                            lockStmt.close();
                                            out.println("<p style='color:red;'>Too many failed attempts. Account locked for 5 minutes.</p>");
                                        } else {
                                            // Actualizar intentos fallidos
                                            String updateAttemptsSql = "UPDATE users SET attempts = ? WHERE username = ?";
                                            PreparedStatement updateStmt = conn.prepareStatement(updateAttemptsSql);
                                            updateStmt.setInt(1, attempts);
                                            updateStmt.setString(2, username);
                                            updateStmt.executeUpdate();
                                            updateStmt.close();
                                            out.println("<p style='color:red;'>Invalid credentials. Attempt " + attempts + " of 3.</p>");
                                        }
                                    }
                                }
                            } else {
                                out.println("<p style='color:red;'>User does not exist.</p>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p style='color:red;'>Error connecting to the database.</p>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
