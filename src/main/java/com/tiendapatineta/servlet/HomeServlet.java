package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.dao.CategoriaDAO;
import com.tiendapatineta.model.Producto;
import com.tiendapatineta.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
        categoriaDAO = new CategoriaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtener parámetros de filtrado
        String categoriaParam = request.getParameter("categoria");
        String buscarParam = request.getParameter("buscar");
        
        List<Producto> productos;
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        
        // Aplicar filtros
        if (categoriaParam != null && !categoriaParam.trim().isEmpty()) {
            try {
                int categoriaId = Integer.parseInt(categoriaParam);
                productos = productoDAO.obtenerPorCategoria(categoriaId);
            } catch (NumberFormatException e) {
                productos = productoDAO.obtenerTodos();
            }
        } else if (buscarParam != null && !buscarParam.trim().isEmpty()) {
            productos = productoDAO.buscarPorNombre(buscarParam.trim());
        } else {
            productos = productoDAO.obtenerTodos();
        }
        
        // Agregar datos al request
        request.setAttribute("productos", productos);
        request.setAttribute("categorias", categorias);
        
        // Redirigir a la página principal
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
} 