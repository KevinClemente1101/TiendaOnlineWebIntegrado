<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Proveedores - Admin | Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../includes/header.jsp" />
    <div class="container-fluid">
      <div class="row">
        <jsp:include page="../includes/sidebar.jsp" />
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
              <h1 class="h2"><i class="fas fa-truck me-2"></i>Proveedores</h1>
              <a href="${pageContext.request.contextPath}/admin/proveedores/nuevo" class="btn btn-primary">
                  <i class="fas fa-plus me-2"></i>Nuevo Proveedor
              </a>
          </div>
          <div class="table-responsive">
              <table class="table table-striped table-hover align-middle">
                  <thead class="table-dark">
                      <tr>
                          <th>ID</th>
                          <th>Nombre</th>
                          <th>RUC</th>
                          <th>Teléfono</th>
                          <th>Productos</th>
                          <th>Acciones</th>
                      </tr>
                  </thead>
                  <tbody>
                      <c:forEach var="proveedor" items="${proveedores}">
                          <tr>
                              <td>${proveedor.id}</td>
                              <td>${proveedor.nombre}</td>
                              <td>${proveedor.ruc}</td>
                              <td>${proveedor.telefono}</td>
                              <td>${proveedor.productos}</td>
                              <td>
                                  <a href="${pageContext.request.contextPath}/admin/proveedores/editar?id=${proveedor.id}" class="btn btn-sm btn-warning">
                                      <i class="fas fa-edit"></i> Editar
                                  </a>
                                  <a href="${pageContext.request.contextPath}/admin/proveedores/eliminar?id=${proveedor.id}" class="btn btn-sm btn-danger" onclick="return confirm('¿Seguro de eliminar este proveedor?');">
                                      <i class="fas fa-trash"></i> Eliminar
                                  </a>
                              </td>
                          </tr>
                      </c:forEach>
                  </tbody>
              </table>
          </div>
        </main>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 