<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="${sessionScope.rol eq 'admin' ? '/WEB-INF/jsp/admin/includes/header.jsp' : '/WEB-INF/jsp/includes/header.jsp'}" />
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4"><i class="fas fa-user-cog me-2"></i>Mi Perfil</h2>
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success">${mensaje}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form method="post" action="perfil">
                <input type="hidden" name="accion" value="actualizarPerfil" />
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="${usuario.nombre}" required />
                </div>
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo</label>
                    <input type="email" class="form-control" id="correo" name="correo" value="${usuario.correo}" required pattern="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
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
            <form method="post" action="perfil">
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
<jsp:include page="${sessionScope.rol eq 'admin' ? '/WEB-INF/jsp/admin/includes/sidebar.jsp' : ''}" /> 