package com.tiendapatineta.dao;

import com.tiendapatineta.model.Proveedor;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.tiendapatineta.model.Categoria;

public class ProveedorDAO {
    public List<Proveedor> obtenerTodos() {
        List<Proveedor> proveedores = new ArrayList<>();
        String sql = "SELECT * FROM proveedores ORDER BY nombre";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Proveedor proveedor = new Proveedor(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("ruc"),
                    rs.getString("telefono"),
                    rs.getString("productos")
                );
                proveedor.setCategorias(obtenerCategoriasPorProveedor(proveedor.getId()));
                proveedores.add(proveedor);
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
                    Proveedor proveedor = new Proveedor(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("ruc"),
                        rs.getString("telefono"),
                        rs.getString("productos")
                    );
                    proveedor.setCategorias(obtenerCategoriasPorProveedor(id));
                    return proveedor;
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

    public List<Categoria> obtenerCategoriasPorProveedor(int proveedorId) {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT c.id, c.nombre FROM categorias c INNER JOIN proveedor_categoria pc ON c.id = pc.categoria_id WHERE pc.proveedor_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, proveedorId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    categorias.add(new Categoria(rs.getInt("id"), rs.getString("nombre")));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener categorías del proveedor: " + e.getMessage());
        }
        return categorias;
    }

    public void guardarCategoriasProveedor(int proveedorId, List<Integer> categoriaIds) {
        String deleteSql = "DELETE FROM proveedor_categoria WHERE proveedor_id = ?";
        String insertSql = "INSERT INTO proveedor_categoria (proveedor_id, categoria_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Eliminar las relaciones anteriores
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, proveedorId);
                deleteStmt.executeUpdate();
            }
            // Insertar las nuevas relaciones
            if (categoriaIds != null) {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    for (Integer categoriaId : categoriaIds) {
                        insertStmt.setInt(1, proveedorId);
                        insertStmt.setInt(2, categoriaId);
                        insertStmt.addBatch();
                    }
                    insertStmt.executeBatch();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al guardar categorías del proveedor: " + e.getMessage());
        }
    }
} 