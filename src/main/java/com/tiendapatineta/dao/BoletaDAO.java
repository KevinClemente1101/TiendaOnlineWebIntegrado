package com.tiendapatineta.dao;
import com.tiendapatineta.model.Boleta;
import com.tiendapatineta.model.Usuario;
import com.tiendapatineta.model.Venta;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class BoletaDAO {
    public void insertar(Boleta boleta) {
        String sql = "INSERT INTO boleta (numero, fecha, usuario_id, venta_id, subtotal, igv, total, forma_pago, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, boleta.getNumero());
            stmt.setTimestamp(2, boleta.getFecha());
            stmt.setInt(3, boleta.getUsuario().getId());
            stmt.setInt(4, boleta.getVenta().getId());
            stmt.setBigDecimal(5, boleta.getSubtotal());
            stmt.setBigDecimal(6, boleta.getIgv());
            stmt.setBigDecimal(7, boleta.getTotal());
            stmt.setString(8, boleta.getFormaPago());
            stmt.setString(9, boleta.getObservaciones());
            stmt.executeUpdate();
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    boleta.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al insertar boleta: " + e.getMessage());
        }
    }

    public Boleta obtenerPorId(int id) {
        String sql = "SELECT * FROM boleta WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBoleta(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener boleta: " + e.getMessage());
        }
        return null;
    }

    public Boleta obtenerPorVentaId(int ventaId) {
        String sql = "SELECT * FROM boleta WHERE venta_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, ventaId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapBoleta(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener boleta por venta: " + e.getMessage());
        }
        return null;
    }

    public String generarSiguienteNumeroBoleta() {
        String sql = "SELECT numero FROM boleta ORDER BY id DESC LIMIT 1";
        String serie = "B001";
        int correlativo = 1;
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                String ultimoNumero = rs.getString("numero");
                if (ultimoNumero != null && ultimoNumero.contains("-")) {
                    String[] partes = ultimoNumero.split("-");
                    correlativo = Integer.parseInt(partes[1]) + 1;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al generar número de boleta: " + e.getMessage());
        }
        return String.format("%s-%06d", serie, correlativo);
    }

    private Boleta mapBoleta(ResultSet rs) throws SQLException {
        Boleta boleta = new Boleta();
        boleta.setId(rs.getInt("id"));
        boleta.setNumero(rs.getString("numero"));
        boleta.setFecha(rs.getTimestamp("fecha"));
        boleta.setSubtotal(rs.getBigDecimal("subtotal"));
        boleta.setIgv(rs.getBigDecimal("igv"));
        boleta.setTotal(rs.getBigDecimal("total"));
        boleta.setFormaPago(rs.getString("forma_pago"));
        boleta.setObservaciones(rs.getString("observaciones"));
        // Relacionar usuario y venta solo con ID (puedes expandir para traer el objeto completo si lo necesitas)
        Usuario usuario = new Usuario();
        usuario.setId(rs.getInt("usuario_id"));
        boleta.setUsuario(usuario);
        Venta venta = new Venta();
        venta.setId(rs.getInt("venta_id"));
        boleta.setVenta(venta);
        return boleta;
    }
} 