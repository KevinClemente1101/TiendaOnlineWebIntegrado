package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.model.Usuario;
import com.tiendapatineta.model.Venta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/historial")
public class HistorialComprasServlet extends HttpServlet {
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
        List<Venta> compras = ventaDAO.obtenerPorUsuario(usuario.getId());
        request.setAttribute("compras", compras);
        request.getRequestDispatcher("/WEB-INF/jsp/historial.jsp").forward(request, response);
    }
} 