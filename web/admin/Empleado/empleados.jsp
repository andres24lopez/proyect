

<%@page import ="modelo.Puesto" %>
<%@page import ="java.util.HashMap" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Empleados</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                  <a class="navbar-brand" href="https://umg.edu.gt/" target="_blank">UMG</a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                      <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.html">INICIO</a>
                      </li>
                      
                      <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                          MENU
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="empleados.jsp"> Empleados</a></li>
                          <li><a class="dropdown-item" href="#">Clientes</a></li>
                          <li><hr class="dropdown-divider"></li>
                          <li><a class="dropdown-item" href="#">Puestos</a></li>
                        </ul>
                      </li>
                     
                    </ul>
                    <form class="d-flex">
                      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                      <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                  </div>
                </div>
              </nav>
        </header>
        
        <h1>Formulario Empleados</h1>
        <div class="container">
            <form action="sr_empleado" method="post" class = "form-group needs-validation" novalidate action="#" method="">
                <label for="lbl_id" class="form-label"><b>ID</b></label>
                <input type="text" class="form-control" id="txt_id" name ="txt_id" value="0" readonly>
                
                </br>
                <label for="lbl_codigo" class="form-label"><b>CODIGO</b></label>
                <input type="text" class="form-control" id="txt_codigo" name ="txt_id" placeholder="Ej: E001" pattern="[E]{1}[0-9]{3}" required>
                
                </br>
                <label for="lbl_nombre" class="form-label"><b>NOMBRES</b></label>
                <input type="text" class="form-control" id="lbl_nombre" name ="txt_nombres" placeholder="Nombre1 Nombre2" required>
                
                </br>
                <label for="lbl_apellido" class="form-label"><b>APELLIDOS</b></label>
                <input type="text" class="form-control" id="lbl_apellido" name ="txt_id" placeholder="Apellido1 Apellido2" required>
                
                </br>
                <label for="lbl_direccion" class="form-label"><b>DIRECCION</b></label>
                <input type="text" name="txt_direccion" class="form-control" id="txt_direccion" name ="txt_id" placeholder="Ej: 2a. 5 calle 2-3 zona 5" required>
                
                </br>
                <label for="lbl_telefono" class="form-label"><b>TELEFONO</b></label>
                <input type="number" name="txt_telefono"class="form-control" id="txt_telefono" name ="txt_id" placeholder="34121232" required>
                
                </br>
                <label for="lbl_nacimiento" class="form-label"><b>FECHA NACIMIENTO</b></label>
                <input type="date" name="txt_nacimiento" class="form-control" id="txt_nacimiento" name ="txt_id" placeholder="DD-MM-AAAA" required>
                
                </br>
                <label for="lbl_puesto" class="form-label"><b>PUESTOS</b></label>
                <select class="form-select" required>
                    <option selected disabled value="">Seleccione</option>
                    <% 
                        Puesto puesto = new Puesto();
                        HashMap<String, String> drop = puesto.drop_puesto();
                        for(String i: drop.keySet()){
                            out.println("<option value='"+ i +"'>"+ drop.get(i) +"</option>");
                        }
                    %>
                  </select>
                
                </br>
                <button name ="btn_crear" id="btn_cear" value="crear" class="btn btn-primary"><i class="bi bi-floppy2-fill"></i> Crear</button>
                <button type="btn_modificar"id="btn_modificar" value="modificar"class="btn btn-warning"><i class="bi bi-pencil-square"></i> Modificar</button>
                <button type="btn_borrar"id="btn_borrar" value="borrar"class="btn btn-danger"><i class="bi bi-trash3"></i> Borrar</button>
            </form>
        </div>
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
              'use strict'

              // Fetch all the forms we want to apply custom Bootstrap validation styles to
              var forms = document.querySelectorAll('.needs-validation')

              // Loop over them and prevent submission
              Array.prototype.slice.call(forms)
                .forEach(function (form) {
                  form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                      event.preventDefault()
                      event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                  }, false)
                })
            })()
        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    </body>
</html>
