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
        body {
            background: #fff;
            font-family: 'Montserrat', 'Segoe UI', 'Roboto', Arial, sans-serif;
            color: #f3f3f3;
        }
        .hero-section {
            background: linear-gradient(120deg, #0fffc1 0%, #7e30e1 100%);
            color: #181c24;
            padding: 5rem 0 3rem 0;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.18);
            border-radius: 0 0 40px 40px;
            margin-bottom: 2rem;
        }
        .hero-section h1 {
            font-size: 3.2rem;
            font-weight: 900;
            text-shadow: 0 4px 24px rgba(0,0,0,0.10);
            letter-spacing: 2px;
        }
        .hero-section p {
            font-size: 1.3rem;
            font-weight: 400;
            margin-bottom: 2rem;
        }
        .btn-light.btn-lg {
            font-size: 1.2rem;
            font-weight: 700;
            border-radius: 30px;
            padding: 0.8rem 2.5rem;
            background: #181c24;
            color: #0fffc1;
            border: 2px solid #0fffc1;
            box-shadow: 0 2px 8px rgba(126,48,225,0.15);
            transition: background 0.2s, color 0.2s, border 0.2s;
        }
        .btn-light.btn-lg:hover {
            background: #0fffc1;
            color: #181c24;
            border: 2px solid #181c24;
        }
        .category-filter {
            background: #23272b;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 16px rgba(0,255,193,0.07);
            margin-bottom: 1rem;
        }
        .category-filter h5 {
            font-weight: 800;
            color: #0fffc1;
            letter-spacing: 1px;
        }
        .category-filter .btn {
            border-radius: 20px;
            font-weight: 600;
            margin-bottom: 0.3rem;
            background: #181c24;
            color: #0fffc1;
            border: 1.5px solid #0fffc1;
            transition: background 0.2s, color 0.2s, border 0.2s;
        }
        .category-filter .btn:hover {
            background: #0fffc1;
            color: #181c24;
            border: 1.5px solid #7e30e1;
        }
        .product-card {
            transition: transform 0.25s cubic-bezier(.4,2,.6,1), box-shadow 0.25s;
            border: none;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 16px rgba(255, 0, 255, 0.10);
            background: #23272b;
        }
        .product-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 8px 32px rgba(255, 0, 255, 0.18);
            z-index: 2;
        }
        .product-image {
            height: 260px;
            object-fit: cover;
            border-radius: 18px 18px 0 0;
            background: #181c24;
        }
        .precio-card {
            display: inline-block;
            background: #181c24;
            border-radius: 22px;
            padding: 0.4em 1.2em;
            font-size: 1.3rem;
            font-weight: 800;
            box-shadow: 0 2px 12px rgba(0,255,193,0.10);
        }
        .precio-card .precio-num {
            color: #0fffc1;
            font-weight: 900;
            font-size: 1.3rem;
        }
        .stock-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            font-size: 0.95rem;
            padding: 6px 14px;
            border-radius: 16px;
            font-weight: 700;
            background: #ff6b6b;
            color: #fff;
            border: 2px solid #0fffc1;
        }
        .btn-add-cart {
            background: linear-gradient(90deg, #0fffc1 0%, #7e30e1 100%);
            border: none;
            border-radius: 25px;
            padding: 12px 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: #181c24;
            box-shadow: 0 2px 8px rgba(0,255,193,0.10);
            transition: background 0.2s, transform 0.2s;
        }
        .btn-add-cart:hover {
            background: linear-gradient(90deg, #7e30e1 0%, #0fffc1 100%);
            color: #fff;
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 4px 16px rgba(255, 0, 255, 0.18);
        }
        .card-title {
            font-weight: 800;
            font-size: 1.2rem;
            color: #0fffc1;
            letter-spacing: 1px;
        }
        .card-text {
            font-size: 1rem;
            color: #bfc6d1;
        }
        .badge.bg-secondary {
            background: #7e30e1 !important;
            color: #fff !important;
            font-weight: 700;
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
        }
        .footer {
            background: linear-gradient(90deg, #181c24 0%, #7e30e1 100%);
            color: #fff;
            padding: 2.5rem 0 1rem 0;
            border-radius: 40px 40px 0 0;
            margin-top: 3rem;
            box-shadow: 0 -4px 24px rgba(31, 38, 135, 0.10);
        }
        .footer h5, .footer h6 {
            color: #0fffc1;
            font-weight: 800;
        }
        .footer p, .footer small {
            color: #bfc6d1;
        }
        .footer .fa {
            color: #0fffc1;
        }
        .footer-modern {
            background: #181c24;
            color: #fff;
            padding: 2.5rem 0 1rem 0;
            border-radius: 40px 40px 0 0;
            margin-top: 3rem;
            box-shadow: 0 -4px 24px rgba(31, 38, 135, 0.10);
        }
        @media (max-width: 768px) {
            .hero-section {
                padding: 2.5rem 0 1.5rem 0;
                border-radius: 0 0 24px 24px;
            }
            .product-image {
                height: 180px;
            }
            .footer {
                border-radius: 24px 24px 0 0;
                padding: 1.5rem 0 0.5rem 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="WEB-INF/jsp/includes/header.jsp" />
    <div class="w-100 text-center" style="background: #222;">
        <img src="${pageContext.request.contextPath}/uploads/banner2.webp"
             alt="Banner"
             style="display:block; width:100vw; height:600px; object-fit:cover; object-position:center; margin:0; padding:0;">
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
                                        <span class="precio-card">
                                            <span class="precio-num">S/ <fmt:formatNumber value="${producto.precio}" pattern="#,##0.00"/></span>
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
    <footer class="footer-modern" id="contacto">
        <div class="container">
            <div class="row align-items-center gy-4">
                <div class="col-md-6 d-flex align-items-center gap-3">
                    <img src="${pageContext.request.contextPath}/uploads/logo_1.png" alt="Logo" style="height:70px; border-radius:16px; box-shadow:0 2px 12px #0fffc1;">
                    <div>
                        <h5 class="mb-1 fw-bold" style="color:#0fffc1; letter-spacing:1px;">House of skate</h5>
                        <p class="mb-0" style="color:#fff; font-weight:500;">Las mejores patinetas y accesorios para todos los niveles.</p>
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <h6 class="fw-bold mb-3" style="color:#0fffc1; letter-spacing:1px;">Contacto</h6>
                    <p class="mb-1 fs-5"><i class="fas fa-phone me-2" style="color:#7e30e1;"></i><span style="color:#fff; font-weight:600;">+51 908 503 404</span></p>
                    <p class="mb-1 fs-5"><i class="fas fa-envelope me-2" style="color:#7e30e1;"></i><span style="color:#fff; font-weight:600;">HauseofSkate@gmail.com</span></p>
                    <p class="mb-0 fs-5"><i class="fas fa-map-marker-alt me-2" style="color:#7e30e1;"></i><span style="color:#fff; font-weight:600;">Lima, Perú</span></p>
                </div>
            </div>
            <hr class="my-3" style="border-color:rgba(0,255,193,0.18);">
            <div class="text-center">
                <small style="color:#0fffc1; font-weight:600;">&copy; 2024 House of Skate. Todos los derechos reservados.</small>
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