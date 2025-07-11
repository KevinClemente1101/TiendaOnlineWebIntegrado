<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Cliente - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f7f7fa; }
        .register-card { max-width: 500px; margin: 40px auto; background: #fff; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.08); padding: 2rem; }
    </style>
</head>
<body>
    <div class="register-card">
        <h2 class="mb-4 text-center">Crear cuenta</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/registro" method="post" autocomplete="off" onsubmit="return validarRegistro()">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre completo *</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required maxlength="100">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Correo electrónico *</label>
                <input type="email" class="form-control" id="email" name="email" required maxlength="100" pattern="[^@]+@[^@]+\.[a-zA-Z]{2,}">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono *</label>
                <input type="tel" class="form-control" id="telefono" name="telefono" required pattern="^9[0-9]{8}$" maxlength="9" minlength="9" placeholder="9XXXXXXXX">
            </div>
            <div class="mb-3">
                <label for="distrito" class="form-label">Distrito *</label>
                <input type="text" class="form-control" id="distrito" name="distrito" required maxlength="50">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección *</label>
                <input type="text" class="form-control" id="direccion" name="direccion" required maxlength="255">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña *</label>
                <input type="password" class="form-control" id="password" name="password" required minlength="8" maxlength="100" pattern="(?=.*[A-Z]).{8,}">
                <div class="form-text">Mínimo 8 caracteres y al menos una mayúscula.</div>
            </div>
            <div class="mb-3">
                <label for="confirmar" class="form-label">Confirmar contraseña *</label>
                <input type="password" class="form-control" id="confirmar" name="confirmar" required minlength="8" maxlength="100">
            </div>
            <button type="submit" class="btn btn-primary w-100">Registrarme</button>
        </form>
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login">¿Ya tienes cuenta? Inicia sesión</a>
        </div>
    </div>
    <script>
        function validarRegistro() {
            var email = document.getElementById('email').value;
            if (!email.includes('@')) {
                alert('El correo debe contener @');
                return false;
            }
            var telefono = document.getElementById('telefono').value;
            if (!/^9\d{8}$/.test(telefono)) {
                alert('El teléfono debe empezar con 9 y tener 9 dígitos.');
                return false;
            }
            var pass = document.getElementById('password').value;
            if (!/(?=.*[A-Z]).{8,}/.test(pass)) {
                alert('La contraseña debe tener al menos 8 caracteres y una mayúscula.');
                return false;
            }
            var confirmar = document.getElementById('confirmar').value;
            if (pass !== confirmar) {
                alert('Las contraseñas no coinciden.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html> 