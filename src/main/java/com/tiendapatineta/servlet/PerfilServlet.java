package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.UsuarioDAO;
import com.tiendapatineta.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/perfil")
public class PerfilServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.setAttribute("usuario", session.getAttribute("usuario"));
        request.getRequestDispatcher("/WEB-INF/jsp/perfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String accion = request.getParameter("accion");
        if ("actualizarPerfil".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String distrito = request.getParameter("distrito");
            String direccion = request.getParameter("direccion");
            // Validaciones básicas
            if (nombre == null || correo == null || telefono == null || distrito == null || direccion == null ||
                nombre.isEmpty() || correo.isEmpty() || telefono.isEmpty() || distrito.isEmpty() || direccion.isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios.");
            } else if (!correo.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
                request.setAttribute("error", "Correo inválido.");
            } else if (!telefono.matches("^9\\d{8}$")) {
                request.setAttribute("error", "El teléfono debe empezar con 9 y tener 9 dígitos.");
            } else {
                usuario.setNombre(nombre);
                usuario.setEmail(correo);
                usuario.setTelefono(telefono);
                usuario.setDistrito(distrito);
                usuario.setDireccion(direccion);
                boolean actualizado = usuarioDAO.actualizarPerfil(usuario);
                if (actualizado) {
                    session.setAttribute("usuario", usuario);
                    request.setAttribute("mensaje", "Perfil actualizado correctamente.");
                } else {
                    request.setAttribute("error", "No se pudo actualizar el perfil.");
                }
            }
            request.setAttribute("usuario", usuario);
            request.getRequestDispatcher("/WEB-INF/jsp/perfil.jsp").forward(request, response);
        } else if ("cambiarContrasena".equals(accion)) {
            String actual = request.getParameter("actual");
            String nueva = request.getParameter("nueva");
            String confirmar = request.getParameter("confirmar");
            if (actual == null || nueva == null || confirmar == null ||
                actual.isEmpty() || nueva.isEmpty() || confirmar.isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios.");
            } else if (!BCrypt.checkpw(actual, usuario.getPassword())) {
                request.setAttribute("error", "La contraseña actual es incorrecta.");
            } else if (!nueva.equals(confirmar)) {
                request.setAttribute("error", "Las contraseñas nuevas no coinciden.");
            } else if (!nueva.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+=-]{8,}$")) {
                request.setAttribute("error", "La nueva contraseña debe tener al menos 8 caracteres, una letra y un número.");
            } else {
                String hash = BCrypt.hashpw(nueva, BCrypt.gensalt());
                boolean actualizado = usuarioDAO.cambiarContrasena(usuario.getId(), hash);
                if (actualizado) {
                    usuario.setPassword(hash);
                    session.setAttribute("usuario", usuario);
                    request.setAttribute("mensaje", "Contraseña cambiada correctamente.");
                } else {
                    request.setAttribute("error", "No se pudo cambiar la contraseña.");
                }
            }
            request.setAttribute("usuario", usuario);
            request.getRequestDispatcher("/WEB-INF/jsp/perfil.jsp").forward(request, response);
        } else {
            response.sendRedirect("perfil");
        }
    }
} 