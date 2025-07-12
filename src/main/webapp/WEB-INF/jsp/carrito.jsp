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
    <style>
.carrito-container {
    background: #181c24;
    border-radius: 22px;
    box-shadow: 0 4px 32px rgba(0,255,193,0.13);
    padding: 2.5rem 2rem 2rem 2rem;
    max-width: 1100px;
    margin: 2.5rem auto 2rem auto;
}
.carrito-title {
    font-size: 2.7rem;
    font-weight: 900;
    color: #0fffc1;
    margin-bottom: 2.2rem;
    display: flex;
    align-items: center;
    gap: 0.7rem;
}
.carrito-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background: #23272b;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 2px 16px rgba(0,255,193,0.07);
    color: #fff;
}
.carrito-table th {
    background: #0fffc1;
    color: #181c24;
    font-weight: 700;
    font-size: 1.1rem;
    border: none;
    padding: 1rem 0.7rem;
}
.carrito-table td {
    background: #23272b;
    font-size: 1.05rem;
    border: none;
    padding: 1rem 0.7rem;
    vertical-align: middle;
    color: #fff;
}
.carrito-table tr:last-child td {
    border-bottom: none;
}
.carrito-table .btn {
    border-radius: 10px;
    font-size: 1.1rem;
    padding: 0.5rem 1.1rem;
}
.carrito-total-card {
    background: linear-gradient(90deg, #0fffc1 0%, #7e30e1 100%);
    color: #181c24;
    border-radius: 16px;
    padding: 1.2rem 2rem;
    font-size: 1.4rem;
    font-weight: 800;
    box-shadow: 0 2px 8px rgba(0,255,193,0.10);
    margin: 2rem 0 1.5rem 0;
    text-align: right;
}
.carrito-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 2.5rem;
    gap: 1.5rem;
}
.btn-vaciar {
    border-radius: 12px;
    font-weight: 700;
    font-size: 1.1rem;
    padding: 0.7rem 1.5rem;
    border: 2px solid #0fffc1;
    color: #0fffc1;
    background: transparent;
    box-shadow: 0 2px 8px rgba(0,255,193,0.18);
    transition: background 0.2s, color 0.2s, box-shadow 0.2s;
}
.btn-vaciar:hover {
    background: #0fffc1;
    color: #181c24;
    box-shadow: 0 4px 16px rgba(0,255,193,0.28);
}
.btn-finalizar {
    border-radius: 12px;
    font-weight: 700;
    font-size: 1.1rem;
    padding: 0.7rem 1.5rem;
    background: #0fffc1;
    color: #181c24;
    border: none;
    box-shadow: 0 2px 12px rgba(0,255,193,0.18);
    transition: background 0.2s, color 0.2s, box-shadow 0.2s;
}
.btn-finalizar:hover {
    background: #7e30e1;
    color: #fff;
    box-shadow: 0 4px 16px rgba(126,48,225,0.28);
}
.btn-vaciar,
.btn-finalizar {
    opacity: 1 !important;
    pointer-events: auto !important;
    filter: none !important;
    color: #fff !important;
}
.btn-vaciar.disabled,
.btn-finalizar.disabled {
    opacity: 1 !important;
    pointer-events: auto !important;
    filter: none !important;
    color: #fff !important;
}
.btn-vaciar i, .btn-finalizar i {
    color: #fff !important;
}
@media (max-width: 900px) {
    .carrito-container { padding: 1.2rem 0.2rem; }
    .carrito-title { font-size: 1.5rem; }
    .carrito-total-card { font-size: 1.1rem; padding: 1rem; }
}
body, .bg-light {
    background: #23272b !important;
}
</style>
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-4">

        <c:choose>
            <c:when test="${empty carrito}">
                <div class="alert alert-info">Tu carrito está vacío.</div>
            </c:when>
            <c:otherwise>
                <div class="carrito-container">
                    <h2 class="carrito-title"><i class="fas fa-shopping-cart me-2"></i>Mi Carrito</h2>
                    <div class="table-responsive">
                        <table class="carrito-table">
                            <thead>
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
                        </table>
                    </div>
                    <div class="carrito-actions">
                        <a href="${pageContext.request.contextPath}/carrito/vaciar" class="btn btn-vaciar">
                            <i class="fas fa-trash-alt me-2"></i>Vaciar Carrito
                        </a>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-finalizar">
                            <i class="fas fa-credit-card me-2"></i>Finalizar Compra
                        </a>
                    </div>
                    <div class="carrito-total-card">
                        <strong>Total:</strong> S/. ${total}
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 