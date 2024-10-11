package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.swing.table.DefaultTableModel;

public class productos {
    private int idProducto;
    private String producto;
    private int idMarca;
    private String descripcion;
    private String imagen;
    private double precio_costo;
    private double precio_venta;
    private int existencia;
    private String fecha_ingreso;
    conexion conexionDB;

    public productos() {}

    public productos(int idProducto, String producto, int idMarca, String descripcion, String imagen, double precio_costo, double precio_venta, int existencia, String fecha_ingreso) {
        this.idProducto = idProducto;
        this.producto = producto;
        this.idMarca = idMarca;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
        this.existencia = existencia;
        this.fecha_ingreso = fecha_ingreso;
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

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    // Método para agregar productos
    public int agregar() {
        int retorno = 0;
        PreparedStatement parametro;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            String query = "INSERT INTO productos (producto, idMarca, descripcion, imagen, precio_costo, precio_venta, existencia, fecha_ingreso) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
  
            parametro = (PreparedStatement)conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setDouble(5, getPrecio_costo());
            parametro.setDouble(6, getPrecio_venta());
            parametro.setInt(7, getExistencia());
            parametro.setString(8, getFecha_ingreso());
            retorno = parametro.executeUpdate();
            conexionDB.cerrar_conexion();
         }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    // Método para modificar productos
    public int modificar() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            String query = "UPDATE productos SET producto = ?, idMarca = ?, descripcion = ?, imagen = ?, precio_costo = ?, precio_venta = ?, existencia = ?, fecha_ingreso = ? WHERE idProducto = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setDouble(5, getPrecio_costo());
            parametro.setDouble(6, getPrecio_venta());
            parametro.setInt(7, getExistencia());
            parametro.setString(8, getFecha_ingreso());
            parametro.setInt(9, getIdProducto());
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
    public int eliminar() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            String query = "DELETE FROM productos WHERE idProducto = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdProducto());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar producto: " + ex.getMessage());
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

    // Método para leer los productos
    public ResultSet  leer() {
    ResultSet consulta = null;
    try {
        conexionDB = new conexion();  
        conexionDB.abrir_conexion();
        String query = "SELECT idProducto, producto, idMarca, descripcion, imagen, precio_costo, precio_venta, existencia, fecha_ingreso FROM productos;";
        consulta = conexionDB.conectar_db.createStatement().executeQuery(query);
    } catch (SQLException ex) {
        System.err.println("Error al leer productos: " + ex.getMessage());
    }
    return consulta;
}
}
