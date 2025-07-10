package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.UsuarioDAO;
import com.tiendapatineta.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/usuarios/*")
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listarUsuarios(request, response);
        } else if (pathInfo.equals("/nuevo")) {
            // Asegura que no haya usuario previo en el request
            request.removeAttribute("usuario");
            mostrarFormulario(request, response, null);
        } else if (pathInfo.startsWith("/editar")) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Usuario usuario = usuarioDAO.obtenerPorId(id);
                mostrarFormulario(request, response, usuario);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/usuarios");
            }
        } else if (pathInfo.startsWith("/eliminar")) {
            eliminarUsuario(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        if (idStr == null || idStr.isEmpty()) {
            // Crear
            Usuario usuario = new Usuario();
            usuario.setNombre(nombre);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setRol(rol);
            usuarioDAO.registrar(usuario);
        } else {
            // Editar
            int id = Integer.parseInt(idStr);
            Usuario usuario = new Usuario();
            usuario.setId(id);
            usuario.setNombre(nombre);
            usuario.setEmail(email);
            usuario.setPassword(password);
            usuario.setRol(rol);
            usuarioDAO.actualizar(usuario);
        }
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> usuarios = usuarioDAO.obtenerTodos();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/usuarios/lista.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws ServletException, IOException {
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/usuarios/formulario.jsp").forward(request, response);
    }

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            usuarioDAO.eliminar(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }
} 