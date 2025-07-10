<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda de Patinetas - Perú</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
        }
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .product-image {
            height: 250px;
            object-fit: cover;
        }
        .price-tag {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
        }
        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .category-filter {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .btn-add-cart {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-skating me-2"></i>Tienda de Patinetas
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#productos">Productos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contacto">Contacto</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuario}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                                   data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i>${sessionScope.usuarioNombre}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <c:if test="${sessionScope.usuarioRol == 'admin'}">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                                <i class="fas fa-tachometer-alt me-2"></i>Panel Admin
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/carrito/ver">
                                            <i class="fas fa-shopping-cart me-2"></i>Mi Carrito
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/mis-compras">
                                            <i class="fas fa-history me-2"></i>Mis Compras
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                            <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Iniciar Sesión
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/registro">
                                    <i class="fas fa-user-plus me-1"></i>Registrarse
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-4">
                <i class="fas fa-skating me-3"></i>
                Las Mejores Patinetas del Perú
            </h1>
            <p class="lead mb-4">
                Descubre nuestra colección de patinetas profesionales, longboards y accesorios. 
                Calidad y estilo para todos los niveles.
            </p>
            <a href="#productos" class="btn btn-light btn-lg">
                <i class="fas fa-shopping-bag me-2"></i>Ver Productos
            </a>
        </div>
    </section>

    <!-- Filtros y Productos -->
    <section id="productos" class="py-5">
        <div class="container">
            <!-- Filtros -->
            <div class="row mb-4">
                <div class="col-md-8">
                    <div class="category-filter">
                        <h5 class="mb-3">
                            <i class="fas fa-filter me-2"></i>Filtrar por Categoría
                        </h5>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary btn-sm">
                                Todas
                            </a>
                            <c:forEach items="${categorias}" var="categoria">
                                <a href="${pageContext.request.contextPath}/?categoria=${categoria.id}" 
                                   class="btn btn-outline-primary btn-sm">
                                    ${categoria.nombre}
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-filter">
                        <h5 class="mb-3">
                            <i class="fas fa-search me-2"></i>Buscar
                        </h5>
                        <form action="${pageContext.request.contextPath}/" method="get" class="d-flex">
                            <input type="text" name="buscar" class="form-control me-2" 
                                   placeholder="Buscar productos..." value="${param.buscar}">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Productos -->
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
                                            <i class="fas fa-image fa-4x text-muted"></i>
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
                                <p class="card-text text-muted">
                                    ${producto.descripcion.length() > 100 ? 
                                      producto.descripcion.substring(0, 100).concat('...') : 
                                      producto.descripcion}
                                </p>
                                
                                <div class="mt-auto">
                                    <c:if test="${not empty producto.categoria}">
                                        <span class="badge bg-secondary mb-2">
                                            ${producto.categoria.nombre}
                                        </span>
                                    </c:if>
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="price-tag">
                                            S/ <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/>
                                        </span>
                                        <small class="text-muted">
                                            Stock: ${producto.stock}
                                        </small>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${producto.stock > 0}">
                                            <form action="${pageContext.request.contextPath}/carrito/agregar" method="post" class="d-grid">
                                                <input type="hidden" name="productoId" value="${producto.id}" />
                                                <input type="hidden" name="cantidad" value="1" />
                                                <button type="submit" class="btn btn-primary btn-add-cart w-100">
                                                    <i class="fas fa-cart-plus me-2"></i>Agregar al Carrito
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-secondary w-100" disabled>
                                                <i class="fas fa-times me-2"></i>Sin Stock
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty productos}">
                <div class="text-center py-5">
                    <i class="fas fa-search fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">No se encontraron productos</h4>
                    <p class="text-muted">Intenta con otros filtros o términos de búsqueda</p>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4" id="contacto">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>
                        <i class="fas fa-skating me-2"></i>Tienda de Patinetas
                    </h5>
                    <p class="mb-0">Las mejores patinetas y accesorios para todos los niveles.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h6>Contacto</h6>
                    <p class="mb-1">
                        <i class="fas fa-phone me-2"></i>+51 999 999 999
                    </p>
                    <p class="mb-1">
                        <i class="fas fa-envelope me-2"></i>info@tiendapatineta.com
                    </p>
                    <p class="mb-0">
                        <i class="fas fa-map-marker-alt me-2"></i>Lima, Perú
                    </p>
                </div>
            </div>
            <hr class="my-3">
            <div class="text-center">
                <small>&copy; 2024 Tienda de Patinetas. Todos los derechos reservados.</small>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función de agregar al carrito eliminada, ahora se usa formulario real
    </script>
</body>
</html> 