<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/admin/includes/header.jsp" />
<div style="display: flex; min-height: 100vh;">
  <jsp:include page="/WEB-INF/jsp/admin/includes/sidebar.jsp" />
  <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff; display: flex; align-items: flex-start; justify-content: center;">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
.perfil-card {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 2px 16px rgba(102,126,234,0.10);
    padding: 2.5rem 2rem 2rem 2rem;
    margin-bottom: 2rem;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
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
    color: #222;
    text-align: center;
    margin-bottom: 1.5rem;
}
.perfil-form label {
    font-weight: 600;
    color: #667eea;
}
.perfil-form .form-control {
    border-radius: 12px;
    border: 2px solid #e9ecef;
    padding: 12px 15px;
    margin-bottom: 1rem;
    font-size: 1.05rem;
    transition: border 0.2s;
}
.perfil-form .form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.10);
}
.perfil-form .btn-primary, .perfil-form .btn-warning {
    border-radius: 12px;
    font-weight: 700;
    padding: 10px 0;
    width: 100%;
    margin-bottom: 1rem;
}
.alert-success, .alert-danger {
    border-radius: 12px;
    font-size: 1.05rem;
    text-align: center;
}
@media (max-width: 768px) {
    .perfil-card { padding: 1.2rem 0.5rem; }
    .perfil-title { font-size: 1.2rem; }
}
</style>
</body>
</html> 