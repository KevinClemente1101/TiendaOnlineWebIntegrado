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
                        <i class="fas fa-${categoria != null ? 'edit' : 'plus'} me-2"></i>
                        ${categoria != null ? 'Editar' : 'Nueva'} Categoría
                    </h1>
                    <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Volver
                    </a>
                </div>
                <div class="row justify-content-center">
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
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 