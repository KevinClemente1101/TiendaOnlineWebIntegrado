<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${proveedor != null ? 'Editar' : 'Nuevo'} Proveedor - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="../includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff; display: flex; align-items: flex-start; justify-content: center;">
            <div style="width: 100%; max-width: 540px;">
                <div class="form-container">
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .form-container {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.08);
            padding: 2.5rem 2rem 2rem 2rem;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .form-label {
            font-weight: 700;
            font-size: 1.08rem;
            color: #333;
            margin-bottom: 0.4rem;
        }
        .form-control {
            border-radius: 12px;
            border: 2px solid #e9ecef;
            background: #fff;
            color: #333;
            padding: 12px 15px;
            font-size: 1.05rem;
            transition: border 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.12);
            background: #fff;
            color: #333;
        }
        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 12px;
            font-weight: 700;
            padding: 12px 0;
            width: auto;
            min-width: 180px;
            color: #fff;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 2px 8px rgba(102,126,234,0.08);
        }
        .btn-primary:hover {
            background: linear-gradient(45deg, #764ba2, #667eea);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102,126,234,0.18);
        }
        .btn-secondary {
            border-radius: 12px;
            font-weight: 600;
            padding: 12px 0;
            min-width: 140px;
            color: #333;
            background: #f3f3f3;
            border: 1.5px solid #e9ecef;
            transition: all 0.2s;
        }
        .btn-secondary:hover {
            background: #e9ecef;
            color: #222;
        }
        @media (max-width: 700px) {
            .form-container { padding: 1.2rem 0.5rem; }
            .form-label, .form-control { font-size: 0.98rem; }
        }
    </style>
</body>
</html> 