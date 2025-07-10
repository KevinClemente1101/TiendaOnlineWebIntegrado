package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Usuario;
import com.tiendapatineta.model.DetalleVenta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/detalle-compra")
public class DetalleCompraServlet extends HttpServlet {
    private VentaDAO ventaDAO;

    @Override
    public void init() throws ServletException {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/historial");
            return;
        }
        int ventaId = Integer.parseInt(idStr);
        // (Opcional) Aquí podrías validar que la venta pertenece al usuario
        List<DetalleVenta> detalles = ventaDAO.obtenerDetallesPorVenta(ventaId);
        request.setAttribute("detalles", detalles);
        request.setAttribute("ventaId", ventaId);
        request.getRequestDispatcher("/WEB-INF/jsp/detalle_compra.jsp").forward(request, response);
    }
} 