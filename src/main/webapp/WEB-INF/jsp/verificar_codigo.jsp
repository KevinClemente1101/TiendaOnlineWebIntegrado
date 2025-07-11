<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Verificar Correo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5" style="max-width: 400px;">
        <h3 class="mb-4 text-center">Verifica tu correo</h3>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/verificar-codigo" method="post">
            <div class="mb-3">
                <label for="codigo" class="form-label">Código de verificación</label>
                <input type="text" class="form-control" id="codigo" name="codigo" required maxlength="6" autofocus>
            </div>
            <button type="submit" class="btn btn-primary w-100">Verificar</button>
        </form>
    </div>
</body>
</html> 