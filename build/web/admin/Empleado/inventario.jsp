<%@ include file="template_empleado.jsp" %>
        <div class="container">
            <h1>Formulario Productos</h1>
            <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info btn-lg" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>
        </div>
        <br>
        <div class="container">
            <div class="modal fade" id="modal_producto" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content -->
                    <div class="modal-content">
                        <div class="modal-body">
                            <form action="sr_productos" method="get" class="form-group">
                                <label for="lbl_id"><b>ID Producto</b></label>
                                <input type="text" name="txt_idProducto" id="txt_idProducto" class="form-control" value="0"  readonly> 
                                
                                <label for="lbl_producto"><b>Producto</b></label>
                                <input type="text" name="txt_producto" id="txt_producto" class="form-control" placeholder="Ejemplo: Producto A" required>
                                
                                <label for="lbl_marca"><b>Marca</b></label>
                                <input type="number" name="txt_idMarca" id="txt_idMarca" class="form-control" placeholder="Ejemplo: 1" required>
                                
                                <label for="lbl_descripcion"><b>Descripción</b></label>
                                <input type="text" name="txt_descripcion" id="txt_descripcion" class="form-control" placeholder="Descripción del producto" required>
                                
                                <label for="lbl_imagen"><b>Imagen</b></label>
                                <input type="text" name="txt_imagen" id="txt_imagen" class="form-control" placeholder="URL de la imagen" required>
                                
                                <label for="lbl_precioCosto"><b>Precio Costo</b></label>
                                <input type="number" step="0.01" name="txt_precio_costo" id="txt_precio_costo" class="form-control" required>
                                
                                <label for="lbl_precioVenta"><b>Precio Venta</b></label>
                                <input type="number" step="0.01" name="txt_precio_venta" id="txt_precio_venta" class="form-control" required>
                                
                                <label for="lbl_existencia"><b>Existencia</b></label>
                                <input type="number" name="txt_existencia" id="txt_existencia" class="form-control" required>
                                
                                <label for="lbl_fechaIngreso"><b>Fecha Ingreso</b></label>
                                <input type="date" name="txt_fecha_ingreso" id="txt_fecha_ingreso" class="form-control" required>
                                
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
                        <th>ID Producto</th>
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
                    productos producto = new productos();  // Nombre de la clase corregido
                    ResultSet rs = producto.leer();  // Ahora el método leer() devuelve un ResultSet
                    while (rs.next()) {  // Usar ResultSet para recorrer los datos
                    %>
                        <tr data-id="<%= rs.getInt("idProducto") %>">
                            <td><%= rs.getInt("idProducto") %></td>
                            <td><%= rs.getString("producto") %></td>
                            <td><%= rs.getString("idMarca") %></td>
                            <td><%= rs.getString("descripcion") %></td>
                            <td><%= rs.getString("imagen") %></td>
                            <td><%= rs.getDouble("precio_costo") %></td>
                            <td><%= rs.getDouble("precio_venta") %></td>
                            <td><%= rs.getInt("existencia") %></td>
                            <td><%= rs.getString("fecha_ingreso") %></td>
                        </tr>
                    <% 
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
                $("#txt_producto").val('');
                $("#txt_idMarca").val('');
                $("#txt_descripcion").val('');
                $("#txt_imagen").val('');
                $("#txt_precio_costo").val('');
                $("#txt_precio_venta").val('');
                $("#txt_existencia").val('');
                $("#txt_fecha_ingreso").val('');
            }

            $('#tbl_productos').on('click', 'tr', function() {
                var idProducto = $(this).data('id');
                var producto = $(this).find('td').eq(1).text();
                var idMarca = $(this).find('td').eq(2).text();
                var descripcion = $(this).find('td').eq(3).text();
                var imagen = $(this).find('td').eq(4).text();
                var precioCosto = $(this).find('td').eq(5).text();
                var precioVenta = $(this).find('td').eq(6).text();
                var existencia = $(this).find('td').eq(7).text();
                var fechaIngreso = $(this).find('td').eq(8).text();

                // Cargar los datos en el formulario
                $('#txt_idProducto').val(idProducto);
                $('#txt_producto').val(producto);
                $('#txt_idMarca').val(idMarca);
                $('#txt_descripcion').val(descripcion);
                $('#txt_imagen').val(imagen);
                $('#txt_precio_costo').val(precioCosto);
                $('#txt_precio_venta').val(precioVenta);
                $('#txt_existencia').val(existencia);
                $('#txt_fecha_ingreso').val(fechaIngreso);

                // Mostrar el modal
                $('#modal_producto').modal('show');
            });
        </script>
<%@ include file="pie_empleado.jsp" %>