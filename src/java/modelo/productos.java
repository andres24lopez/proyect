package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.swing.table.DefaultTableModel;
import java.sql.Date; // Import para convertir fechas a SQL

public class productos {
    private int idProducto;
    private String producto;
    private int idMarca;
    private String descripcion;
    private String imagen;
    private double precio_costo;
    private double precio_venta;
    private int existencia;
    conexion conexionDB;

    public productos() {}

    // Constructor solo con ID
    public productos(int idProducto) {
        this.idProducto = idProducto;
    }

    public productos(int idProducto, String producto, int idMarca, String descripcion, String imagen, double precio_costo, double precio_venta, int existencia) {
        this.idProducto = idProducto;
        this.producto = producto;
        this.idMarca = idMarca;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
    }

    public productos(String producto, int idMarca, String descripcion, String imagen, double precio_costo, double precio_venta, int existencia) {
        this.producto = producto;
        this.idMarca = idMarca;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
    }

    public productos(String producto, int idMarca, String descripcion, double precio_costo, double precio_venta, int existencia) {
        this.producto = producto;
        this.idMarca = idMarca;
        this.descripcion = descripcion;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
    }

    // Getters y Setters
    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public double getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(double precio_costo) {
        this.precio_costo = precio_costo;
    }

    public double getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(double precio_venta) {
        this.precio_venta = precio_venta;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    // Método para agregar productos
    public int agregar() {
        String rutaImagen = "/admin/img_producto/";
        int retorno = 0;
        PreparedStatement parametro;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO productos (producto, idMarca, descripcion, imagen, precio_costo, precio_venta, existencia) VALUES (?, ?, ?, ?, ?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen()); // Asignar la ruta de la imagen
            parametro.setDouble(5, getPrecio_costo());
            parametro.setDouble(6, getPrecio_venta());
            parametro.setInt(7, getExistencia());
            retorno = parametro.executeUpdate();
            conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public int modificar() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE productos SET producto = ?, idMarca = ?, descripcion = ?, imagen = ?, precio_costo = ?, precio_venta = ?, existencia = ? WHERE idProducto = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setDouble(5, getPrecio_costo());
            parametro.setDouble(6, getPrecio_venta());
            parametro.setInt(7, getExistencia());
            parametro.setInt(8, getIdProducto());

            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar producto: " + ex.getMessage());
        } finally {
            try {
                if (parametro != null) parametro.close();
                conexionDB.cerrar_conexion();
            } catch (SQLException e) {
                System.err.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return retorno;
    }

    // Método para eliminar productos
    public int eliminar(int getIdProducto) {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            conexionDB = new conexion();
            String query = "DELETE FROM productos WHERE idProducto = ?;";
            conexionDB.abrir_conexion();
            parametro = (PreparedStatement)conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdProducto());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    // Método para leer productos
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            conexionDB = new conexion();  
            conexionDB.abrir_conexion();
            
            String query = "SELECT p.idProducto, p.producto, m.marca, m.idMarca, p.descripcion, p.imagen, p.precio_costo, p.precio_venta, p.existencia, p.fecha_ingreso " +
                           "FROM productos p " +
                           "INNER JOIN marcas m ON p.idMarca = m.idMarca " +
                           "ORDER BY p.idProducto DESC;";

            ResultSet consulta = conexionDB.conectar_db.createStatement().executeQuery(query);

            String encabezado[] = {"idProducto", "producto", "marca", "descripcion", "imagen", "precio_costo", "precio_venta", "existencia", "fecha_ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[9];
            while (consulta.next()) {
                datos[0] = consulta.getString("idProducto");
                datos[1] = consulta.getString("producto");
                datos[2] = consulta.getString("idMarca");
                datos[3] = consulta.getString("descripcion");
                datos[4] = consulta.getString("imagen");
                datos[5] = consulta.getString("precio_costo");
                datos[6] = consulta.getString("precio_venta");
                datos[7] = consulta.getString("existencia");
                datos[8] = consulta.getString("fecha_ingreso");
                tabla.addRow(datos);
            }

            conexionDB.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    // Método para obtener los datos del producto
    public void obtenerDatos() {
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            
            String query = "SELECT producto, descripcion FROM productos WHERE idProducto = ?";
            stmt = conexionDB.conectar_db.prepareStatement(query);
            stmt.setInt(1, this.idProducto);
            rs = stmt.executeQuery();

            if (rs.next()) {
                this.producto = rs.getString("producto");
                this.descripcion = rs.getString("descripcion");
                
                System.out.println("Producto a eliminar:");
                System.out.println("ID: " + this.idProducto);
                System.out.println("Nombre: " + this.producto);
                System.out.println("Descripción: " + this.descripcion);
            } else {
                System.out.println("Producto no encontrado con ID: " + this.idProducto);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                conexionDB.cerrar_conexion();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
