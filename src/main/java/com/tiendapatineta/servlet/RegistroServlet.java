package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.UsuarioDAO;
import com.tiendapatineta.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

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

        // Encriptar contraseña
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre.trim());
        usuario.setEmail(email.trim());
        usuario.setTelefono(telefono.trim());
        usuario.setDistrito(distrito.trim());
        usuario.setDireccion(direccion.trim());
        usuario.setPassword(hash);
        usuario.setRol("cliente");

        usuarioDAO.registrar(usuario);

        // Redirigir al login con mensaje de éxito
        response.sendRedirect(request.getContextPath() + "/login?registro=ok");
    }
} 