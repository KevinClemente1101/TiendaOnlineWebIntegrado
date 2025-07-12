<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Categorías - Tienda de Patinetas</title>
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
<body>
    <jsp:include page="../includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="../includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff;">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-list me-2"></i>Gestión de Categorías
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/categorias/nueva" 
                           class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Nueva Categoría
                        </a>
                    </div>
                </div>
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <div class="table-responsive">
                    <table class="table modern-table align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th style="width: 10%">ID</th>
                                <th>Nombre</th>
                                <th style="width: 20%" class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categorias}" var="categoria">
                            <tr>
                                <td>${categoria.id}</td>
                                <td>${categoria.nombre}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/categorias/editar?id=${categoria.id}" 
                                       class="btn btn-outline-primary btn-sm me-2">
                                        <i class="fas fa-edit me-1"></i>Editar
                                    </a>
                                    <button type="button" class="btn btn-outline-danger btn-sm" 
                                            onclick="confirmarEliminar('${categoria.id}', '${categoria.nombre}')">
                                        <i class="fas fa-trash me-1"></i>Eliminar
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categorias}">
                            <tr>
                                <td colspan="3" class="text-center py-4">
                                    <i class="fas fa-list fa-2x text-muted mb-2"></i>
                                    <div class="text-muted">No hay categorías registradas</div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal de confirmación -->
    <div class="modal fade" id="confirmModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que deseas eliminar la categoría "<span id="categoriaNombre"></span>"?</p>
                    <p class="text-danger small">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <a href="#" id="btnEliminar" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Eliminar
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmarEliminar(id, nombre) {
            document.getElementById('categoriaNombre').textContent = nombre;
            document.getElementById('btnEliminar').href = '${pageContext.request.contextPath}/admin/categorias/eliminar?id=' + id;
            new bootstrap.Modal(document.getElementById('confirmModal')).show();
        }
    </script>
</body>
</html> 