<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos MÃ¡s Vendidos - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="../includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1 class="h2"><i class="fas fa-chart-bar me-2"></i>Productos Más Vendidos</h1>
                <form class="d-flex" method="get">
                    <input type="number" class="form-control me-2" name="limite" min="1" max="100" value="${limite}" style="width:120px;">
                    <button class="btn btn-outline-primary" type="submit">Filtrar</button>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Producto</th>
                            <th>Cantidad Vendida</th>
                            <th>Monto Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="producto" items="${productos}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${producto[0]}</td>
                                <td>${producto[1]}</td>
                                <td>S/. ${producto[2]}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty productos}">
                    <div class="alert alert-info text-center mt-4">
                        <i class="fas fa-info-circle me-2"></i>No hay productos vendidos en el período.
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 