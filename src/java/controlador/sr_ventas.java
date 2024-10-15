package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Ventas;

@MultipartConfig
public class sr_ventas extends HttpServlet {

    Ventas venta;


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar parámetros y convertir a int
            int idVenta = Integer.parseInt(request.getParameter("txt_idVenta")); // Conversión de String a int
            int noFactura = Integer.parseInt(request.getParameter("txt_noFactura")); // Conversión de String a int

            // Convertir a char asegurando que la longitud sea 1
             String serieS = request.getParameter("txt_serie");
            if (serieS.length() != 1) {
                throw new IllegalArgumentException("La serie debe ser un solo carácter.");
            }

            String fechaFactura = request.getParameter("txt_fecha_factura");
            int idCliente = Integer.parseInt(request.getParameter("txt_idCliente")); // Conversión de String a int
            int idEmpleado = Integer.parseInt(request.getParameter("txt_idEmpleado")); // Conversión de String a int
            
            // Crear objeto Ventas
            venta = new Ventas(idVenta, noFactura, serieS, fechaFactura, idCliente, idEmpleado);

            // Acción según el valor del botón presionado
            if (request.getParameter("btn_agregar") != null) {
                if (venta.agregarVenta() > 0) {
                    response.sendRedirect("ventas.jsp");
                } else {
                    response.getWriter().println("Error al agregar venta.");
                }
            }

            if (request.getParameter("btn_modificar") != null) {
                if (venta.modificarVenta() > 0) {
                    response.sendRedirect("ventas.jsp");
                } else {
                    response.getWriter().println("Error al modificar venta.");
                }
            }

            if (request.getParameter("btn_eliminar") != null) {
                if (venta.eliminarVenta() > 0) {
                    response.sendRedirect("ventas.jsp");
                } else {
                    response.getWriter().println("Error al eliminar venta.");
                }
            }
        } catch (IOException e) {
            // Muestra el mensaje completo de cualquier error inesperado de I/O
            response.getWriter().println("Error inesperado: " + e.getMessage());
            e.printStackTrace(response.getWriter()); // Imprime el stack trace
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
        return "Servlet que maneja las operaciones de ventas.";
    }
}
