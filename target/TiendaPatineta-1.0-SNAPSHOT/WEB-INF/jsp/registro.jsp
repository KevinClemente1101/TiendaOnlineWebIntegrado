<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Cliente - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #23272b !important;
        }
        .register-card {
            max-width: 500px;
            margin: 40px auto;
            background: #181c24;
            border-radius: 18px;
            box-shadow: 0 5px 32px rgba(0,255,193,0.13);
            padding: 2.5rem 2rem 2rem 2rem;
            color: #fff;
        }
        .register-card h2 {
            color: #0fffc1;
            font-weight: 800;
            letter-spacing: 1px;
        }
        .form-label {
            color: #0fffc1;
            font-weight: 600;
        }
        .form-control {
            border-radius: 12px;
            border: 2px solid #0fffc1;
            padding: 12px 15px;
            margin-bottom: 1rem;
            font-size: 1.05rem;
            background: #23272b;
            color: #fff;
            transition: border 0.2s, background 0.2s, color 0.2s;
        }
        .form-control:focus {
            border-color: #7e30e1;
            box-shadow: 0 0 0 0.2rem rgba(126, 48, 225, 0.10);
            background: #181c24;
            color: #0fffc1;
        }
        .btn-primary {
            border-radius: 12px;
            font-weight: 700;
            padding: 10px 0;
            width: 100%;
            margin-bottom: 1rem;
            background: #0fffc1;
            color: #181c24;
            border: none;
            box-shadow: 0 2px 8px rgba(0,255,193,0.10);
            transition: background 0.2s, color 0.2s;
        }
        .btn-primary:hover {
            background: #7e30e1;
            color: #fff;
        }
        .alert-danger {
            border-radius: 12px;
            font-size: 1.05rem;
            text-align: center;
            background: #23272b !important;
            color: #ff4b7d !important;
            border: 1.5px solid #ff4b7d;
            box-shadow: 0 2px 8px rgba(255,75,125,0.10);
        }
        .form-text {
            color: #0fffc1;
            font-weight: 700;
            font-size: 1rem;
            margin-top: 0.2rem;
            opacity: 1 !important;
        }
        .text-center.mt-3 a {
            color: #0fffc1;
            font-weight: 600;
            transition: color 0.2s, text-decoration 0.2s;
        }
        .text-center.mt-3 a:hover {
            color: #7e30e1;
            text-decoration: underline;
        }
        .form-control.is-invalid, .form-control:invalid, input:invalid, input.is-invalid {
            background-color: #23272b !important;
            border-color: #0fffc1 !important;
            color: #fff !important;
            box-shadow: none !important;
        }
        input, .form-control {
            border-color: #0fffc1 !important;
            box-shadow: none !important;
        }
        input:focus, .form-control:focus {
            border-color: #7e30e1 !important;
            box-shadow: 0 0 0 0.2rem rgba(126, 48, 225, 0.10) !important;
        }
        input:invalid, .form-control:invalid, input.is-invalid, .form-control.is-invalid {
            border-color: #0fffc1 !important;
            box-shadow: none !important;
        }
        input::-webkit-input-placeholder, .form-control::-webkit-input-placeholder {
            color: #0fffc1 !important;
            opacity: 1 !important;
        }
        input::-moz-placeholder, .form-control::-moz-placeholder {
            color: #0fffc1 !important;
            opacity: 1 !important;
        }
        input:-ms-input-placeholder, .form-control:-ms-input-placeholder {
            color: #0fffc1 !important;
            opacity: 1 !important;
        }
        input::placeholder, .form-control::placeholder {
            color: #0fffc1 !important;
            opacity: 1 !important;
        }
        input:-webkit-autofill, .form-control:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 1000px #23272b inset !important;
            -webkit-text-fill-color: #0fffc1 !important;
            border-color: #0fffc1 !important;
        }
        @media (max-width: 600px) {
            .register-card { padding: 1.2rem 0.5rem; }
            .register-card h2 { font-size: 1.2rem; }
        }
    </style>
</head>
<body>
      <jsp:include page="includes/header.jsp" />

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
                <span class="form-text" style="display:block !important; color:#0fffc1 !important; font-weight:700 !important; font-size:1rem !important; margin-top:0.2rem !important; opacity:1 !important;">Mínimo 8 caracteres y al menos una mayúscula.</span>
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