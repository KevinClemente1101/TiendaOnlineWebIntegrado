package com.tiendapatineta.dao;

import com.tiendapatineta.model.Producto;
import com.tiendapatineta.model.Categoria;
import com.tiendapatineta.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    public List<Producto> obtenerTodos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre as categoria_nombre FROM productos p " +
                    "LEFT JOIN categorias c ON p.categoria_id = c.id " +
                    "ORDER BY p.nombre";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Producto producto = new Producto(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("descripcion"),
                    rs.getBigDecimal("precio"),
                    rs.getInt("stock"),
                    rs.getString("imagen"),
                    rs.getInt("categoria_id")
                );
                
                if (rs.getInt("categoria_id") > 0) {
                    Categoria categoria = new Categoria(
                        rs.getInt("categoria_id"),
                        rs.getString("categoria_nombre")
                    );
                    producto.setCategoria(categoria);
                }
                
                productos.add(producto);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos: " + e.getMessage());
        }
        return productos;
    }
    
    public List<Producto> obtenerPorCategoria(int categoriaId) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre as categoria_nombre FROM productos p " +
                    "LEFT JOIN categorias c ON p.categoria_id = c.id " +
                    "WHERE p.categoria_id = ? ORDER BY p.nombre";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoriaId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Producto producto = new Producto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getBigDecimal("precio"),
                        rs.getInt("stock"),
                        rs.getString("imagen"),
                        rs.getInt("categoria_id")
                    );
                    
                    if (rs.getInt("categoria_id") > 0) {
                        Categoria categoria = new Categoria(
                            rs.getInt("categoria_id"),
                            rs.getString("categoria_nombre")
                        );
                        producto.setCategoria(categoria);
                    }
                    
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos por categoría: " + e.getMessage());
        }
        return productos;
    }
    
    public List<Producto> buscarPorNombre(String nombre) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre as categoria_nombre FROM productos p " +
                    "LEFT JOIN categorias c ON p.categoria_id = c.id " +
                    "WHERE p.nombre LIKE ? ORDER BY p.nombre";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + nombre + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Producto producto = new Producto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getBigDecimal("precio"),
                        rs.getInt("stock"),
                        rs.getString("imagen"),
                        rs.getInt("categoria_id")
                    );
                    
                    if (rs.getInt("categoria_id") > 0) {
                        Categoria categoria = new Categoria(
                            rs.getInt("categoria_id"),
                            rs.getString("categoria_nombre")
                        );
                        producto.setCategoria(categoria);
                    }
                    
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar productos: " + e.getMessage());
        }
        return productos;
    }
    
    public Producto obtenerPorId(int id) {
        String sql = "SELECT p.*, c.nombre as categoria_nombre FROM productos p " +
                    "LEFT JOIN categorias c ON p.categoria_id = c.id " +
                    "WHERE p.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Producto producto = new Producto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getBigDecimal("precio"),
                        rs.getInt("stock"),
                        rs.getString("imagen"),
                        rs.getInt("categoria_id")
                    );
                    
                    if (rs.getInt("categoria_id") > 0) {
                        Categoria categoria = new Categoria(
                            rs.getInt("categoria_id"),
                            rs.getString("categoria_nombre")
                        );
                        producto.setCategoria(categoria);
                    }
                    
                    return producto;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener producto: " + e.getMessage());
        }
        return null;
    }
    
    public boolean agregar(Producto producto) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, stock, imagen, categoria_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setString(5, producto.getImagen());
            stmt.setInt(6, producto.getCategoriaId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al agregar producto: " + e.getMessage());
            return false;
        }
    }
    
    public boolean actualizar(Producto producto) {
        String sql = "UPDATE productos SET nombre = ?, descripcion = ?, precio = ?, " +
                    "stock = ?, imagen = ?, categoria_id = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setString(5, producto.getImagen());
            stmt.setInt(6, producto.getCategoriaId());
            stmt.setInt(7, producto.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM productos WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar producto: " + e.getMessage());
            return false;
        }
    }
    
    public boolean actualizarStock(int id, int cantidad) {
        String sql = "UPDATE productos SET stock = stock - ? WHERE id = ? AND stock >= ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cantidad);
            stmt.setInt(2, id);
            stmt.setInt(3, cantidad);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar stock: " + e.getMessage());
            return false;
        }
    }

    public void descontarStock(int productoId, int cantidad) {
        String sql = "UPDATE productos SET stock = stock - ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cantidad);
            stmt.setInt(2, productoId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al descontar stock: " + e.getMessage());
        }
    }

    public List<Producto> obtenerStockBajo(int umbral) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE stock > 0 AND stock <= ? ORDER BY stock ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, umbral);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getBigDecimal("precio"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setImagen(rs.getString("imagen"));
                    producto.setCategoriaId(rs.getInt("categoria_id"));
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos con stock bajo: " + e.getMessage());
        }
        return productos;
    }
} 