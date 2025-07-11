<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos - Tienda de Patinetas</title>
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
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }
        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .btn-action {
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 0.9rem;
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
                        <i class="fas fa-box me-2"></i>Gestión de Productos
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/productos/nuevo" 
                           class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Nuevo Producto
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
                
                <div class="row">
                    <c:forEach items="${productos}" var="producto">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card product-card h-100">
                                <div class="position-relative">
                                    <c:choose>
                                        <c:when test="${not empty producto.imagen}">
                                            <img src="${pageContext.request.contextPath}/uploads/${producto.imagen}" 
                                                 class="card-img-top product-image" alt="${producto.nombre}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="card-img-top product-image bg-light d-flex align-items-center justify-content-center">
                                                <i class="fas fa-image fa-3x text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:choose>
                                        <c:when test="${producto.stock > 10}">
                                            <span class="badge bg-success stock-badge">En Stock</span>
                                        </c:when>
                                        <c:when test="${producto.stock > 0}">
                                            <span class="badge bg-warning stock-badge">Stock Bajo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger stock-badge">Sin Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${producto.nombre}</h5>
                                    <p class="card-text text-muted small">
                                        ${producto.descripcion.length() > 100 ? 
                                          producto.descripcion.substring(0, 100).concat('...') : 
                                          producto.descripcion}
                                    </p>
                                    
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="h5 text-primary mb-0">
                                                S/ <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/>
                                            </span>
                                            <small class="text-muted">
                                                Stock: ${producto.stock}
                                            </small>
                                        </div>
                                        
                                        <c:if test="${not empty producto.categoria}">
                                            <span class="badge bg-secondary mb-2">
                                                ${producto.categoria.nombre}
                                            </span>
                                        </c:if>
                                        
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/productos/editar/${producto.id}" 
                                               class="btn btn-outline-primary btn-action flex-fill">
                                                <i class="fas fa-edit me-1"></i>Editar
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-action" 
                                                    onclick="confirmarEliminar(${producto.id}, '${producto.nombre}')">
                                                <i class="fas fa-trash me-1"></i>Eliminar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <c:if test="${empty productos}">
                    <div class="text-center py-5">
                        <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">No hay productos registrados</h4>
                        <p class="text-muted">Comienza agregando tu primer producto</p>
                        <a href="${pageContext.request.contextPath}/admin/productos/nuevo" 
                           class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Agregar Producto
                        </a>
                    </div>
                </c:if>
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
                    <p>¿Estás seguro de que deseas eliminar el producto "<span id="productoNombre"></span>"?</p>
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
            document.getElementById('productoNombre').textContent = nombre;
            document.getElementById('btnEliminar').href = '${pageContext.request.contextPath}/admin/productos/eliminar/' + id;
            new bootstrap.Modal(document.getElementById('confirmModal')).show();
        }
    </script>
</body>
</html> 