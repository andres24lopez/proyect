package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Cuenta;

@MultipartConfig
public class sr_cuentacliente extends HttpServlet {

    Cuenta cuenta;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros
            int idCliente = Integer.parseInt(request.getParameter("txt_idCliente"));
            String password = request.getParameter("txt_password");
            int attempts = Integer.parseInt(request.getParameter("txt_attempts"));
            String mec = request.getParameter("txt_mec");

            // Crear objeto Cuenta para cliente
            cuenta = new Cuenta(0, null, password, attempts, null, mec, 0, idCliente); // Se mantiene username como null, ya que no se puede modificar

            if (request.getParameter("btn_modificar") != null) {
                if (cuenta.modificarCuentaCliente() > 0) {
                    response.sendRedirect("cuentas_clientes.jsp");
                } else {
                    response.getWriter().println("Error al modificar cuenta de cliente.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (cuenta.eliminarCuentaCliente() > 0) {
                    response.sendRedirect("cuentas_clientes.jsp");
                } else {
                    response.getWriter().println("Error al eliminar cuenta de cliente.");
                }
            }
        } catch (IOException | NumberFormatException e) {
            // Manejar errores inesperados
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet que maneja las operaciones de cuentas de clientes.";
    }
}
