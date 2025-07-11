<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${proveedor != null ? 'Editar' : 'Nuevo'} Proveedor - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="mb-4 text-center">
                            <i class="fas fa-truck me-2"></i>${proveedor != null ? 'Editar' : 'Nuevo'} Proveedor
                        </h2>
                        <form action="${pageContext.request.contextPath}/admin/proveedores${proveedor != null ? '/editar' : ''}" method="post">
                            <c:if test="${proveedor != null}">
                                <input type="hidden" name="id" value="${proveedor.id}" />
                            </c:if>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre *</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" value="${proveedor != null ? proveedor.nombre : ''}" required maxlength="100">
                            </div>
                            <div class="mb-3">
                                <label for="ruc" class="form-label">RUC *</label>
                                <input type="text" class="form-control" id="ruc" name="ruc" value="${proveedor != null ? proveedor.ruc : ''}" required maxlength="11" minlength="11" pattern="[0-9]{11}">
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono *</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" value="${proveedor != null ? proveedor.telefono : ''}" required maxlength="15">
                            </div>
                            <div class="mb-3">
                                <label for="productos" class="form-label">Productos *</label>
                                <input type="text" class="form-control" id="productos" name="productos" value="${proveedor != null ? proveedor.productos : ''}" required maxlength="255">
                            </div>
                            <div class="d-flex gap-2 justify-content-end">
                                <a href="${pageContext.request.contextPath}/admin/proveedores" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>${proveedor != null ? 'Actualizar' : 'Guardar'} Proveedor
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 