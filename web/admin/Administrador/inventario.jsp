<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <h3>Formulario Productos</h3>
    <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info center-button" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>
</div>
<br>

<div class="container">
    <div class="modal fade" id="modal_producto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_productos" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Producto</b></label>
                        <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_producto"><b>Producto</b></label>
                        <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Ejemplo: Producto A" required>
                        <br>

                        <select name="drop_marca" id="drop_marca" class="form-control">
                            <option value="">Seleccione una marca</option>
                            <% 
                                Marca marca = new Marca();
                                HashMap<String, String> drop = marca.drop_sangre();
                                for (String i : drop.keySet()) {
                                    out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                }
                            %>                                     
                        </select>

                        <br>
                        <label for="lbl_descripcion"><b>Descripción</b></label>
                        <input type="text" name="txt_descripcion" id="txt_descripcion" class="form-control" placeholder="Descripción del producto" required>

                        <label for="lbl_imagen"><b>Imagen</b></label>
                        <img id="img_preview" src="" alt="Vista previa" style="display:none; width: 50px; height: auto;"/>
                        <input type="text" name="txt_imagen" id="txt_imagen" class="form-control" readonly>
                        <input type="file" name="file_imagen" id="file_imagen" class="form-control" accept="image/*">
                        
                        <label for="lbl_precioCosto"><b>Precio Costo</b></label>
                        <input type="number" step="0.01" name="txt_precio_costo" id="txt_precio_costo" class="form-control" required>
                        
                        <label for="lbl_precioVenta"><b>Precio Venta</b></label>
                        <input type="number" step="0.01" name="txt_precio_venta" id="txt_precio_venta" class="form-control" required>
                        
                        <label for="lbl_existencia"><b>Existencia</b></label>
                        <input type="number" name="txt_existencia" id="txt_existencia" class="form-control" required>

                        <label for="lbl_fechaIngreso"><b>Fecha de Ingreso</b></label>
                        <input type="date" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control">
                        
                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar este producto?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" data-dismiss="modal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Producto</th>
                <th>Marca</th>
                <th>Descripción</th>
                <th>Imagen</th>
                <th>Precio Costo</th>
                <th>Precio Venta</th>
                <th>Existencia</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody id="tbl_productos">
            <% 
            productos producto = new productos();  
            DefaultTableModel tabla = producto.leer(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_marca='" + tabla.getValueAt(t, 2) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td><img src='../img_producto/" + tabla.getValueAt(t, 4) + "' width='50'></td>");
                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 8) + "</td>"); // Asegúrate de que aquí estás accediendo a la columna correcta
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
function limpiar() {
    $("#txt_idProducto").val(0);
    $("#txt_producto").val('');
    $("#drop_marca").val(''); // Limpiar el dropdown de marca
    $("#txt_descripcion").val('');
    $("#txt_imagen").val(''); 
    $("#txt_precio_costo").val('');
    $("#txt_precio_venta").val('');
    $("#txt_existencia").val('');
    $("#txt_fecha_ingreso").val(''); // Limpiar el campo de fecha
    $('#file_imagen').prop('disabled', false).show(); 
    $('#txt_imagen').hide(); 
    $('#img_preview').hide();
}

$('#tbl_productos').on('click', 'tr', function(evt) {
    var target = $(this);
    var idProducto = target.data('id'); // Accede al ID del producto
    var idMarca = parseInt(target.data('id_marca')); // Accede a la ID de la marca
    var producto = target.find("td").eq(1).text(); // Obtener el texto del producto
    var descripcion = target.find("td").eq(3).text(); // Descripción
    var precioCosto = target.find("td").eq(5).text(); // Precio costo
    var precioVenta = target.find("td").eq(6).text(); // Precio venta
    var existencia = target.find("td").eq(7).text(); // Existencia
    var imagen = target.find("td img").attr('src'); // Obtener la URL de la imagen
    var fechaIngreso = target.find("td").eq(8).text(); // Fecha ingreso
    
    
     // Imprimir detalles del producto en la consola
    console.log("Producto seleccionado para modificar/eliminar:");
    console.log("ID Producto:", idProducto);
    console.log("Marca", idMarca);
    console.log("Nombre Producto:", producto);
    console.log("Descripción:", descripcion);
    console.log("Precio Costo:", precioCosto);
    console.log("Precio Venta:", precioVenta);
    console.log("Existencia:", existencia);
    console.log("Imagen URL:", imagen);
    console.log("Fecha de Ingreso:", fechaIngreso);

    $('#txt_idProducto').val(idProducto);
    $('#drop_marca').val(idMarca); // Asignar el valor de idMarca al dropdown
    $('#txt_producto').val(producto);
    $('#txt_descripcion').val(descripcion);
    $('#txt_precio_costo').val(precioCosto);
    $('#txt_precio_venta').val(precioVenta);
    $('#txt_existencia').val(existencia);
    $('#img_preview').attr('src', imagen).show();
    $('#txt_imagen').val(imagen);
    $('#file_imagen').prop('disabled', true).hide();
    $('#txt_fecha_ingreso').val(fechaIngreso);

    $('#modal_producto').modal('show');
});


// Función para confirmar eliminación
function confirmarEliminacion() {
    if (confirm("¿Está seguro de que desea eliminar el producto: " + nombreProducto + "?")) {
        console.log("Eliminando producto:", nombreProducto);
        // Aquí podrías llamar a la lógica para eliminar el producto
        $('#btn_eliminar').closest('form').submit(); // Enviar el formulario para realizar la eliminación
    }
}


$('#file_imagen').change(function(e) {
    var reader = new FileReader();
    reader.onload = function(e) {
        $('#img_preview').attr('src', e.target.result).show();
    };
    reader.readAsDataURL(this.files[0]);
});
</script>

<%@ include file="pie_administrador.jsp" %>
