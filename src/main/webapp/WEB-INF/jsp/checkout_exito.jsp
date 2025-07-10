<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra Exitosa - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="includes/header.jsp" />
    <div class="container py-5">
        <div class="alert alert-success text-center">
            <h2 class="mb-3"><i class="fas fa-check-circle me-2"></i>¡Compra realizada con éxito!</h2>
            <p>Gracias por tu compra. Tu pedido ha sido registrado correctamente.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3">
                <i class="fas fa-home me-2"></i>Volver a la tienda
            </a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 