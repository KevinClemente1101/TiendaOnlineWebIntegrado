package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.UsuarioDAO;
import com.tiendapatineta.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;
import com.tiendapatineta.util.EmailUtil;
import java.util.Random;
import jakarta.mail.MessagingException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String distrito = request.getParameter("distrito");
        String direccion = request.getParameter("direccion");
        String password = request.getParameter("password");
        String confirmar = request.getParameter("confirmar");

        // Validaciones backend
        String error = null;
        if (nombre == null || nombre.trim().isEmpty() ||
            email == null || !email.contains("@") ||
            telefono == null || !telefono.matches("^9\\d{8}$") ||
            distrito == null || distrito.trim().isEmpty() ||
            direccion == null || direccion.trim().isEmpty() ||
            password == null || !password.matches("^(?=.*[A-Z]).{8,}$") ||
            confirmar == null || !password.equals(confirmar)) {
            error = "Verifica que todos los campos sean válidos y que las contraseñas coincidan.";
        } else if (usuarioDAO.autenticar(email, password) != null) {
            error = "El correo ya está registrado.";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/registro.jsp").forward(request, response);
            return;
        }

        // Generar código de verificación
        String codigo = String.format("%06d", new Random().nextInt(999999));
        try {
            EmailUtil.enviarCodigoVerificacion(email.trim(), codigo);
        } catch (MessagingException e) {
            request.setAttribute("error", "No se pudo enviar el correo de verificación. Intenta nuevamente.");
            request.getRequestDispatcher("/WEB-INF/jsp/registro.jsp").forward(request, response);
            return;
        }

        // Guardar datos en sesión temporalmente
        request.getSession().setAttribute("registroUsuario", new String[]{
            nombre.trim(), email.trim(), telefono.trim(), distrito.trim(), direccion.trim(), password, confirmar
        });
        request.getSession().setAttribute("codigoVerificacion", codigo);

        // Redirigir a la página de verificación
        response.sendRedirect(request.getContextPath() + "/verificar-codigo");
    }
} 