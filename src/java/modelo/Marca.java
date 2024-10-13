

package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class Marca {
    private int idMarca;
    private String puesto;
    conexion cn;
    public Marca(){}
    public Marca(int idMarca, String puesto) {
        this.idMarca = idMarca;
        this.puesto = puesto;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public String getMarca() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }
    
    public HashMap drop_sangre(){
        HashMap<String,String> drop = new HashMap();
        try{
            String query = "select idMarca as id, marca from marcas;";
            cn = new conexion();
            cn.abrir_conexion();
            ResultSet consulta = cn.conectar_db.createStatement().executeQuery(query);
            while(consulta.next()){
                drop.put(consulta.getString("id"), consulta.getString("marca"));
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error drop_marca: "+ ex.getMessage());
        }
        return drop;
    }
}
