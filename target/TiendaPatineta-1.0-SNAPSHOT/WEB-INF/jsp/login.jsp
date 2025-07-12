<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Tienda de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #23272b;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: stretch;
            justify-content: flex-start;
        }
        .login-main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-top: 40px;
        }
        .login-card {
            background: #181c24;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,255,193,0.10);
            border: 2px solid #0fffc1;
        }
        .login-header {
            text-align: center;
            padding: 2rem 0;
        }
        .login-header i {
            font-size: 3rem;
            color: #0fffc1;
            margin-bottom: 1rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #0fffc1;
            padding: 12px 15px;
            transition: all 0.3s ease;
            background: #23272b;
            color: #0fffc1;
        }
        .form-control:focus {
            border-color: #0fffc1;
            box-shadow: 0 0 0 0.2rem rgba(15,255,193,0.10);
            background: #181c24;
            color: #0fffc1;
        }
        .btn-login {
            background: transparent;
            border: 2px solid #0fffc1;
            border-radius: 10px;
            padding: 12px;
            font-weight: 700;
            color: #0fffc1;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            background: #0fffc1;
            color: #181c24;
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 5px 15px rgba(15,255,193,0.18);
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .text-muted, .form-label {
            color: #0fffc1 !important;
        }
        .login-header h2 {
            font-weight: 900;
            color: #0fffc1;
            letter-spacing: 1px;
        }
        .login-header p {
            color: #0fffc1;
            font-weight: 700;
            font-size: 1.1rem;
        }
        .card-body h6 {
            color: #0fffc1;
            font-weight: 700;
        }
        .card-body small {
            color: #fff !important;
        }
        .login-card, .card-body, .login-header {
            color: #fff;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="login-main">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="login-card">
                        <div class="login-header">
                     <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/uploads/logo_1.png" alt="Logo" style="height:80px; margin-right:16px; vertical-align:middle;"> 
        </a>
                            <h2 class="mb-0">House Of Skate</h2>
                            <p style="color:#0fffc1; font-weight:700; font-size:1.1rem;">Inicia sesión para continuar</p>
                        </div>
                        
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/login" method="post">
                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="tu@email.com" required>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2"></i>Contraseña
                                    </label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Tu contraseña" required>
                                </div>
                                
                                <button type="submit" class="btn btn-primary btn-login w-100 mb-3">
                                    <i class="fas fa-sign-in-alt me-2"></i>Iniciar Sesión
                                </button>
                            </form>
                            
                            <div class="text-center">
                                <small class="text-muted">
                                    ¿No tienes cuenta? 
                                    <a href="${pageContext.request.contextPath}/registro" class="text-decoration-none">
                                        Regístrate aquí
                                    </a>
                                </small>
                            </div>
                            
                            <hr class="my-4">
                            
                     
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 