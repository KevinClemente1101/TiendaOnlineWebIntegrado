package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.model.Producto;
import com.tiendapatineta.model.ItemCarrito;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/carrito/*")
public class CarritoServlet extends HttpServlet {
    private ProductoDAO productoDAO;

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("")) {
            mostrarCarrito(request, response);
        } else if (pathInfo.equals("/ver")) {
            mostrarCarrito(request, response);
        } else if (pathInfo.equals("/eliminar")) {
            eliminarDelCarrito(request, response);
        } else if (pathInfo.equals("/vaciar")) {
            vaciarCarrito(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/carrito/ver");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.equals("/agregar")) {
            agregarAlCarrito(request, response);
        } else if (pathInfo != null && pathInfo.equals("/actualizar")) {
            actualizarCantidad(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/carrito/ver");
        }
    }

    private void mostrarCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }
        request.setAttribute("carrito", carrito);
        request.getRequestDispatcher("/WEB-INF/jsp/carrito.jsp").forward(request, response);
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productoId = Integer.parseInt(request.getParameter("productoId"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }
        Producto producto = productoDAO.obtenerPorId(productoId);
        boolean encontrado = false;
        for (ItemCarrito item : carrito) {
            if (item.getProducto().getId() == productoId) {
                item.setCantidad(item.getCantidad() + cantidad);
                encontrado = true;
                break;
            }
        }
        if (!encontrado) {
            carrito.add(new ItemCarrito(producto, cantidad));
        }
        session.setAttribute("carrito", carrito);
        response.sendRedirect(request.getContextPath() + "/carrito/ver");
    }

    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productoId = Integer.parseInt(request.getParameter("productoId"));
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito != null) {
            carrito.removeIf(item -> item.getProducto().getId() == productoId);
            session.setAttribute("carrito", carrito);
        }
        response.sendRedirect(request.getContextPath() + "/carrito/ver");
    }

    private void vaciarCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("carrito");
        response.sendRedirect(request.getContextPath() + "/carrito/ver");
    }

    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productoId = Integer.parseInt(request.getParameter("productoId"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito != null) {
            for (ItemCarrito item : carrito) {
                if (item.getProducto().getId() == productoId) {
                    item.setCantidad(cantidad);
                    break;
                }
            }
            session.setAttribute("carrito", carrito);
        }
        response.sendRedirect(request.getContextPath() + "/carrito/ver");
    }
} 