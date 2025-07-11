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

@WebServlet("/verificar-codigo")
public class VerificarCodigoServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/verificar_codigo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String codigoIngresado = request.getParameter("codigo");
        String codigoEnviado = (String) session.getAttribute("codigoVerificacion");
        String[] datos = (String[]) session.getAttribute("registroUsuario");

        if (codigoEnviado == null || datos == null) {
            response.sendRedirect(request.getContextPath() + "/registro");
            return;
        }

        if (!codigoEnviado.equals(codigoIngresado)) {
            request.setAttribute("error", "El código ingresado es incorrecto.");
            request.getRequestDispatcher("/WEB-INF/jsp/verificar_codigo.jsp").forward(request, response);
            return;
        }

        // Encriptar contraseña y registrar usuario
        String hash = BCrypt.hashpw(datos[5], BCrypt.gensalt());
        Usuario usuario = new Usuario();
        usuario.setNombre(datos[0]);
        usuario.setEmail(datos[1]);
        usuario.setTelefono(datos[2]);
        usuario.setDistrito(datos[3]);
        usuario.setDireccion(datos[4]);
        usuario.setPassword(hash);
        usuario.setRol("cliente");
        usuarioDAO.registrar(usuario);

        // Limpiar sesión temporal
        session.removeAttribute("registroUsuario");
        session.removeAttribute("codigoVerificacion");

        // Redirigir al login con mensaje de éxito
        response.sendRedirect(request.getContextPath() + "/login?registro=ok");
    }
} 