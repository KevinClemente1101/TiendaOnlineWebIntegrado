<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Compra - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
.detalle-container {
    background: #fff;
    border-radius: 22px;
    box-shadow: 0 4px 32px rgba(102,126,234,0.13);
    padding: 2.5rem 2rem 2rem 2rem;
    max-width: 1100px;
    margin: 2.5rem auto 2rem auto;
}
.detalle-title {
    font-size: 2.7rem;
    font-weight: 900;
    color: #222;
    margin-bottom: 2.2rem;
    display: flex;
    align-items: center;
    gap: 0.7rem;
}
.detalle-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background: #f8f9fa;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 2px 16px rgba(102,126,234,0.07);
}
.detalle-table th {
    background: #667eea;
    color: #fff;
    font-weight: 700;
    font-size: 1.1rem;
    border: none;
    padding: 1rem 0.7rem;
}
.detalle-table td {
    background: #fff;
    font-size: 1.05rem;
    border: none;
    padding: 1rem 0.7rem;
    vertical-align: middle;
}
.detalle-table tr:last-child td {
    border-bottom: none;
}
.detalle-table .btn {
    border-radius: 10px;
    font-size: 1.1rem;
    padding: 0.5rem 1.1rem;
}
@media (max-width: 900px) {
    .detalle-container { padding: 1.2rem 0.2rem; }
    .detalle-title { font-size: 1.5rem; }
}
</style>
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-4 detalle-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="detalle-title"><i class="fas fa-receipt me-2"></i>Detalle de Compra #${ventaId}</h1>
            <a href="${pageContext.request.contextPath}/historial" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Volver al Historial
            </a>
        </div>
        <div class="table-responsive">
            <table class="detalle-table">
                <thead>
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
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 