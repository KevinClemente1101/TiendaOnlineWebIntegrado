<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${categoria != null ? 'Editar' : 'Nueva'} Categoría - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-wrapper-center {
            min-height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .form-container {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.08);
            padding: 2.5rem 2rem 2rem 2rem;
            margin: 0 auto;
            max-width: 420px;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .form-label {
            font-weight: 700;
            color: #333;
            font-size: 1.08rem;
            margin-bottom: 0.4rem;
        }
        .form-control {
            border-radius: 12px;
            border: 2px solid #e9ecef;
            padding: 14px 16px;
            font-size: 1.08rem;
            font-weight: 600;
            background: #fff;
            color: #333;
            transition: border 0.2s, box-shadow 0.2s, background 0.2s;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.18rem rgba(102,126,234,0.12);
            background: #fff;
            color: #333;
        }
        .form-container .btn {
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
        }
        .form-container .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: #fff;
            border: none;
            transition: background 0.2s, color 0.2s;
            min-width: 160px;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 2px 8px rgba(102,126,234,0.08);
        }
        .form-container .btn-primary:hover {
            background: linear-gradient(45deg, #764ba2, #667eea);
            color: #fff;
            box-shadow: 0 4px 15px rgba(102,126,234,0.18);
        }
        .form-container .btn-secondary {
            background: #f3f3f3;
            color: #333;
            border: 1.5px solid #e9ecef;
            transition: background 0.2s, color 0.2s;
            min-width: 120px;
        }
        .form-container .btn-secondary:hover {
            background: #e9ecef;
            color: #222;
        }
        @media (max-width: 700px) {
            .form-container { padding: 1.2rem 0.5rem; max-width: 98vw; }
            .form-label, .form-control { font-size: 0.98rem; }
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div style="display: flex; min-height: 100vh;">
        <jsp:include page="../includes/sidebar.jsp" />
        <div style="flex: 1; padding: 2.5rem 2rem 2rem 2rem; background: #fff;">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">
                    <i class="fas fa-${categoria != null ? 'edit' : 'plus'} me-2"></i>
                    ${categoria != null ? 'Editar' : 'Nueva'} Categoría
                </h1>
                <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Volver
                </a>
            </div>
            <div class="row justify-content-center form-wrapper-center">
                <div class="col-lg-6">
                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/admin/categorias${categoria != null ? '/editar?id='.concat(categoria.id) : '/nueva'}" method="post">
                            <c:if test="${categoria != null}">
                                <input type="hidden" name="id" value="${categoria.id}" />
                            </c:if>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">
                                    <i class="fas fa-tag me-2"></i>Nombre de la Categoría *
                                </label>
                                <input type="text" class="form-control" id="nombre" name="nombre" value="${categoria != null ? categoria.nombre : ''}" required />
                            </div>
                            <div class="d-flex gap-2 justify-content-end">
                                <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>
                                    ${categoria != null ? 'Actualizar' : 'Guardar'} Categoría
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