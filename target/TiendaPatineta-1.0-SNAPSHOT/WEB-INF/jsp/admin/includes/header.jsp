<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class=""></i>House Of Skate - Admin
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/productos">
                        <i class="fas fa-box me-1"></i>Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/categorias">
                        <i class="fas fa-list me-1"></i>Categorias
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/ventas">
                        <i class="fas fa-shopping-cart me-1"></i>Ventas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/usuarios">
                        <i class="fas fa-users me-1"></i>Usuarios
                    </a>
                </li>
            </ul>
            
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                       data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle me-1"></i>${sessionScope.usuarioNombre}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/perfil">
                                <i class="fas fa-user me-2"></i>Mi Perfil
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                    
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesion
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav> 
<style>
.admin-navbar {
    background: #23272b !important;
    box-shadow: 0 2px 12px rgba(102,126,234,0.10);
    min-height: 64px;
}
.admin-navbar .navbar-brand {
    font-size: 1.6rem;
    font-weight: 800;
    letter-spacing: 0.5px;
    color: #fff !important;
    display: flex;
    align-items: center;
    gap: 0.7rem;
}
.admin-navbar .navbar-nav .nav-link {
    color: #d1d5db !important;
    font-size: 1.1rem;
    font-weight: 500;
    margin-right: 0.7rem;
    transition: color 0.2s;
}
.admin-navbar .navbar-nav .nav-link.active, .admin-navbar .navbar-nav .nav-link:hover {
    color: #667eea !important;
}
.admin-navbar .dropdown-menu {
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(102,126,234,0.10);
    font-size: 1rem;
}
.admin-navbar .dropdown-item:hover, .admin-navbar .dropdown-item:focus {
    background: #f3f4f6;
    color: #667eea;
}
body {
    padding-top: 70px !important; /* Ajusta según la altura real de la navbar */
}
</style>
<script>
// Agregar la clase admin-navbar al navbar
window.addEventListener('DOMContentLoaded', function() {
    var nav = document.querySelector('.navbar');
    if(nav) nav.classList.add('admin-navbar');
});
</script> 