<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Stock Bajo - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        html, body {
            margin: 0 !important;
            padding: 0 !important;
            height: 100%;
        }
        main.col-md-9 {
            padding-top: 0 !important;
            margin-top: 0 !important;
        }
        .container-fluid, .row {
            margin-top: 0 !important;
            padding-top: 0 !important;
        }
        .modern-table {
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            background: #fff;
        }
        .modern-table thead th {
            position: sticky;
            top: 0;
            background: #23272b;
            color: #fff;
            font-size: 1.08rem;
            font-weight: 800;
            letter-spacing: 1px;
            border: none;
        }
        .modern-table tbody tr {
            border-bottom: 1.5px solid #f0f0f0;
            transition: box-shadow 0.18s, transform 0.18s, background 0.18s;
        }
        .modern-table tbody tr:last-child {
            border-bottom: none;
        }
        .modern-table tbody tr:hover {
            background: #f7fafd;
            box-shadow: 0 2px 12px rgba(0,255,193,0.07);
            transform: scale(1.01);
        }
        .modern-table td, .modern-table th {
            padding: 1.1rem 1rem;
            font-size: 1.08rem;
            vertical-align: middle;
        }
        .modern-table td {
            font-weight: 600;
            color: #23272b;
        }
        .modern-table .btn {
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
        }
        @media (max-width: 700px) {
            .modern-table td, .modern-table th { padding: 0.6rem 0.3rem; font-size: 0.98rem; }
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="../includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff;">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1 class="h2"><i class="fas fa-exclamation-triangle me-2"></i>Productos con Stock Bajo</h1>
                <form class="d-flex" method="get">
                    <input type="number" class="form-control me-2" name="umbral" min="1" max="100" value="${umbral}" style="width:120px;">
                    <button class="btn btn-outline-primary" type="submit">Filtrar</button>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table modern-table align-middle">
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
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 