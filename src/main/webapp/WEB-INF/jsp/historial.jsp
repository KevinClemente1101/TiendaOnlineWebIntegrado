<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Compras - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-4">
        <h1 class="mb-4"><i class="fas fa-history me-2"></i>Mis Compras</h1>
        <c:choose>
            <c:when test="${empty compras}">
                <div class="alert alert-info">Aún no has realizado ninguna compra.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="venta" items="${compras}">
                                <tr>
                                    <td>${venta.id}</td>
                                    <td><fmt:formatDate value="${venta.fecha}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>S/. ${venta.total}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/detalle-compra?id=${venta.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-eye"></i> Ver Detalle
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 