package com.tiendapatineta.model;

public class Proveedor {
    private int id;
    private String nombre;
    private String ruc;
    private String telefono;
    private String productos;

    public Proveedor() {}

    public Proveedor(int id, String nombre, String ruc, String telefono, String productos) {
        this.id = id;
        this.nombre = nombre;
        this.ruc = ruc;
        this.telefono = telefono;
        this.productos = productos;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getRuc() { return ruc; }
    public void setRuc(String ruc) { this.ruc = ruc; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getProductos() { return productos; }
    public void setProductos(String productos) { this.productos = productos; }
} 