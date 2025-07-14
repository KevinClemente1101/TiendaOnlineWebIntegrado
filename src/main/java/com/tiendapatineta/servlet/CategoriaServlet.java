package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.CategoriaDAO;
import com.tiendapatineta.dao.ProveedorDAO;
import com.tiendapatineta.model.Categoria;
import com.tiendapatineta.model.Proveedor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/categorias/*")
public class CategoriaServlet extends HttpServlet {
    private CategoriaDAO categoriaDAO;
    private ProveedorDAO proveedorDAO;

    @Override
    public void init() throws ServletException {
        categoriaDAO = new CategoriaDAO();
        proveedorDAO = new ProveedorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listarCategorias(request, response);
        } else if (pathInfo.equals("/nueva")) {
            mostrarFormulario(request, response, null);
        } else if (pathInfo.startsWith("/editar")) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Categoria categoria = categoriaDAO.obtenerPorId(id);
                mostrarFormulario(request, response, categoria);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categorias");
            }
        } else if (pathInfo.startsWith("/eliminar")) {
            eliminarCategoria(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/categorias");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String[] proveedoresSeleccionados = request.getParameterValues("proveedores");
        List<Integer> proveedorIds = new ArrayList<>();
        if (proveedoresSeleccionados != null) {
            for (String provId : proveedoresSeleccionados) {
                proveedorIds.add(Integer.parseInt(provId));
            }
        }
        if (idStr == null || idStr.isEmpty()) {
            // Crear
            Categoria categoria = new Categoria();
            categoria.setNombre(nombre);
            categoriaDAO.agregar(categoria);
            // Obtener el ID generado
            List<Categoria> categorias = categoriaDAO.obtenerTodas();
            int nuevaId = categorias.get(categorias.size() - 1).getId();
            categoriaDAO.guardarProveedoresCategoria(nuevaId, proveedorIds);
        } else {
            // Editar
            int id = Integer.parseInt(idStr);
            Categoria categoria = new Categoria();
            categoria.setId(id);
            categoria.setNombre(nombre);
            categoriaDAO.actualizar(categoria);
            categoriaDAO.guardarProveedoresCategoria(id, proveedorIds);
        }
        response.sendRedirect(request.getContextPath() + "/admin/categorias");
    }

    private void listarCategorias(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/categorias/lista.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response, Categoria categoria) throws ServletException, IOException {
        List<Proveedor> proveedores = proveedorDAO.obtenerTodos();
        request.setAttribute("proveedores", proveedores);
        request.setAttribute("categoria", categoria);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/categorias/formulario.jsp").forward(request, response);
    }

    private void eliminarCategoria(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            categoriaDAO.eliminar(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/categorias");
    }
} 