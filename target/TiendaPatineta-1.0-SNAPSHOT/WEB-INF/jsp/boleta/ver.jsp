<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Boleta - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            <h2 class="mb-0"><i class="fas fa-file-invoice me-2"></i>Boleta N° ${boleta.numero}</h2>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Datos del Cliente</h5>
                    <p><b>Nombre:</b> ${venta.usuario.nombre}</p>
                    <p><b>Email:</b> ${venta.usuario.email}</p>
                </div>
                <div class="col-md-6">
                    <h5>Datos de la Boleta</h5>
                    <p><b>Fecha:</b> ${boleta.fecha}</p>
                    <p><b>Forma de Pago:</b> ${boleta.formaPago}</p>
                </div>
            </div>
            <h5>Detalle de Productos</h5>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Producto</th>
                            <th>Precio Unitario</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detalle" items="${detalles}">
                            <tr>
                                <td>${detalle.producto.nombre}</td>
                                <td>S/. ${detalle.producto.precio}</td>
                                <td>${detalle.cantidad}</td>
                                <td>S/. ${detalle.subtotal}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="row justify-content-end">
                <div class="col-md-4">
                    <table class="table">
                        <tr><th>Subtotal:</th><td>S/. ${boleta.subtotal}</td></tr>
                        <tr><th>IGV:</th><td>S/. ${boleta.igv}</td></tr>
                        <tr class="table-primary"><th>Total:</th><td><b>S/. ${boleta.total}</b></td></tr>
                    </table>
                </div>
            </div>
            <c:if test="${not empty boleta.observaciones}">
                <div class="alert alert-info mt-3">${boleta.observaciones}</div>
            </c:if>
        </div>
    </div>
    <a href="${pageContext.request.contextPath}/ventas" class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Volver a Ventas</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</body>
</html> 