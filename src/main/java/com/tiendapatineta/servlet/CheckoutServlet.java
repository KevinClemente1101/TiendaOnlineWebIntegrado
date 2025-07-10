package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.VentaDAO;
import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.model.ItemCarrito;
import com.tiendapatineta.model.Usuario;
import com.tiendapatineta.model.Venta;
import com.tiendapatineta.model.DetalleVenta;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private VentaDAO ventaDAO;
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        ventaDAO = new VentaDAO();
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrito/ver");
            return;
        }
        request.setAttribute("carrito", carrito);
        request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (usuario == null || carrito == null || carrito.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrito/ver");
            return;
        }
        // Calcular total
        BigDecimal total = BigDecimal.ZERO;
        for (ItemCarrito item : carrito) {
            total = total.add(item.getSubtotal());
        }
        // Registrar venta
        Venta venta = new Venta();
        venta.setUsuarioId(usuario.getId());
        venta.setFecha(new Date());
        venta.setTotal(total);
        int ventaId = ventaDAO.registrarVenta(venta, carrito);
        // Actualizar stock
        for (ItemCarrito item : carrito) {
            productoDAO.descontarStock(item.getProducto().getId(), item.getCantidad());
        }
        // Limpiar carrito
        session.removeAttribute("carrito");
        // Redirigir a página de éxito
        response.sendRedirect(request.getContextPath() + "/checkout/exito?id=" + ventaId);
    }
} 