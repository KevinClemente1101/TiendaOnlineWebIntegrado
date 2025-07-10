package com.tiendapatineta.servlet;

import com.tiendapatineta.dao.ProductoDAO;
import com.tiendapatineta.dao.CategoriaDAO;
import com.tiendapatineta.model.Producto;
import com.tiendapatineta.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.io.File;

@WebServlet("/admin/productos/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProductoServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
        categoriaDAO = new CategoriaDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Listar productos
            listarProductos(request, response);
        } else if (pathInfo.equals("/nuevo")) {
            // Mostrar formulario para nuevo producto
            mostrarFormularioNuevo(request, response);
        } else if (pathInfo.startsWith("/editar/")) {
            // Mostrar formulario para editar producto
            String idStr = pathInfo.substring(8);
            try {
                int id = Integer.parseInt(idStr);
                mostrarFormularioEditar(request, response, id);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else if (pathInfo.startsWith("/eliminar/")) {
            // Eliminar producto
            String idStr = pathInfo.substring(10);
            try {
                int id = Integer.parseInt(idStr);
                eliminarProducto(request, response, id);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Crear nuevo producto
            crearProducto(request, response);
        } else if (pathInfo.startsWith("/actualizar/")) {
            // Actualizar producto existente
            String idStr = pathInfo.substring(12);
            try {
                int id = Integer.parseInt(idStr);
                actualizarProducto(request, response, id);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void listarProductos(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Producto> productos = productoDAO.obtenerTodos();
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/productos/lista.jsp").forward(request, response);
    }
    
    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/productos/formulario.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        Producto producto = productoDAO.obtenerPorId(id);
        if (producto == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        List<Categoria> categorias = categoriaDAO.obtenerTodas();
        request.setAttribute("producto", producto);
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/productos/formulario.jsp").forward(request, response);
    }
    
    private void crearProducto(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoria_id");
        
        // Validar campos
        if (nombre == null || nombre.trim().isEmpty()) {
            request.setAttribute("error", "El nombre es obligatorio");
            mostrarFormularioNuevo(request, response);
            return;
        }
        
        try {
            BigDecimal precio = new BigDecimal(precioStr);
            int stock = Integer.parseInt(stockStr);
            int categoriaId = Integer.parseInt(categoriaIdStr);
            
            // Procesar imagen
            String imagen = "";
            Part filePart = request.getPart("imagen");
            if (filePart != null && filePart.getSize() > 0) {
                // Validar que sea una imagen válida
                if (!esImagenValida(filePart)) {
                    request.setAttribute("error", "El archivo debe ser una imagen válida (JPG, PNG, GIF, WEBP)");
                    mostrarFormularioNuevo(request, response);
                    return;
                }
                
                String fileName = generarNombreArchivo(filePart);
                String uploadPath = getServletContext().getRealPath("/uploads/");
                
                // Crear el directorio si no existe
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Verificar que el directorio se creó correctamente
                if (!uploadDir.exists() || !uploadDir.isDirectory()) {
                    throw new IOException("No se pudo crear el directorio de uploads: " + uploadPath);
                }
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                imagen = fileName;
            }
            
            // Crear producto
            Producto producto = new Producto();
            producto.setNombre(nombre.trim());
            producto.setDescripcion(descripcion != null ? descripcion.trim() : "");
            producto.setPrecio(precio);
            producto.setStock(stock);
            producto.setImagen(imagen);
            producto.setCategoriaId(categoriaId);
            
            if (productoDAO.agregar(producto)) {
                request.setAttribute("mensaje", "Producto creado exitosamente");
            } else {
                request.setAttribute("error", "Error al crear el producto");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Valores numéricos inválidos");
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar la imagen: " + e.getMessage());
        }
        
        listarProductos(request, response);
    }
    
    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        
        Producto producto = productoDAO.obtenerPorId(id);
        if (producto == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoria_id");
        
        // Validar campos
        if (nombre == null || nombre.trim().isEmpty()) {
            request.setAttribute("error", "El nombre es obligatorio");
            mostrarFormularioEditar(request, response, id);
            return;
        }
        
        try {
            BigDecimal precio = new BigDecimal(precioStr);
            int stock = Integer.parseInt(stockStr);
            int categoriaId = Integer.parseInt(categoriaIdStr);
            
            // Procesar imagen
            Part filePart = request.getPart("imagen");
            if (filePart != null && filePart.getSize() > 0) {
                // Validar que sea una imagen válida
                if (!esImagenValida(filePart)) {
                    request.setAttribute("error", "El archivo debe ser una imagen válida (JPG, PNG, GIF, WEBP)");
                    mostrarFormularioEditar(request, response, id);
                    return;
                }
                
                // Eliminar imagen anterior si existe
                if (producto.getImagen() != null && !producto.getImagen().trim().isEmpty()) {
                    try {
                        String uploadPath = getServletContext().getRealPath("/uploads/");
                        File oldImageFile = new File(uploadPath + File.separator + producto.getImagen());
                        if (oldImageFile.exists()) {
                            oldImageFile.delete();
                        }
                    } catch (Exception e) {
                        System.err.println("Error al eliminar imagen anterior: " + e.getMessage());
                    }
                }
                
                String fileName = generarNombreArchivo(filePart);
                String uploadPath = getServletContext().getRealPath("/uploads/");
                
                // Crear el directorio si no existe
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Verificar que el directorio se creó correctamente
                if (!uploadDir.exists() || !uploadDir.isDirectory()) {
                    throw new IOException("No se pudo crear el directorio de uploads: " + uploadPath);
                }
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                producto.setImagen(fileName);
            }
            
            // Actualizar producto
            producto.setNombre(nombre.trim());
            producto.setDescripcion(descripcion != null ? descripcion.trim() : "");
            producto.setPrecio(precio);
            producto.setStock(stock);
            producto.setCategoriaId(categoriaId);
            
            if (productoDAO.actualizar(producto)) {
                request.setAttribute("mensaje", "Producto actualizado exitosamente");
            } else {
                request.setAttribute("error", "Error al actualizar el producto");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Valores numéricos inválidos");
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar la imagen: " + e.getMessage());
        }
        
        listarProductos(request, response);
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response, int id) 
            throws ServletException, IOException {
        
        // Obtener el producto antes de eliminarlo para acceder a su imagen
        Producto producto = productoDAO.obtenerPorId(id);
        
        if (productoDAO.eliminar(id)) {
            // Eliminar la imagen del archivo si existe
            if (producto != null && producto.getImagen() != null && !producto.getImagen().trim().isEmpty()) {
                try {
                    String uploadPath = getServletContext().getRealPath("/uploads/");
                    File imageFile = new File(uploadPath + File.separator + producto.getImagen());
                    if (imageFile.exists()) {
                        imageFile.delete();
                    }
                } catch (Exception e) {
                    // Log del error pero no fallar la operación
                    System.err.println("Error al eliminar imagen: " + e.getMessage());
                }
            }
            request.setAttribute("mensaje", "Producto eliminado exitosamente");
        } else {
            request.setAttribute("error", "Error al eliminar el producto");
        }
        
        listarProductos(request, response);
    }
    
    /**
     * Valida si el archivo es una imagen válida
     */
    private boolean esImagenValida(Part filePart) {
        if (filePart == null || filePart.getSize() == 0) {
            return false;
        }
        
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return false;
        }
        
        // Validar extensiones permitidas
        String fileName = filePart.getSubmittedFileName();
        if (fileName == null) {
            return false;
        }
        
        String extension = fileName.toLowerCase();
        return extension.endsWith(".jpg") || extension.endsWith(".jpeg") || 
               extension.endsWith(".png") || extension.endsWith(".gif") || 
               extension.endsWith(".webp");
    }
    
    /**
     * Genera un nombre de archivo seguro
     */
    private String generarNombreArchivo(Part filePart) {
        String originalName = filePart.getSubmittedFileName();
        String extension = "";
        
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf("."));
        }
        
        return System.currentTimeMillis() + extension;
    }
} 