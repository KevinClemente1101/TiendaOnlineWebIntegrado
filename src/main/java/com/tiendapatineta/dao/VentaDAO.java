package com.tiendapatineta.dao;

import com.tiendapatineta.model.Venta;
import com.tiendapatineta.model.DetalleVenta;
import com.tiendapatineta.model.Usuario;
import com.tiendapatineta.model.Producto;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class VentaDAO {
    public List<Venta> obtenerTodas() {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT v.id, v.usuario_id, v.fecha, v.total, v.direccion_envio, v.metodo_pago, v.referencia_pago, u.nombre as usuario_nombre, u.email as usuario_email FROM ventas v JOIN usuarios u ON v.usuario_id = u.id ORDER BY v.fecha DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Venta venta = new Venta();
                venta.setId(rs.getInt("id"));
                venta.setUsuarioId(rs.getInt("usuario_id"));
                venta.setFecha(rs.getTimestamp("fecha"));
                venta.setTotal(rs.getBigDecimal("total"));
                venta.setDireccionEnvio(rs.getString("direccion_envio"));
                venta.setMetodoPago(rs.getString("metodo_pago"));
                venta.setReferenciaPago(rs.getString("referencia_pago"));
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("usuario_id"));
                usuario.setNombre(rs.getString("usuario_nombre"));
                usuario.setEmail(rs.getString("usuario_email"));
                venta.setUsuario(usuario);
                ventas.add(venta);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ventas: " + e.getMessage());
        }
        return ventas;
    }

    public List<DetalleVenta> obtenerDetallesPorVenta(int ventaId) {
        List<DetalleVenta> detalles = new ArrayList<>();
        String sql = "SELECT d.id, d.venta_id, d.producto_id, d.cantidad, d.subtotal, p.nombre as producto_nombre, p.precio as producto_precio FROM detalle_ventas d JOIN productos p ON d.producto_id = p.id WHERE d.venta_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ventaId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DetalleVenta detalle = new DetalleVenta();
                    detalle.setId(rs.getInt("id"));
                    detalle.setVentaId(rs.getInt("venta_id"));
                    detalle.setProductoId(rs.getInt("producto_id"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setSubtotal(rs.getBigDecimal("subtotal"));
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("producto_id"));
                    producto.setNombre(rs.getString("producto_nombre"));
                    producto.setPrecio(rs.getBigDecimal("producto_precio"));
                    detalle.setProducto(producto);
                    detalles.add(detalle);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener detalles de venta: " + e.getMessage());
        }
        return detalles;
    }

    public int registrarVenta(Venta venta, List<com.tiendapatineta.model.ItemCarrito> carrito) {
        int ventaId = -1;
        String sqlVenta = "INSERT INTO ventas (usuario_id, fecha, total, direccion_envio, metodo_pago, referencia_pago) VALUES (?, NOW(), ?, ?, ?, ?)";
        String sqlDetalle = "INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement stmtVenta = conn.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS)) {
                stmtVenta.setInt(1, venta.getUsuarioId());
                stmtVenta.setBigDecimal(2, venta.getTotal());
                stmtVenta.setString(3, venta.getDireccionEnvio());
                stmtVenta.setString(4, venta.getMetodoPago());
                stmtVenta.setString(5, venta.getReferenciaPago());
                int affectedRows = stmtVenta.executeUpdate();
                if (affectedRows == 0) throw new SQLException("No se pudo registrar la venta");
                try (ResultSet generatedKeys = stmtVenta.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        ventaId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("No se pudo obtener el ID de la venta");
                    }
                }
            }
            try (PreparedStatement stmtDetalle = conn.prepareStatement(sqlDetalle)) {
                for (com.tiendapatineta.model.ItemCarrito item : carrito) {
                    stmtDetalle.setInt(1, ventaId);
                    stmtDetalle.setInt(2, item.getProducto().getId());
                    stmtDetalle.setInt(3, item.getCantidad());
                    stmtDetalle.setBigDecimal(4, item.getSubtotal());
                    stmtDetalle.addBatch();
                }
                stmtDetalle.executeBatch();
            }
            conn.commit();
        } catch (SQLException e) {
            System.err.println("Error al registrar venta: " + e.getMessage());
        }
        return ventaId;
    }

    public List<Venta> obtenerPorUsuario(int usuarioId) {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT v.id, v.usuario_id, v.fecha, v.total, v.direccion_envio, v.metodo_pago, v.referencia_pago, u.nombre as usuario_nombre, u.email as usuario_email " +
                     "FROM ventas v JOIN usuarios u ON v.usuario_id = u.id WHERE v.usuario_id = ? ORDER BY v.fecha DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, usuarioId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Venta venta = new Venta();
                    venta.setId(rs.getInt("id"));
                    venta.setUsuarioId(rs.getInt("usuario_id"));
                    venta.setFecha(rs.getTimestamp("fecha"));
                    venta.setTotal(rs.getBigDecimal("total"));
                    venta.setDireccionEnvio(rs.getString("direccion_envio"));
                    venta.setMetodoPago(rs.getString("metodo_pago"));
                    venta.setReferenciaPago(rs.getString("referencia_pago"));
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("usuario_id"));
                    usuario.setNombre(rs.getString("usuario_nombre"));
                    usuario.setEmail(rs.getString("usuario_email"));
                    venta.setUsuario(usuario);
                    ventas.add(venta);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ventas del usuario: " + e.getMessage());
        }
        return ventas;
    }

    public List<Venta> obtenerPorPeriodo(java.util.Date inicio, java.util.Date fin) {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT v.id, v.usuario_id, v.fecha, v.total, u.nombre as usuario_nombre, u.email as usuario_email FROM ventas v JOIN usuarios u ON v.usuario_id = u.id WHERE v.fecha BETWEEN ? AND ? ORDER BY v.fecha DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, new java.sql.Timestamp(inicio.getTime()));
            stmt.setTimestamp(2, new java.sql.Timestamp(fin.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Venta venta = new Venta();
                    venta.setId(rs.getInt("id"));
                    venta.setUsuarioId(rs.getInt("usuario_id"));
                    venta.setFecha(rs.getTimestamp("fecha"));
                    venta.setTotal(rs.getBigDecimal("total"));
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("usuario_id"));
                    usuario.setNombre(rs.getString("usuario_nombre"));
                    usuario.setEmail(rs.getString("usuario_email"));
                    venta.setUsuario(usuario);
                    ventas.add(venta);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener ventas por periodo: " + e.getMessage());
        }
        return ventas;
    }

    public List<Object[]> obtenerProductosMasVendidos(int limite) {
        List<Object[]> resultados = new ArrayList<>();
        String sql = "SELECT p.nombre, SUM(d.cantidad) as total_vendidos, SUM(d.subtotal) as total_monto FROM detalle_ventas d JOIN productos p ON d.producto_id = p.id GROUP BY p.id, p.nombre ORDER BY total_vendidos DESC LIMIT ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limite);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    resultados.add(new Object[]{
                        rs.getString("nombre"),
                        rs.getInt("total_vendidos"),
                        rs.getBigDecimal("total_monto")
                    });
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos más vendidos: " + e.getMessage());
        }
        return resultados;
    }
} 