package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.dao.UsuarioDAO;
import com.tiendapatineta.dao.CategoriaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    private UsuarioDAO usuarioDAO;
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
        usuarioDAO = new UsuarioDAO();
        categoriaDAO = new CategoriaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verificar autenticación y rol de administrador
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String rol = (String) session.getAttribute("usuarioRol");
        if (!"admin".equals(rol)) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        // Obtener estadísticas para el dashboard
        List<com.tiendapatineta.model.Producto> productos = productoDAO.obtenerTodos();
        List<com.tiendapatineta.model.Usuario> usuarios = usuarioDAO.obtenerTodos();
        List<com.tiendapatineta.model.Categoria> categorias = categoriaDAO.obtenerTodas();
        
        // Calcular estadísticas
        int totalProductos = productos.size();
        int totalUsuarios = usuarios.size();
        int totalCategorias = categorias.size();
        
        // Contar productos con stock bajo
        long productosStockBajo = productos.stream()
                .filter(p -> p.getStock() <= 10 && p.getStock() > 0)
                .count();
        
        // Contar productos sin stock
        long productosSinStock = productos.stream()
                .filter(p -> p.getStock() == 0)
                .count();
        
        // Agregar datos al request
        request.setAttribute("totalProductos", totalProductos);
        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("totalCategorias", totalCategorias);
        request.setAttribute("productosStockBajo", productosStockBajo);
        request.setAttribute("productosSinStock", productosSinStock);
        request.setAttribute("productos", productos.subList(0, Math.min(5, productos.size()))); // Últimos 5 productos
        request.setAttribute("usuarios", usuarios.subList(0, Math.min(5, usuarios.size()))); // Últimos 5 usuarios
        
        // Redirigir al dashboard
        request.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(request, response);
    }
} 