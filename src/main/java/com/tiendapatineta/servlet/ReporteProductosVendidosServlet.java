package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reportes/productos")
public class ReporteProductosVendidosServlet extends HttpServlet {
    private VentaDAO ventaDAO;

    @Override
    public void init() throws ServletException {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int limite = 10;
        String limiteParam = request.getParameter("limite");
        if (limiteParam != null) {
            try {
                limite = Integer.parseInt(limiteParam);
            } catch (NumberFormatException ignored) {}
        }
        List<Object[]> productos = ventaDAO.obtenerProductosMasVendidos(limite);
        request.setAttribute("productos", productos);
        request.setAttribute("limite", limite);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/reportes/productos.jsp").forward(request, response);
    }
} 