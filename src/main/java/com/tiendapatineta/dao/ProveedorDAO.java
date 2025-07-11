package com.tiendapatineta.dao;

import com.tiendapatineta.model.Proveedor;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {
    public List<Proveedor> obtenerTodos() {
        List<Proveedor> proveedores = new ArrayList<>();
        String sql = "SELECT * FROM proveedores ORDER BY nombre";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                proveedores.add(new Proveedor(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("ruc"),
                    rs.getString("telefono"),
                    rs.getString("productos")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener proveedores: " + e.getMessage());
        }
        return proveedores;
    }

    public Proveedor obtenerPorId(int id) {
        String sql = "SELECT * FROM proveedores WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Proveedor(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("ruc"),
                        rs.getString("telefono"),
                        rs.getString("productos")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener proveedor: " + e.getMessage());
        }
        return null;
    }

    public boolean agregar(Proveedor proveedor) {
        String sql = "INSERT INTO proveedores (nombre, ruc, telefono, productos) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, proveedor.getNombre());
            stmt.setString(2, proveedor.getRuc());
            stmt.setString(3, proveedor.getTelefono());
            stmt.setString(4, proveedor.getProductos());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al agregar proveedor: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Proveedor proveedor) {
        String sql = "UPDATE proveedores SET nombre = ?, ruc = ?, telefono = ?, productos = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, proveedor.getNombre());
            stmt.setString(2, proveedor.getRuc());
            stmt.setString(3, proveedor.getTelefono());
            stmt.setString(4, proveedor.getProductos());
            stmt.setInt(5, proveedor.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar proveedor: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM proveedores WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar proveedor: " + e.getMessage());
            return false;
        }
    }
} 