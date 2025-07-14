package com.tiendapatineta.model;

import java.io.Serializable;
import java.util.List;

public class Categoria implements Serializable {
    private int id;
    private String nombre;
    private List<Proveedor> proveedores;
    
    public Categoria() {}
    
    public Categoria(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }
    
    // Getters y Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public List<Proveedor> getProveedores() { return proveedores; }
    public void setProveedores(List<Proveedor> proveedores) { this.proveedores = proveedores; }
    
    @Override
    public String toString() {
        return "Categoria{" + "id=" + id + ", nombre=" + nombre + '}';
    }
} 