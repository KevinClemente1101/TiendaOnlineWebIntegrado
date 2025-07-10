<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Carrito - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-4">
        <h1 class="mb-4"><i class="fas fa-shopping-cart me-2"></i>Mi Carrito</h1>
        <c:choose>
            <c:when test="${empty carrito}">
                <div class="alert alert-info">Tu carrito está vacío.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${carrito}">
                                <tr>
                                    <td>${item.producto.nombre}</td>
                                    <td>S/. ${item.producto.precio}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/carrito/actualizar" method="post" class="d-inline">
                                            <input type="hidden" name="productoId" value="${item.producto.id}" />
                                            <input type="number" name="cantidad" value="${item.cantidad}" min="1" max="${item.producto.stock}" style="width:60px;" required />
                                            <button type="submit" class="btn btn-sm btn-outline-primary ms-1"><i class="fas fa-sync"></i></button>
                                        </form>
                                    </td>
                                    <td>S/. ${item.subtotal}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/carrito/eliminar?productoId=${item.producto.id}" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                                <c:set var="total" value="${total + item.subtotal}" />
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-end">Total:</th>
                                <th colspan="2">S/. ${total}</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="d-flex justify-content-between mt-3">
                    <a href="${pageContext.request.contextPath}/carrito/vaciar" class="btn btn-outline-danger">
                        <i class="fas fa-trash-alt me-2"></i>Vaciar Carrito
                    </a>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success">
                        <i class="fas fa-credit-card me-2"></i>Finalizar Compra
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 