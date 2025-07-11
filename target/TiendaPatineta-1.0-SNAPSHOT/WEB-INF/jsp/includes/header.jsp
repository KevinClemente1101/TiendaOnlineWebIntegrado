<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tienda de Patinetas</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
.navbar {
    background: #23272b !important;
    box-shadow: 0 2px 12px rgba(15,255,193,0.10);
    font-family: 'Montserrat', 'Segoe UI', 'Roboto', Arial, sans-serif;
}
.navbar .navbar-brand {
    font-size: 1.6rem;
    font-weight: 900;
    letter-spacing: 1px;
    color: #0fffc1 !important;
    display: flex;
    align-items: center;
    gap: 0.7rem;
}
.navbar .navbar-nav .nav-link {
    color: #0fffc1 !important;
    font-size: 1.1rem;
    font-weight: 600;
    margin-right: 0.7rem;
    transition: color 0.2s, background 0.2s;
    border-radius: 8px;
    padding: 0.5rem 1rem;
}
.navbar .navbar-nav .nav-link.active, .navbar .navbar-nav .nav-link:hover {
    color: #23272b !important;
    background: #0fffc1;
}
.navbar .dropdown-menu {
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(15,255,193,0.10);
    font-size: 1rem;
    background: #181c24;
    color: #0fffc1;
}
.navbar .dropdown-item {
    color: #0fffc1;
    font-weight: 600;
    transition: background 0.2s, color 0.2s;
}
.navbar .dropdown-item:hover, .navbar .dropdown-item:focus {
    background: #0fffc1;
    color: #181c24;
}
.navbar .fa, .navbar .fas, .navbar .far, .navbar .fab {
    color: #0fffc1 !important;
}
</style>
</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="Logo" style="height:50px; margin-right:16px; vertical-align:middle;"> House of skate
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavCliente">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavCliente">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/#productos">Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contacto">Contactanos</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/carrito/ver">
                                <i class="fas fa-shopping-cart me-2 fs-5"></i>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/perfil">
                                <i class="fas fa-user me-2 fs-5"></i>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCliente" role="button" data-bs-toggle="dropdown">
                                ${sessionScope.usuarioNombre}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/historial">
                                        <i class="fas fa-history me-2"></i>Mis Compras
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2 fs-5"></i>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Iniciar Sesion
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