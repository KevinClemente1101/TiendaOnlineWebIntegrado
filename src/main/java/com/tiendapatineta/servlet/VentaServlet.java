package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Venta;
import com.tiendapatineta.model.DetalleVenta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ventas/*")
public class VentaServlet extends HttpServlet {
    private VentaDAO ventaDAO;

    @Override
    public void init() throws ServletException {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            listarVentas(request, response);
        } else if (pathInfo.startsWith("/detalle")) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    mostrarDetalleVenta(request, response, id);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/ventas");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/ventas");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/ventas");
        }
    }

    private void listarVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Venta> ventas = ventaDAO.obtenerTodas();
        request.setAttribute("ventas", ventas);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/ventas/lista.jsp").forward(request, response);
    }

    private void mostrarDetalleVenta(HttpServletRequest request, HttpServletResponse response, int ventaId) throws ServletException, IOException {
        List<DetalleVenta> detalles = ventaDAO.obtenerDetallesPorVenta(ventaId);
        request.setAttribute("detalles", detalles);
        request.setAttribute("ventaId", ventaId);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/ventas/detalle.jsp").forward(request, response);
    }
} 