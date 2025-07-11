<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Ventas por Período - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container py-4">
      <jsp:include page="../includes/sidebar.jsp" />
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h1 class="h2"><i class="fas fa-chart-line me-2"></i>Ventas por Período</h1>
            <form class="d-flex" method="get">
                <input type="date" class="form-control me-2" name="inicio" value="${inicio}" required>
                <input type="date" class="form-control me-2" name="fin" value="${fin}" required>
                <button class="btn btn-outline-primary" type="submit">Filtrar</button>
            </form>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Fecha</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalGeneral" value="0" />
                    <c:forEach var="venta" items="${ventas}">
                        <tr>
                            <td>${venta.id}</td>
                            <td>${venta.usuario.nombre}</td>
                            <td><fmt:formatDate value="${venta.fecha}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>S/. ${venta.total}</td>
                        </tr>
                        <c:set var="totalGeneral" value="${totalGeneral + venta.total}" />
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">Total General:</th>
                        <th>S/. ${totalGeneral}</th>
                    </tr>
                </tfoot>
            </table>
            <c:if test="${empty ventas}">
                <div class="alert alert-info text-center mt-4">
                    <i class="fas fa-info-circle me-2"></i>No hay ventas en el período seleccionado.
                </div>
            </c:if>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 