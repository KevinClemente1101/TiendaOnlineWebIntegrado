<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <jsp:include page="includes/header.jsp" />
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="perfil-card">
                <h2 class="mb-4 perfil-title"><i class="fas fa-user-cog me-2"></i>Mi Perfil</h2>
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-success">${mensaje}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <form method="post" action="perfil" class="perfil-form">
                    <input type="hidden" name="accion" value="actualizarPerfil" />
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" value="${usuario.nombre}" required />
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo</label>
                        <input type="email" class="form-control" id="correo" name="correo" value="${usuario.email}" required pattern="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono" value="${usuario.telefono}" required pattern="^9\d{8}$" maxlength="9" />
                    </div>
                    <div class="mb-3">
                        <label for="distrito" class="form-label">Distrito</label>
                        <input type="text" class="form-control" id="distrito" name="distrito" value="${usuario.distrito}" required />
                    </div>
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion" value="${usuario.direccion}" required />
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar Perfil</button>
                </form>
                <hr />
                <h4 class="mb-3">Cambiar Contraseña</h4>
                <form method="post" action="perfil" class="perfil-form">
                    <input type="hidden" name="accion" value="cambiarContrasena" />
                    <div class="mb-3">
                        <label for="actual" class="form-label">Contraseña Actual</label>
                        <input type="password" class="form-control" id="actual" name="actual" required />
                    </div>
                    <div class="mb-3">
                        <label for="nueva" class="form-label">Nueva Contraseña</label>
                        <input type="password" class="form-control" id="nueva" name="nueva" required pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=]{8,}$" />
                        <div class="form-text">Mínimo 8 caracteres, al menos una letra y un número.</div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmar" class="form-label">Confirmar Nueva Contraseña</label>
                        <input type="password" class="form-control" id="confirmar" name="confirmar" required />
                    </div>
                    <button type="submit" class="btn btn-warning">Cambiar Contraseña</button>
                </form>
            </div>
        </div>
    </div>
</div>
<style>
.perfil-card {
    background: #181c24;
    border-radius: 18px;
    box-shadow: 0 2px 16px rgba(0,255,193,0.10);
    padding: 2.5rem 2rem 2rem 2rem;
    margin-bottom: 2rem;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
    color: #fff;
}
.perfil-avatar {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1.2rem;
    border: 4px solid #667eea;
    background: #f3f3f3;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.perfil-title {
    font-size: 2rem;
    font-weight: 800;
    color: #0fffc1;
    text-align: center;
    margin-bottom: 1.5rem;
}
.perfil-form label {
    font-weight: 600;
    color: #0fffc1;
}
.perfil-form .form-control {
    border-radius: 12px;
    border: 2px solid #0fffc1;
    padding: 12px 15px;
    margin-bottom: 1rem;
    font-size: 1.05rem;
    background: #23272b;
    color: #fff;
    transition: border 0.2s, background 0.2s, color 0.2s;
}
.perfil-form .form-control:focus {
    border-color: #7e30e1;
    box-shadow: 0 0 0 0.2rem rgba(126, 48, 225, 0.10);
    background: #181c24;
    color: #0fffc1;
}
.perfil-form .btn-primary {
    border-radius: 12px;
    font-weight: 700;
    padding: 10px 0;
    width: 100%;
    margin-bottom: 1rem;
    background: #0fffc1;
    color: #181c24;
    border: none;
    box-shadow: 0 2px 8px rgba(0,255,193,0.10);
    transition: background 0.2s, color 0.2s;
}
.perfil-form .btn-primary:hover {
    background: #7e30e1;
    color: #fff;
}
.perfil-form .btn-warning {
    border-radius: 12px;
    font-weight: 700;
    padding: 10px 0;
    width: 100%;
    margin-bottom: 1rem;
    background: #7e30e1;
    color: #fff;
    border: none;
    box-shadow: 0 2px 8px rgba(126,48,225,0.10);
    transition: background 0.2s, color 0.2s;
}
.perfil-form .btn-warning:hover {
    background: #0fffc1;
    color: #181c24;
}
.alert-success, .alert-danger {
    border-radius: 12px;
    font-size: 1.05rem;
    text-align: center;
}
body, .bg-light {
    background: #23272b !important;
}
@media (max-width: 768px) {
    .perfil-card { padding: 1.2rem 0.5rem; }
    .perfil-title { font-size: 1.2rem; }
}
</style> 