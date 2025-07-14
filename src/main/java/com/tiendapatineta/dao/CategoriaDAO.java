package com.tiendapatineta.dao;

import com.tiendapatineta.model.Categoria;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.tiendapatineta.model.Proveedor;

public class CategoriaDAO {
    
    public List<Categoria> obtenerTodas() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias ORDER BY nombre";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                categorias.add(new Categoria(
                    rs.getInt("id"),
                    rs.getString("nombre")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener categorías: " + e.getMessage());
        }
        return categorias;
    }
    
    public Categoria obtenerPorId(int id) {
        String sql = "SELECT * FROM categorias WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Categoria categoria = new Categoria(
                        rs.getInt("id"),
                        rs.getString("nombre")
                    );
                    categoria.setProveedores(obtenerProveedoresPorCategoria(id));
                    return categoria;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener categoría: " + e.getMessage());
        }
        return null;
    }
    
    public boolean agregar(Categoria categoria) {
        String sql = "INSERT INTO categorias (nombre) VALUES (?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoria.getNombre());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al agregar categoría: " + e.getMessage());
            return false;
        }
    }
    
    public boolean actualizar(Categoria categoria) {
        String sql = "UPDATE categorias SET nombre = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, categoria.getNombre());
            stmt.setInt(2, categoria.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar categoría: " + e.getMessage());
            return false;
        }
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM categorias WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar categoría: " + e.getMessage());
            return false;
        }
    }

    public List<Proveedor> obtenerProveedoresPorCategoria(int categoriaId) {
        List<Proveedor> proveedores = new ArrayList<>();
        String sql = "SELECT p.id, p.nombre, p.ruc, p.telefono, p.productos FROM proveedores p INNER JOIN proveedor_categoria pc ON p.id = pc.proveedor_id WHERE pc.categoria_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoriaId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Proveedor proveedor = new Proveedor(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("ruc"),
                        rs.getString("telefono"),
                        rs.getString("productos")
                    );
                    proveedores.add(proveedor);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener proveedores de la categoría: " + e.getMessage());
        }
        return proveedores;
    }

    public void guardarProveedoresCategoria(int categoriaId, List<Integer> proveedorIds) {
        String deleteSql = "DELETE FROM proveedor_categoria WHERE categoria_id = ?";
        String insertSql = "INSERT INTO proveedor_categoria (proveedor_id, categoria_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Eliminar las relaciones anteriores
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, categoriaId);
                deleteStmt.executeUpdate();
            }
            // Insertar las nuevas relaciones
            if (proveedorIds != null) {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    for (Integer proveedorId : proveedorIds) {
                        insertStmt.setInt(1, proveedorId);
                        insertStmt.setInt(2, categoriaId);
                        insertStmt.addBatch();
                    }
                    insertStmt.executeBatch();
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al guardar proveedores de la categoría: " + e.getMessage());
        }
    }
} 