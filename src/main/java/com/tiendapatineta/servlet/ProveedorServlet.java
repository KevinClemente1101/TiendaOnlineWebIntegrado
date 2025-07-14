package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProveedorDAO;
import com.tiendapatineta.model.Proveedor;
import com.tiendapatineta.dao.CategoriaDAO;
import com.tiendapatineta.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/admin/proveedores/*")
public class ProveedorServlet extends HttpServlet {
    private ProveedorDAO proveedorDAO;
    private CategoriaDAO categoriaDAO;

    @Override
    public void init() throws ServletException {
        proveedorDAO = new ProveedorDAO();
        categoriaDAO = new CategoriaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listarProveedores(request, response);
        } else if (pathInfo.equals("/nuevo")) {
            mostrarFormulario(request, response, null);
        } else if (pathInfo.startsWith("/editar")) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Proveedor proveedor = proveedorDAO.obtenerPorId(id);
                mostrarFormulario(request, response, proveedor);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/proveedores");
            }
        } else if (pathInfo.startsWith("/eliminar")) {
            eliminarProveedor(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/proveedores");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String ruc = request.getParameter("ruc");
        String telefono = request.getParameter("telefono");
        String productos = request.getParameter("productos");
        String[] categoriasSeleccionadas = request.getParameterValues("categorias");
        List<Integer> categoriaIds = new ArrayList<>();
        if (categoriasSeleccionadas != null) {
            for (String catId : categoriasSeleccionadas) {
                categoriaIds.add(Integer.parseInt(catId));
            }
        }
        if (idStr == null || idStr.isEmpty()) {
            // Crear
            Proveedor proveedor = new Proveedor();
            proveedor.setNombre(nombre);
            proveedor.setRuc(ruc);
            proveedor.setTelefono(telefono);
            proveedor.setProductos(productos);
            proveedorDAO.agregar(proveedor);
            // Obtener el ID generado
            List<Proveedor> proveedores = proveedorDAO.obtenerTodos();
            int nuevoId = proveedores.get(proveedores.size() - 1).getId();
            proveedorDAO.guardarCategoriasProveedor(nuevoId, categoriaIds);
        } else {
            // Editar
            int id = Integer.parseInt(idStr);
            Proveedor proveedor = new Proveedor();
            proveedor.setId(id);
            proveedor.setNombre(nombre);
            proveedor.setRuc(ruc);
            proveedor.setTelefono(telefono);
            proveedor.setProductos(productos);
            proveedorDAO.actualizar(proveedor);
            proveedorDAO.guardarCategoriasProveedor(id, categoriaIds);
        }
        response.sendRedirect(request.getContextPath() + "/admin/proveedores");
    }

    private void listarProveedores(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Proveedor> proveedores = proveedorDAO.obtenerTodos();
        request.setAttribute("proveedores", proveedores);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/proveedores/lista.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response, Proveedor proveedor) throws ServletException, IOException {
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("categorias", categorias);
        request.setAttribute("proveedor", proveedor);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/proveedores/formulario.jsp").forward(request, response);
    }

    private void eliminarProveedor(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            proveedorDAO.eliminar(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/proveedores");
    }
} 