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
    <jsp:include page="WEB-INF/jsp/includes/header.jsp" />
    <div class="w-100 text-center" style="background: #222;">
        <img src="${pageContext.request.contextPath}/uploads/banner.webp"
         alt="Banner"
         style="width:100%; max-width:100vw; height:600px; object-fit:cover; object-position:center;">
    </div>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-4">
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
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="Logo" style="height:70px; margin-right:16px; vertical-align:middle;"> House of skate
        </a>
                  
                    <p class="mb-0">Las mejores patinetas y accesorios para todos los niveles.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h6>Contacto</h6>
                    <p class="mb-1">
                        <i class="fas fa-phone me-2"></i>+51 908 503 404
                    </p>
                    <p class="mb-1">
                        <i class="fas fa-envelope me-2"></i>HauseofSkate@gmail.com
                    </p>
                    <p class="mb-0">
                        <i class="fas fa-map-marker-alt me-2"></i>Lima, Perú
                    </p>
                </div>
            </div>
            <hr class="my-3">
            <div class="text-center">
                <small>&copy; 2024 House of Skate. Todos los derechos reservados.</small>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
document.addEventListener('DOMContentLoaded', function() {
    function attachCarritoListeners() {
        document.querySelectorAll('form[action$="/carrito/agregar"]').forEach(function(form) {
            if (form.dataset.listenerAttached) return;
            form.dataset.listenerAttached = 'true';
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                const formData = new FormData(form);
                // Mostrar en consola los datos enviados
                for (let pair of formData.entries()) {
                    console.log(pair[0]+ ': ' + pair[1]);
                }
                // Enviar como application/x-www-form-urlencoded
                const params = new URLSearchParams();
                params.append('productoId', formData.get('productoId'));
                params.append('cantidad', formData.get('cantidad'));
                fetch(form.action, {
                    method: 'POST',
                    body: params,
                    credentials: 'same-origin',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                })
                .then(response => {
                    if (response.ok) {
                        mostrarToast('Producto agregado al carrito');
                    } else {
                        response.text().then(text => {
                            mostrarToast('No se pudo agregar al carrito: ' + text, true);
                        });
                    }
                })
                .catch(() => mostrarToast('Error de conexión', true));
            });
        });
    }
    attachCarritoListeners();
    function mostrarToast(mensaje, error) {
        let toast = document.getElementById('toast-carrito');
        if (!toast) {
            toast = document.createElement('div');
            toast.id = 'toast-carrito';
            toast.className = 'toast align-items-center text-white ' + (error ? 'bg-danger' : 'bg-success') + ' border-0 position-fixed top-0 end-0 m-4';
            toast.style.zIndex = 9999;
            toast.innerHTML = `<div class=\"d-flex\"><div class=\"toast-body\">${mensaje}</div><button type=\"button\" class=\"btn-close btn-close-white me-2 m-auto\" data-bs-dismiss=\"toast\"></button></div>`;
            document.body.appendChild(toast);
        } else {
            toast.querySelector('.toast-body').textContent = mensaje;
            toast.className = 'toast align-items-center text-white ' + (error ? 'bg-danger' : 'bg-success') + ' border-0 position-fixed top-0 end-0 m-4';
        }
        const bsToast = new bootstrap.Toast(toast, { delay: 2000 });
        bsToast.show();
    }
});
    </script>
</body>
</html> 