<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <h3>Formulario Compras</h3>
    <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info center-button" data-toggle="modal" data-target="#modal_compra" onclick="limpiar()">Nuevo</button>
</div>
<br>

<div class="container">
    <div class="modal fade" id="modal_compra" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_compras" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Compra</b></label>
                        <input type="text" name="txt_idCompra" id="txt_idCompra" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noOrdenCompra"><b>No. Orden de Compra</b></label>
                        <input type="text" name="txt_noOrdenCompra" id="txt_noOrdenCompra" class="form-control" placeholder="Ejemplo: 12312" required>
                        <br>

                        <label for="lbl_idProveedor"><b>ID Proveedor</b></label>
                        <input type="text" name="txt_idProveedor" id="txt_idProveedor" class="form-control" placeholder="ID del proveedor" required>

                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_orden"><b>Fecha Orden</b></label>
                        <input type="date" name="txt_fecha_orden" id="txt_fecha_orden" class="form-control" required>
                        <!-- Campo de fecha en formato texto que será oculto -->
                        <input type="hidden" name="txt_fechaorden" id="txt_fechaorden" class="form-control" readonly>

                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar esta compra?')">Eliminar</button>
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
                <th>No. Orden Compra</th>
                <th>ID Proveedor</th>
                <th>Fecha Orden</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody id="tbl_compras">
            <% 
            Compras compra = new Compras();  
            DefaultTableModel tabla = compra.leerCompras(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
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
    // Función para limpiar el formulario antes de abrir el modal para nueva compra
    function limpiar() {
        $("#txt_idCompra").val(0);
        $("#txt_noOrdenCompra").val('');
        $("#txt_idProveedor").val('');
        $("#txt_fecha_orden").val('');
        $("#txt_fechaorden").val(''); // Limpiar el campo de fecha oculto

        // Habilitar el campo de fecha
        $('#txt_fecha_orden').prop('disabled', false);
    }

    // Al hacer clic en una fila de la tabla
    $('#tbl_compras').on('click', 'tr', function(evt) {
        var target = $(this);
        var idCompra = target.find("td").eq(0).text();
        var noOrdenCompra = target.find("td").eq(1).text();
        var idProveedor = target.find("td").eq(2).text();
        var fechaOrden = target.find("td").eq(3).text(); // Capturar la fecha de la tabla en formato texto

    console.log("Producto seleccionado para modificar/eliminar:");
    console.log("ID Producto:", idCompra);
    console.log("Marca", noOrdenCompra);
    console.log("Nombre Producto:", idProveedor);
    console.log("Descripción:", fechaOrden);

        // Asignar los valores capturados al formulario
        $("#txt_idCompra").val(idCompra);
        $("#txt_noOrdenCompra").val(noOrdenCompra);
        $("#txt_idProveedor").val(idProveedor);

        // Asignar la fecha capturada al campo de texto y deshabilitarlo
        $("#txt_fechaorden").val(fechaOrden);
        $("#txt_fecha_orden").prop('readonly', true);

        // Deshabilitar el campo de fecha tipo date (si no quieres que se edite)
        $('#txt_fecha_orden').val(fechaOrden).prop('disabled', true);

        // Mostrar el modal
        $('#modal_compra').modal('show');
    });
</script>

<%@ include file="pie_administrador.jsp" %>
