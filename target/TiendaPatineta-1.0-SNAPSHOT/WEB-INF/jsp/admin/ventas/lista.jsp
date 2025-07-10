<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ventas - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../includes/sidebar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h1 class="h2"><i class="fas fa-shopping-cart me-2"></i>Ventas</h1>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Email</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="venta" items="${ventas}">
                                <tr>
                                    <td>${venta.id}</td>
                                    <td>${venta.usuario.nombre}</td>
                                    <td>${venta.usuario.email}</td>
                                    <td><fmt:formatDate value="${venta.fecha}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>S/. ${venta.total}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/ventas/detalle?id=${venta.id}" class="btn btn-sm btn-info">
                                            <i class="fas fa-eye"></i> Ver Detalle
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 