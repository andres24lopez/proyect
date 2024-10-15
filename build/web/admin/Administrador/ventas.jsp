<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>

<div class="container">
    <h3>Formulario Ventas</h3>
    <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info center-button" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>
</div>
<br>

<div class="container">
    <div class="modal fade" id="modal_producto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_ventas" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Venta</b></label>
                        <input type="text" name="txt_idVenta" id="txt_idVenta" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noFactura"><b>No. Factura</b></label>
                        <input type="text" name="txt_noFactura" id="txt_noFactura" class="form-control" placeholder="Ejemplo: 12312" required>
                        <br>

                        <label for="lbl_serie"><b>Serie</b></label>
                        <input type="text" name="txt_serie" id="txt_serie" class="form-control" placeholder="Ejemplo: E" maxlength="1" required>

                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_factura"><b>Fecha Factura</b></label>
                        <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" required>
                        <!-- Campo de fecha en formato texto que será oculto -->
                        <input type="hidden" name="txt_fechafactura" id="txt_fechafactura" class="form-control" readonly>
                            
                        <label for="lbl_idCliente"><b>ID Cliente</b></label>
                        <input type="text" name="txt_idCliente" id="txt_idCliente" class="form-control" placeholder="ID del cliente" required>
                        
                        <label for="lbl_idEmpleado"><b>ID Empleado</b></label>
                        <input type="text" name="txt_idEmpleado" id="txt_idEmpleado" class="form-control" placeholder="ID del empleado" required>
                
                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('¿Desea eliminar esta venta?')">Eliminar</button>
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
                <th>No. Factura</th>
                <th>Serie</th>
                <th>Fecha Factura</th>
                <th>ID Cliente</th>
                <th>ID Empleado</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody id="tbl_ventas">
            <% 
            Ventas venta = new Ventas();  
            DefaultTableModel tabla = venta.leerVentas(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
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
    // Función para limpiar el formulario antes de abrir el modal para nueva venta
    function limpiar() {
        $("#txt_idVenta").val(0);
        $("#txt_noFactura").val('');
        $("#txt_serie").val('');
        $("#txt_fecha_factura").val('');
        $("#txt_fechafactura").val(''); // Limpiar el campo de fecha oculto
        $("#txt_idCliente").val('');
        $("#txt_idEmpleado").val('');

        // Habilitar el campo de fecha
        $('#txt_fecha_factura').prop('disabled', false);
    }

    // Al hacer clic en una fila de la tabla
    $('#tbl_ventas').on('click', 'tr', function(evt) {
        var target = $(this);
        var idVenta = target.find("td").eq(0).text();
        var noFactura = target.find("td").eq(1).text();
        var serie = target.find("td").eq(2).text();
        var fechaFactura = target.find("td").eq(3).text(); // Capturar la fecha de la tabla en formato texto
        var idCliente = target.find("td").eq(4).text();
        var idEmpleado = target.find("td").eq(5).text();

        // Asignar los valores capturados al formulario
        $("#txt_idVenta").val(idVenta);
        $("#txt_noFactura").val(noFactura);
        $("#txt_serie").val(serie);

        // Asignar la fecha capturada al campo de texto y deshabilitarlo
        $("#txt_fecha_factura").val(fechaFactura);
        $("#txt_fechafactura").prop('readonly', true);

        // Deshabilitar el campo de fecha tipo date (si no quieres que se edite)
        $('#txt_fecha_factura').val(fechaFactura).prop('disabled', true);

        $("#txt_idCliente").val(idCliente);
        $("#txt_idEmpleado").val(idEmpleado);

        // Mostrar el modal
        $('#modal_producto').modal('show');
    });
</script>

<%@ include file="pie_administrador.jsp" %>
