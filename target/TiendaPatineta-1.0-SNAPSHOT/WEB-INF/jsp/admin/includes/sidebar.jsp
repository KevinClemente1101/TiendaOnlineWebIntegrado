<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('productos') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/productos">
                    <i class="fas fa-box me-2"></i>
                    Productos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('categorias') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/categorias">
                    <i class="fas fa-list me-2"></i>
                    Categorías
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('ventas') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/ventas">
                    <i class="fas fa-shopping-cart me-2"></i>
                    Ventas
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.requestURI.contains('usuarios') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/usuarios">
                    <i class="fas fa-users me-2"></i>
                    Usuarios
                </a>
            </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Reportes</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reportes/ventas">
                    <i class="fas fa-chart-line me-2"></i>
                    Ventas por Período
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reportes/productos">
                    <i class="fas fa-chart-bar me-2"></i>
                    Productos Más Vendidos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reportes/stock">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Stock Bajo
                </a>
            </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Configuración</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/configuracion">
                    <i class="fas fa-cog me-2"></i>
                    Configuración General
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/backup">
                    <i class="fas fa-database me-2"></i>
                    Backup
                </a>
            </li>
        </ul>
    </div>
</nav> 