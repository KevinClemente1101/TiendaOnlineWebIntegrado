<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${usuario != null ? 'Editar' : 'Nuevo'} Usuario - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container-fluid">
        <div class="row">
            <jsp:include page="../includes/sidebar.jsp" />
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-${usuario != null ? 'edit' : 'plus'} me-2"></i>
                        ${usuario != null ? 'Editar' : 'Nuevo'} Usuario
                    </h1>
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Volver
                    </a>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="form-container">
                            <form action="${pageContext.request.contextPath}/admin/usuarios${usuario != null ? '/editar?id='.concat(usuario.id) : '/nuevo'}" method="post" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false">
                                <c:if test="${usuario != null}">
                                    <input type="hidden" name="id" value="${usuario.id}" />
                                </c:if>
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">
                                        <i class="fas fa-user me-2"></i>Nombre *
                                    </label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" value="${usuario != null ? usuario.nombre : ''}" required autocomplete="off" />
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email *
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" value="${usuario != null ? usuario.email : ''}" required autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" />
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Password *
                                    </label>
                                    <input type="password" class="form-control" id="password" name="password" value="${usuario != null ? usuario.password : ''}" required autocomplete="new-password" autocorrect="off" autocapitalize="off" spellcheck="false" />
                                </div>
                                <div class="mb-3">
                                    <label for="rol" class="form-label">
                                        <i class="fas fa-user-tag me-2"></i>Rol *
                                    </label>
                                    <select class="form-select" id="rol" name="rol" required>
                                        <option value="">Selecciona un rol</option>
                                        <option value="admin" ${usuario != null && usuario.rol == 'admin' ? 'selected' : ''}>Administrador</option>
                                        <option value="user" ${usuario != null && usuario.rol == 'user' ? 'selected' : ''}>Usuario</option>
                                    </select>
                                </div>
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Cancelar
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>
                                        ${usuario != null ? 'Actualizar' : 'Guardar'} Usuario
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 