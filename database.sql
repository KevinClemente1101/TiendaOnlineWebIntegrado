-- Script de creación de base de datos para Tienda de Patinetas
-- Base de datos: tienda_patineta

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS tienda_patineta CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tienda_patineta;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'cliente') DEFAULT 'cliente',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen VARCHAR(255),
    categoria_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL
);

-- Tabla de ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabla de detalles de venta
CREATE TABLE detalle_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES ventas(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);

-- Insertar datos de prueba

-- Usuarios de prueba
INSERT INTO usuarios (nombre, email, password, rol) VALUES
('Administrador', 'admin@tiendapatineta.com', 'admin123', 'admin'),
('Cliente Test', 'cliente@test.com', 'cliente123', 'cliente'),
('Juan Pérez', 'juan@email.com', 'juan123', 'cliente'),
('María García', 'maria@email.com', 'maria123', 'cliente');

-- Categorías de patinetas
INSERT INTO categorias (nombre) VALUES
('Patinetas Profesionales'),
('Patinetas para Principiantes'),
('Patinetas Longboard'),
('Patinetas Cruiser'),
('Accesorios');

-- Productos de prueba
INSERT INTO productos (nombre, descripcion, precio, stock, imagen, categoria_id) VALUES
('Patineta Pro Element', 'Patineta profesional con trucks de alta calidad y ruedas de 52mm', 299.99, 15, 'patineta-pro-element.jpg', 1),
('Patineta Beginner Penny', 'Patineta perfecta para principiantes, fácil de manejar', 89.99, 25, 'patineta-beginner-penny.jpg', 2),
('Longboard Sector 9', 'Longboard de 42 pulgadas ideal para cruising y downhill', 199.99, 10, 'longboard-sector9.jpg', 3),
('Cruiser Santa Cruz', 'Patineta cruiser clásica con diseño retro', 159.99, 20, 'cruiser-santacruz.jpg', 4),
('Ruedas Bones', 'Ruedas de 54mm con dureza 99A para máximo rendimiento', 29.99, 50, 'ruedas-bones.jpg', 5),
('Trucks Independent', 'Trucks de aluminio forjado para mayor durabilidad', 45.99, 30, 'trucks-independent.jpg', 5),
('Patineta Plan B', 'Patineta de madera de arce canadiense con gráficos únicos', 179.99, 12, 'patineta-planb.jpg', 1),
('Patineta Girl', 'Patineta con concavidad perfecta para trucos', 189.99, 18, 'patineta-girl.jpg', 1);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_ventas_usuario ON ventas(usuario_id);
CREATE INDEX idx_ventas_fecha ON ventas(fecha);
CREATE INDEX idx_detalle_ventas_venta ON detalle_ventas(venta_id);
CREATE INDEX idx_detalle_ventas_producto ON detalle_ventas(producto_id); 