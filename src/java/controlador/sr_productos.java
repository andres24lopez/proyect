package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.productos;

public class sr_productos extends HttpServlet {

    productos producto;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Imprimir parámetros recibidos en consola para depuración
        System.out.println("ID Producto: " + request.getParameter("txt_idProducto"));
        System.out.println("Producto: " + request.getParameter("txt_producto"));
        System.out.println("ID Marca: " + request.getParameter("txt_idMarca"));
        System.out.println("Descripción: " + request.getParameter("txt_descripcion"));
        System.out.println("Imagen: " + request.getParameter("txt_imagen"));
        System.out.println("Precio Costo: " + request.getParameter("txt_precio_costo"));
        System.out.println("Precio Venta: " + request.getParameter("txt_precio_venta"));
        System.out.println("Existencia: " + request.getParameter("txt_existencia"));
        System.out.println("Fecha Ingreso: " + request.getParameter("txt_fecha_ingreso"));

        try (PrintWriter out = response.getWriter()) {

            // Crear objeto producto con los parámetros recibidos
            producto = new productos(
                    Integer.parseInt(request.getParameter("txt_idProducto")),
                    request.getParameter("txt_producto"),
                    Integer.parseInt(request.getParameter("txt_idMarca")),
                    request.getParameter("txt_descripcion"),
                    request.getParameter("txt_imagen"),
                    Double.parseDouble(request.getParameter("txt_precio_costo")),
                    Double.parseDouble(request.getParameter("txt_precio_venta")),
                    Integer.parseInt(request.getParameter("txt_existencia")),
                    request.getParameter("txt_fecha_ingreso")
            );

            // Acción para agregar
            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (producto.agregar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Ingresó el producto xxxxxxxxxxxx </h1>");
                    out.println("<a href='inventario.jsp'>Regresar...</a>");
                }
            }

            // Acción para modificar
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (producto.modificar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Modificó el producto xxxxxxxxxxxx </h1>");
                    out.println("<a href='inventario.jsp'>Regresar...</a>");
                }
            }

            // Acción para eliminar
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (producto.eliminar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Eliminó el producto xxxxxxxxxxxx </h1>");
                    out.println("<a href='inventario.jsp'>Regresar...</a>");
                }
            }
        }
    }

    // Método doGet
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Método doPost
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Información del servlet
    @Override
    public String getServletInfo() {
        return "Servlet para la gestión de productos";
    }
}