package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Ventas {
    private int idVenta;
    private int no_factura;
    private String serie;  // Cambiado a String
    private String fecha_factura;
    private int idcliente;
    private int idempleado;
    private conexion conexionDB;

    // Constructor por defecto
    public Ventas() {}

    // Constructor para agregar una nueva venta
    public Ventas(int no_factura, String serie, String fecha_factura, int idcliente, int idempleado) {
        this.no_factura = no_factura;
        this.serie = serie;  // Cambiado a String
        this.fecha_factura = fecha_factura;
        this.idcliente = idcliente;
        this.idempleado = idempleado;
    }

    // Constructor para modificar una venta
    public Ventas(int idVenta, int no_factura, String serie, String fecha_factura, int idcliente, int idempleado) {
        this.idVenta = idVenta;
        this.no_factura = no_factura;
        this.serie = serie;  // Cambiado a String
        this.fecha_factura = fecha_factura;
        this.idcliente = idcliente;
        this.idempleado = idempleado;
    }

    // Constructor para eliminar una venta
    public Ventas(int idVenta) {
        this.idVenta = idVenta;
    }

    // Getters y Setters
    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {  // Cambiado a String
        this.serie = serie;
    }

    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
    }

    public int getIdempleado() {
        return idempleado;
    }

    public void setIdempleado(int idempleado) {
        this.idempleado = idempleado;
    }

    // Método para agregar ventas
    public int agregarVenta() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "INSERT INTO ventas (nofactura, serie, fechafactura, idcliente, idempleado) VALUES (?, ?, ?, ?, ?);";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getNo_factura());
            parametro.setString(2, getSerie());  // Directamente como String
            parametro.setString(3, getFecha_factura());
            parametro.setInt(4, getIdcliente());
            parametro.setInt(5, getIdempleado());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para modificar ventas
    public int modificarVenta() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "UPDATE ventas SET nofactura = ?, serie = ?,  idcliente = ?, idempleado = ? WHERE idVenta = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getNo_factura());
            parametro.setString(2, getSerie());  // Directamente como String
            parametro.setInt(3, getIdcliente());
            parametro.setInt(4, getIdempleado());
            parametro.setInt(5, getIdVenta());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al modificar venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para eliminar ventas
    public int eliminarVenta() {
        int retorno = 0;
        PreparedStatement parametro = null;
        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();

            String query = "DELETE FROM ventas WHERE idVenta = ?;";
            parametro = conexionDB.conectar_db.prepareStatement(query);
            parametro.setInt(1, getIdVenta());
            retorno = parametro.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar venta: " + ex.getMessage());
        } finally {
            closeResources(parametro);
        }
        return retorno;
    }

    // Método para leer ventas
    public DefaultTableModel leerVentas() {
        DefaultTableModel tabla = new DefaultTableModel();
        PreparedStatement parametro = null;
        ResultSet consulta = null;

        try {
            conexionDB = new conexion();
            conexionDB.abrir_conexion();
            
            String query = "SELECT idVenta, nofactura, serie, fechafactura, idcliente, idempleado, fechaingreso FROM ventas ORDER BY idVenta DESC;";
            
            parametro = conexionDB.conectar_db.prepareStatement(query);
            consulta = parametro.executeQuery();

            String encabezado[] = {"idVenta", "nofactura", "serie", "fechafactura", "idcliente", "idempleado", "fechaingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[7];
            while (consulta.next()) {
                datos[0] = consulta.getString("idVenta");
                datos[1] = consulta.getString("nofactura");
                datos[2] = consulta.getString("serie");
                datos[3] = consulta.getString("fechafactura");
                datos[4] = consulta.getString("idcliente");  
                datos[5] = consulta.getString("idempleado");
                datos[6] = consulta.getString("fechaingreso");
                tabla.addRow(datos);
            }
        } catch (SQLException ex) {
            System.err.println("Error al leer ventas: " + ex.getMessage());
        } finally {
            closeResources(consulta, parametro);
        }
        
        return tabla; // No olvides retornar la tabla
    }

    // Método para cerrar recursos
    private void closeResources(PreparedStatement parametro) {
        try {
            if (parametro != null) {
                parametro.close();
            }
            conexionDB.cerrar_conexion();
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }

    private void closeResources(ResultSet consulta, PreparedStatement parametro) {
        try {
            if (consulta != null) {
                consulta.close();
            }
            closeResources(parametro);
        } catch (SQLException e) {
            System.err.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}
