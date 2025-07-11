package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Venta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/reportes/ventas")
public class ReporteVentasServlet extends HttpServlet {
    private VentaDAO ventaDAO;

    @Override
    public void init() throws ServletException {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inicioStr = request.getParameter("inicio");
        String finStr = request.getParameter("fin");
        Date inicio, fin;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            inicio = (inicioStr != null && !inicioStr.isEmpty()) ? sdf.parse(inicioStr) : sdf.parse(sdf.format(new Date()));
        } catch (Exception e) { inicio = new Date(); }
        try {
            fin = (finStr != null && !finStr.isEmpty()) ? sdf.parse(finStr) : new Date();
        } catch (Exception e) { fin = new Date(); }
        List<Venta> ventas = ventaDAO.obtenerPorPeriodo(inicio, fin);
        request.setAttribute("ventas", ventas);
        request.setAttribute("inicio", sdf.format(inicio));
        request.setAttribute("fin", sdf.format(fin));
        request.getRequestDispatcher("/WEB-INF/jsp/admin/reportes/ventas.jsp").forward(request, response);
    }
} 