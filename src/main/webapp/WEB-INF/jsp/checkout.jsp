<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finalizar Compra - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-4">
        <h1 class="mb-4"><i class="fas fa-credit-card me-2"></i>Finalizar Compra</h1>
        <c:choose>
            <c:when test="${empty carrito}">
                <div class="alert alert-info">Tu carrito está vacío.</div>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <div class="mb-3">
                        <label for="direccionEnvio" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Dirección de envío *</label>
                        <input type="text" class="form-control" id="direccionEnvio" name="direccionEnvio" required maxlength="255" placeholder="Ej: Av. Siempre Viva 123, Lima">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-money-check-alt me-2"></i>Método de pago *</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="metodoPago" id="pagoTarjeta" value="tarjeta" required onclick="mostrarCampoPago()">
                            <label class="form-check-label" for="pagoTarjeta">Tarjeta</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="metodoPago" id="pagoYape" value="yape" required onclick="mostrarCampoPago()">
                            <label class="form-check-label" for="pagoYape">Yape</label>
                        </div>
                    </div>
                    <div class="mb-3" id="campoTarjeta" style="display:none;">
                        <label for="referenciaTarjeta" class="form-label"><i class="fas fa-credit-card me-2"></i>Número de tarjeta *</label>
                        <input type="text" class="form-control" id="referenciaTarjeta" name="referenciaPago" maxlength="30" pattern="[0-9]{12,19}" placeholder="Ej: 4111111111111111">
                    </div>
                    <div class="mb-3" id="campoYape" style="display:none;">
                        <label for="referenciaYape" class="form-label"><i class="fab fa-y-combinator me-2"></i>Número de Yape *</label>
                        <input type="text" class="form-control" id="referenciaYape" name="referenciaPago" maxlength="30" pattern="[0-9]{9,15}" placeholder="Ej: 987654321">
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Producto</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${carrito}">
                                    <tr>
                                        <td>${item.producto.nombre}</td>
                                        <td>S/. ${item.producto.precio}</td>
                                        <td>${item.cantidad}</td>
                                        <td>S/. ${item.subtotal}</td>
                                    </tr>
                                    <c:set var="total" value="${total + item.subtotal}" />
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="3" class="text-end">Envío:</th>
                                    <th>S/. 10.00</th>
                                </tr>
                                <tr>
                                    <th colspan="3" class="text-end">Total:</th>
                                    <th>S/. ${total + 10}</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="d-flex justify-content-end mt-3">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="fas fa-check me-2"></i>Confirmar Compra
                        </button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function mostrarCampoPago() {
            var tarjeta = document.getElementById('pagoTarjeta').checked;
            var yape = document.getElementById('pagoYape').checked;
            document.getElementById('campoTarjeta').style.display = tarjeta ? 'block' : 'none';
            document.getElementById('campoYape').style.display = yape ? 'block' : 'none';
            // Habilita solo el campo correspondiente
            document.getElementById('referenciaTarjeta').disabled = !tarjeta;
            document.getElementById('referenciaYape').disabled = !yape;
            // Limpia el valor del campo oculto
            if (!tarjeta) document.getElementById('referenciaTarjeta').value = '';
            if (!yape) document.getElementById('referenciaYape').value = '';
        }
        // Validación simple para que se ingrese el campo correcto según método
        document.getElementById('checkoutForm').onsubmit = function(e) {
            var metodo = document.querySelector('input[name="metodoPago"]:checked');
            if (!metodo) {
                alert('Seleccione un método de pago.');
                return false;
            }
            if (metodo.value === 'tarjeta') {
                var ref = document.getElementById('referenciaTarjeta').value.trim();
                if (ref.length < 12) {
                    alert('Ingrese un número de tarjeta válido.');
                    document.getElementById('referenciaTarjeta').focus();
                    return false;
                }
                document.getElementById('referenciaYape').value = '';
            } else if (metodo.value === 'yape') {
                var ref = document.getElementById('referenciaYape').value.trim();
                if (ref.length < 9) {
                    alert('Ingrese un número de Yape válido.');
                    document.getElementById('referenciaYape').focus();
                    return false;
                }
                document.getElementById('referenciaTarjeta').value = '';
            }
            return true;
        };
    </script>
</body>
</html> 