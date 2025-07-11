<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Stock Bajo - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container py-4">
           <jsp:include page="../includes/sidebar.jsp" />
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="h2"><i class="fas fa-exclamation-triangle me-2"></i>Productos con Stock Bajo</h1>
            <form class="d-flex" method="get">
                <input type="number" class="form-control me-2" name="umbral" min="1" max="100" value="${umbral}" style="width:120px;">
                <button class="btn btn-outline-primary" type="submit">Filtrar</button>
            </form>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Stock</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.id}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.descripcion}</td>
                            <td>S/. ${producto.precio}</td>
                            <td><span class="badge bg-warning text-dark">${producto.stock}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty productos}">
                <div class="alert alert-success text-center mt-4">
                    <i class="fas fa-check-circle me-2"></i>¡No hay productos con stock bajo!
                </div>
            </c:if>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 