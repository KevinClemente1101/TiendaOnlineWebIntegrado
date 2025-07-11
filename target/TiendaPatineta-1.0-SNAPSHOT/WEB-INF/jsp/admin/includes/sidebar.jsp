<nav id="sidebarMenu" class="admin-sidebar">
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
                    Categorias
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
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/proveedores">
                    <i class="fas fa-truck me-2"></i>Proveedores
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
                    Ventas por Periodo
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/reportes/productos">
                    <i class="fas fa-chart-bar me-2"></i>
                    Productos Mas Vendidos
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
            <span>Configuracion</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/perfil">
                    <i class="fas fa-user-cog"></i> Mi Perfil
                </a>
            </li>
          
        </ul>
    </div>
</nav> 
<style>
.admin-sidebar {
    background: linear-gradient(135deg, #181c24 0%, #23272b 60%, #0f1014 100%);
    border-radius: 28px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.28), 0 1.5px 0 #ffb300 inset;
    padding: 2.5rem 1.5rem 2rem 1.5rem;
    min-height: 92vh;
    margin-left: 1.5rem;
    width: 270px;
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
.admin-sidebar hr {
    border: none;
    border-top: 2px solid #23272b;
    margin: 1.2rem 0;
}
@media (max-width: 991px) {
    .admin-sidebar {
        padding: 1rem 0.3rem;
        min-height: auto;
        width: 100%;
        margin-left: 0;
        border-radius: 18px;
    }
    .admin-sidebar .nav-link { font-size: 1rem; padding: 0.6rem 0.7rem; }
}
</style>
<script>
// Agregar la clase admin-sidebar al sidebar
window.addEventListener('DOMContentLoaded', function() {
    var sidebar = document.getElementById('sidebarMenu');
    if(sidebar) sidebar.classList.add('admin-sidebar');
});
</script> 