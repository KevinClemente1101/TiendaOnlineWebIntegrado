<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${producto != null ? 'Editar' : 'Nuevo'} Producto - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            border-radius: 10px;
            object-fit: cover;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
        }
        .form-control:focus, .form-select:focus {
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
                        <i class="fas fa-${producto != null ? 'edit' : 'plus'} me-2"></i>
                        ${producto != null ? 'Editar' : 'Nuevo'} Producto
                    </h1>
                    <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Volver
                    </a>
                </div>
                
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="form-container">
                            <form action="${pageContext.request.contextPath}/admin/productos${producto != null ? '/actualizar/'.concat(producto.id) : ''}" 
                                  method="post" enctype="multipart/form-data">
                                
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">
                                                <i class="fas fa-tag me-2"></i>Nombre del Producto *
                                            </label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" 
                                                   value="${producto.nombre}" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="descripcion" class="form-label">
                                                <i class="fas fa-align-left me-2"></i>Descripción
                                            </label>
                                            <textarea class="form-control" id="descripcion" name="descripcion" 
                                                      rows="4">${producto.descripcion}</textarea>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="precio" class="form-label">
                                                        <i class="fas fa-dollar-sign me-2"></i>Precio (S/) *
                                                    </label>
                                                    <input type="number" class="form-control" id="precio" name="precio" 
                                                           value="${producto.precio}" step="0.01" min="0" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="stock" class="form-label">
                                                        <i class="fas fa-boxes me-2"></i>Stock *
                                                    </label>
                                                    <input type="number" class="form-control" id="stock" name="stock" 
                                                           value="${producto.stock}" min="0" required>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="categoria_id" class="form-label">
                                                <i class="fas fa-list me-2"></i>Categoría *
                                            </label>
                                            <select class="form-select" id="categoria_id" name="categoria_id" required>
                                                <option value="">Selecciona una categoría</option>
                                                <c:forEach items="${categorias}" var="categoria">
                                                    <option value="${categoria.id}" 
                                                            ${producto.categoriaId == categoria.id ? 'selected' : ''}>
                                                        ${categoria.nombre}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="mb-3">
                                            <label for="imagen" class="form-label">
                                                <i class="fas fa-image me-2"></i>Imagen del Producto
                                            </label>
                                            <input type="file" class="form-control" id="imagen" name="imagen" 
                                                   accept="image/*" onchange="previewImage(this)">
                                            
                                            <c:if test="${not empty producto.imagen}">
                                                <div class="mt-3">
                                                    <label class="form-label">Imagen Actual:</label>
                                                    <img src="${pageContext.request.contextPath}/uploads/${producto.imagen}" 
                                                         class="preview-image d-block" alt="Imagen actual">
                                                </div>
                                            </c:if>
                                            
                                            <div id="imagePreview" class="mt-3" style="display: none;">
                                                <label class="form-label">Vista Previa:</label>
                                                <img id="preview" class="preview-image d-block" alt="Vista previa">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="${pageContext.request.contextPath}/admin/productos" 
                                       class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Cancelar
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>
                                        ${producto != null ? 'Actualizar' : 'Guardar'} Producto
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
    <script>
        function previewImage(input) {
            const preview = document.getElementById('preview');
            const previewDiv = document.getElementById('imagePreview');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    previewDiv.style.display = 'block';
                }
                
                reader.readAsDataURL(input.files[0]);
            } else {
                previewDiv.style.display = 'none';
            }
        }
    </script>
</body>
</html> 