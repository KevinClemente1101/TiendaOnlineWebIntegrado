package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.BoletaDAO;
import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Boleta;
import com.tiendapatineta.model.Producto;
import com.tiendapatineta.model.Venta;
import com.tiendapatineta.model.DetalleVenta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/boleta/ver")
public class BoletaServlet extends HttpServlet {
    private BoletaDAO boletaDAO;
    private VentaDAO ventaDAO;
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        boletaDAO = new BoletaDAO();
        ventaDAO = new VentaDAO();
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Boleta boleta = boletaDAO.obtenerPorId(id);
            if (boleta != null) {
                Venta venta = ventaDAO.obtenerPorId(boleta.getVenta().getId());
                List<DetalleVenta> detalles = ventaDAO.obtenerDetallesPorVenta(venta.getId());
                request.setAttribute("boleta", boleta);
                request.setAttribute("venta", venta);
                request.setAttribute("detalles", detalles);
                request.getRequestDispatcher("/WEB-INF/jsp/boleta/ver.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/ventas");
    }
} 