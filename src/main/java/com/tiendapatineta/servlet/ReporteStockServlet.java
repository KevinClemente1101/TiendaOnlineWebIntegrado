package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reportes/stock")
public class ReporteStockServlet extends HttpServlet {
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int umbral = 10;
        String umbralParam = request.getParameter("umbral");
        if (umbralParam != null) {
            try {
                umbral = Integer.parseInt(umbralParam);
            } catch (NumberFormatException ignored) {}
        }
        List<Producto> productos = productoDAO.obtenerStockBajo(umbral);
        request.setAttribute("productos", productos);
        request.setAttribute("umbral", umbral);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/reportes/stock.jsp").forward(request, response);
    }
} 