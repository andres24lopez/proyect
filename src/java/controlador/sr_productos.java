package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.productos;

@MultipartConfig
public class sr_productos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Obtener el tipo de acción
            String action = request.getParameter("btn_agregar") != null ? "agregar" :
                            request.getParameter("btn_modificar") != null ? "modificar" :
                            request.getParameter("btn_eliminar") != null ? "eliminar" : "";

            // Obtener datos del formulario
            int idP = Integer.parseInt(request.getParameter("txt_idProducto"));
            String productoNombre = request.getParameter("txt_producto");
            int idMarca = Integer.parseInt(request.getParameter("drop_marca"));
            String descripcion = request.getParameter("txt_descripcion");
            double precioCosto = Double.parseDouble(request.getParameter("txt_precio_costo"));
            double precioVenta = Double.parseDouble(request.getParameter("txt_precio_venta"));
            int existencia = Integer.parseInt(request.getParameter("txt_existencia"));

            // Crear objeto producto si se está agregando o modificando
            productos producto = new productos(
                    idP,
                    productoNombre,
                    idMarca,
                    descripcion,
                    null, // Para agregar la imagen más tarde
                    precioCosto,
                    precioVenta,
                    existencia
            );

            // Procesar la imagen solo si se está agregando un nuevo producto
            if ("agregar".equals(action)) {
                System.out.println("Se recibió la solicitud para agregar.");
                Part filePart = request.getPart("file_imagen");
                String fileName = getFileName(filePart);
                String uploadPath = getServletContext().getRealPath("/admin/img_producto") + File.separator + fileName;
                File file = new File(uploadPath);
                filePart.write(uploadPath); // Guardar la imagen en el servidor
                producto.setImagen(fileName); // Establecer el nombre de la imagen en el objeto

                if (producto.agregar() > 0) {
                    response.sendRedirect("inventario.jsp");
                } else {
                    out.println("<h1> xxxxxxx No se Ingresó xxxxxxxxxxxx </h1>");
                    out.println("<a href='index.jsp'>Regresar...</a>");
                }
            }

            // Botón modificar
            if ("modificar".equals(action)) {
                System.out.println("Se recibió la solicitud para modificar.");
                // Solo se actualiza el objeto producto, no se guarda la imagen nuevamente
                if (producto.modificar() > 0) {
                    response.sendRedirect("inventario.jsp?success=true");
                } else {
                    out.println("<h1> xxxxxxx No se Modificó xxxxxxxxxxxx </h1>");
                    out.println("<a href='inventario.jsp'>Regresar...</a>");
                }
            }

            // Botón eliminar
            if ("eliminar".equals(action)) {
                System.out.println("Se recibió la solicitud para eliminar.");
                if (producto.eliminar(idP) > 0) {
                    response.sendRedirect("inventario.jsp?success=true");
                } else {
                    out.println("<h1> xxxxxxx No se Eliminó xxxxxxxxxxxx </h1>");
                    out.println("<a href='inventario.jsp'>Regresar...</a>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("inventario.jsp?error=true");
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
        return "Short description";
    }

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
