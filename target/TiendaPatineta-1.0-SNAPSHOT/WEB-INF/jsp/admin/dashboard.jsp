<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
 <style>
        html, body {
            margin: 0 !important;
            padding: 0 !important;
            height: 100%;
            background-color: #f8f9fa;
        }
        
        /* Estilos del Sidebar */
        .admin-sidebar {
            background: linear-gradient(135deg, #181c24 0%, #23272b 60%, #0f1014 100%);
            border-radius: 28px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.28), 0 1.5px 0 #ffb300 inset;
            padding: 2.5rem 1.5rem 2rem 1.5rem;
            min-height: 88vh;
            margin-left: 2rem;
            margin-top: 2rem;
            width: 280px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            transition: box-shadow 0.2s, background 0.2s;
        }
        
        .admin-sidebar .nav-link {
            color: #fff;
            font-size: 1.18rem;
            font-weight: 600;
            border-radius: 14px;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: background 0.18s, color 0.18s, box-shadow 0.18s, transform 0.18s;
            padding: 0.85rem 1.2rem;
            position: relative;
            box-shadow: none;
            text-decoration: none;
        }
        
        .admin-sidebar .nav-link i {
            color: #ffb300;
            font-size: 1.45rem;
            min-width: 28px;
            text-align: center;
            transition: color 0.18s, transform 0.18s;
        }
        
        .admin-sidebar .nav-link.active, .admin-sidebar .nav-link:hover {
            background: linear-gradient(90deg, #23272b 0%, #ffb30033 100%);
            color: #ffb300;
            box-shadow: 0 4px 16px rgba(255,179,0,0.10);
            transform: translateY(-2px) scale(1.03);
        }
        
        .admin-sidebar .nav-link.active i, .admin-sidebar .nav-link:hover i {
            color: #ffb300;
            transform: scale(1.18);
        }
        
        .admin-sidebar .sidebar-heading {
            font-size: 1.08rem;
            font-weight: 800;
            color: #bfc6d1;
            margin-top: 2.2rem;
            margin-bottom: 0.9rem;
            letter-spacing: 0.7px;
            border-top: 2px solid #23272b;
            padding-top: 1.3rem;
            text-transform: uppercase;
        }
        
        .admin-sidebar .sidebar-heading:first-of-type {
            border-top: none;
            padding-top: 0;
        }
        
        /* Estilos del Dashboard */
        .main-content {
            margin-left: 320px; /* Espacio para el sidebar fijo + separación */
            margin-top: 2rem;
            margin-right: 2rem;
            padding: 2.5rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            min-height: 88vh;
        }
        
        .dashboard-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #e9ecef;
        }
        
        .dashboard-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #2c3e50;
            margin: 0;
        }
        
        .dashboard-title i {
            color: #ffb300;
            margin-right: 1rem;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }
        
        .stat-card.warning {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            box-shadow: 0 8px 25px rgba(240, 147, 251, 0.3);
        }
        
        .stat-card.warning:hover {
            box-shadow: 0 15px 40px rgba(240, 147, 251, 0.4);
        }
        
        .stat-card.danger {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            color: #333;
            box-shadow: 0 8px 25px rgba(255, 154, 158, 0.3);
        }
        
        .stat-card.danger:hover {
            box-shadow: 0 15px 40px rgba(255, 154, 158, 0.4);
        }
        
        .stat-card.success {
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #333;
            box-shadow: 0 8px 25px rgba(168, 237, 234, 0.3);
        }
        
        .stat-card.success:hover {
            box-shadow: 0 15px 40px rgba(168, 237, 234, 0.4);
        }
        
        .stat-icon {
            font-size: 3rem;
            opacity: 0.9;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 1.1rem;
            font-weight: 500;
            opacity: 0.9;
        }
        
        .content-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: none;
            overflow: hidden;
        }
        
        .content-card .card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 2px solid #dee2e6;
            padding: 1.5rem;
        }
        
        .content-card .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2c3e50;
            margin: 0;
        }
        
        .content-card .card-title i {
            color: #ffb300;
            margin-right: 0.5rem;
        }
        
        .recent-item {
            border-left: 4px solid #ffb300;
            padding: 1rem 0 1rem 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .recent-item:hover {
            background: #f8f9fa;
            border-left-color: #667eea;
        }
        
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 20px;
        }
        
        .timeline-marker {
            position: absolute;
            left: -35px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        
        .timeline-item:not(:last-child)::after {
            content: '';
            position: absolute;
            left: -29px;
            top: 12px;
            width: 2px;
            height: 20px;
            background: #dee2e6;
        }
        
        .btn-action {
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
        }
        
        /* Responsive */
        @media (max-width: 991px) {
            .admin-sidebar {
                position: relative;
                width: calc(100% - 2rem);
                margin: 1rem;
                min-height: auto;
            }
            
            .main-content {
                margin-left: 1rem;
                margin-right: 1rem;
                margin-top: 1rem;
                padding: 1.5rem;
            }
            
            .dashboard-title {
                font-size: 1.8rem;
            }
            
            .stat-card {
                padding: 1.5rem;
                margin-bottom: 1rem;
            }
        }
    </style>
    <style>
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline-item {
            position: relative;
            margin-bottom: 20px;
        }
        .timeline-marker {
            position: absolute;
            left: -35px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        .timeline-item:not(:last-child)::after {
            content: '';
            position: absolute;
            left: -29px;
            top: 12px;
            width: 2px;
            height: 20px;
            background: #dee2e6;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff;">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                </h1>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group me-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-download me-1"></i>Exportar
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-print me-1"></i>Imprimir
                        </button>
                    </div>
                </div>
            </div>
            <!-- Estadísticas Principales -->
            <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="stat-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0">${totalProductos}</h4>
                                    <p class="mb-0">Total Productos</p>
                                </div>
                                <div class="stat-icon">
                                    <i class="fas fa-box"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="stat-card success">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0">${totalUsuarios}</h4>
                                    <p class="mb-0">Total Usuarios</p>
                                </div>
                                <div class="stat-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="stat-card warning">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0">${productosStockBajo}</h4>
                                    <p class="mb-0">Stock Bajo</p>
                                </div>
                                <div class="stat-icon">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="stat-card danger">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h4 class="mb-0">${productosSinStock}</h4>
                                    <p class="mb-0">Sin Stock</p>
                                </div>
                                <div class="stat-icon">
                                    <i class="fas fa-times-circle"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Contenido Principal -->
                <div class="row">
                    <!-- Productos Recientes -->
                    <div class="col-lg-8 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-box me-2"></i>Productos Recientes
                                </h5>
                            </div>
                            <div class="card-body">
                                <c:forEach items="${productos}" var="producto">
                                    <div class="recent-item">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h6 class="mb-1">${producto.nombre}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-tag me-1"></i>
                                                    ${producto.categoria.nombre}
                                                </small>
                                            </div>
                                            <div class="text-end">
                                                <span class="badge bg-primary">S/ <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/></span>
                                                <br>
                                                <small class="text-muted">Stock: ${producto.stock}</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <c:if test="${empty productos}">
                                    <div class="text-center py-3">
                                        <i class="fas fa-box-open fa-2x text-muted mb-2"></i>
                                        <p class="text-muted mb-0">No hay productos registrados</p>
                                    </div>
                                </c:if>
                                
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye me-1"></i>Ver Todos los Productos
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Actividad Reciente -->
                    <div class="col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-clock me-2"></i>Actividad Reciente
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-primary"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Nuevo producto agregado</h6>
                                            <small class="text-muted">Hace 2 horas</small>
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-success"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Venta completada</h6>
                                            <small class="text-muted">Hace 3 horas</small>
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-warning"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Stock bajo detectado</h6>
                                            <small class="text-muted">Hace 5 horas</small>
                                        </div>
                                    </div>
                                    
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-info"></div>
                                        <div class="timeline-content">
                                            <h6 class="mb-1">Nuevo usuario registrado</h6>
                                            <small class="text-muted">Hace 1 día</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Acciones Rápidas -->
                        <div class="card mt-4">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-bolt me-2"></i>Acciones Rápidas
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/productos/nuevo" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-1"></i>Agregar Producto
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-list me-1"></i>Gestionar Categorías
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-users me-1"></i>Gestionar Usuarios
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/reportes/stock" class="btn btn-outline-warning btn-sm">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Ver Stock Bajo
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline-item {
            position: relative;
            margin-bottom: 20px;
        }
        .timeline-marker {
            position: absolute;
            left: -35px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        .timeline-item:not(:last-child)::after {
            content: '';
            position: absolute;
            left: -29px;
            top: 12px;
            width: 2px;
            height: 20px;
            background: #dee2e6;
        }
    </style>
</body>
</html> 