package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate; // Import para manejar LocalDate
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.productos;

@MultipartConfig
public class sr_productos extends HttpServlet {

    productos producto;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Productos</title>");            
            out.println("</head>");
            out.println("<body>");

            // Procesar la imagen si se sube
            Part filePart = request.getPart("file_imagen"); // Obtiene el archivo de imagen
            String fileName = getFileName(filePart); // Obtiene el nombre del archivo

            // Definir ruta donde se guardará el archivo (esto se usa solo para el almacenamiento físico)
            String uploadPath = getServletContext().getRealPath("/admin/img_producto") + File.separator + fileName;
            File file = new File(uploadPath);
            filePart.write(uploadPath); // Guardar la imagen en el servidor
            
            // Obtener datos del formulario
            int id = Integer.parseInt(request.getParameter("txt_idProducto"));
            String productoNombre = request.getParameter("txt_producto");
            int idMarca = Integer.parseInt(request.getParameter("drop_marca"));
            String descripcion = request.getParameter("txt_descripcion");
            double precioCosto = Double.parseDouble(request.getParameter("txt_precio_costo"));
            double precioVenta = Double.parseDouble(request.getParameter("txt_precio_venta"));
            int existencia = Integer.parseInt(request.getParameter("txt_existencia"));
            String fecha = request.getParameter("txt_fecha_ingreso");
            // Crear objeto producto con los datos recibidos del formulario
            producto = new productos(
                    productoNombre,
                    idMarca,
                    descripcion,
                    fileName, // Solo el nombre del archivo, no la ruta
                    precioCosto,
                    precioVenta,
                    existencia,
                    fecha // Usar la fecha actual como fecha de ingreso
            );

            System.out.println(id);
            System.out.println(productoNombre);
            System.out.println(idMarca);
            System.out.println(descripcion);
            System.out.println(fileName);
            System.out.println(precioCosto);
            System.out.println(precioVenta);
            System.out.println(existencia);

            
            
            
            // Botón agregar
            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (producto.agregar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Ingreso xxxxxxxxxxxx </h1>");
                    out.println("<a href='index.jsp'>Regresar...</a>");
                }
            }

            // Botón modificar
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (producto.modificar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Modifico xxxxxxxxxxxx </h1>");
                    out.println("<a href='index.jsp'>Regresar...</a>");
                }
            }

            // Botón eliminar
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (producto.eliminar(id) > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Elimino xxxxxxxxxxxx </h1>");
                    out.println("<a href='index.jsp'>Regresar...</a>");
                }
            }

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        return "Short description";
    }
    // </editor-fold>

    // Método para obtener el nombre del archivo
    private String getFileName(Part filePart) {
        String contentDisposition = filePart.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
