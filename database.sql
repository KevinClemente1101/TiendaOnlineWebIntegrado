-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-07-2025 a las 18:25:21
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda_patineta`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_categoria_con_id_reutilizado` (IN `p_nombre` VARCHAR(50))   BEGIN
    DECLARE nuevo_id INT;
    
    -- Obtener el próximo ID disponible
    SET nuevo_id = get_next_available_id_categorias();
    
    -- Insertar con el ID específico
    SET @sql = CONCAT('INSERT INTO categorias (id, nombre) VALUES (', nuevo_id, ', "', p_nombre, '")');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    -- Resetear el AUTO_INCREMENT al siguiente ID disponible
    SET @reset_sql = CONCAT('ALTER TABLE categorias AUTO_INCREMENT = ', nuevo_id + 1);
    PREPARE reset_stmt FROM @reset_sql;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    
    SELECT nuevo_id AS nuevo_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_producto_con_id_reutilizado` (IN `p_nombre` VARCHAR(100), IN `p_descripcion` TEXT, IN `p_precio` DECIMAL(10,2), IN `p_stock` INT, IN `p_imagen` VARCHAR(255), IN `p_categoria_id` INT)   BEGIN
    DECLARE nuevo_id INT;
    
    -- Obtener el próximo ID disponible
    SET nuevo_id = get_next_available_id_productos();
    
    -- Insertar con el ID específico
    SET @sql = CONCAT('INSERT INTO productos (id, nombre, descripcion, precio, stock, imagen, categoria_id) VALUES (', nuevo_id, ', "', p_nombre, '", "', IFNULL(p_descripcion, ''), '", ', p_precio, ', ', p_stock, ', "', IFNULL(p_imagen, ''), '", ', IFNULL(p_categoria_id, 'NULL'), ')');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    -- Resetear el AUTO_INCREMENT al siguiente ID disponible
    SET @reset_sql = CONCAT('ALTER TABLE productos AUTO_INCREMENT = ', nuevo_id + 1);
    PREPARE reset_stmt FROM @reset_sql;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    
    SELECT nuevo_id AS nuevo_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_usuario_con_id_reutilizado` (IN `p_nombre` VARCHAR(100), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(255), IN `p_rol` ENUM('admin','cliente'))   BEGIN
    DECLARE nuevo_id INT;
    
    -- Obtener el próximo ID disponible
    SET nuevo_id = get_next_available_id_usuarios();
    
    -- Insertar con el ID específico
    SET @sql = CONCAT('INSERT INTO usuarios (id, nombre, email, password, rol) VALUES (', nuevo_id, ', "', p_nombre, '", "', p_email, '", "', p_password, '", "', p_rol, '")');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    -- Resetear el AUTO_INCREMENT al siguiente ID disponible
    SET @reset_sql = CONCAT('ALTER TABLE usuarios AUTO_INCREMENT = ', nuevo_id + 1);
    PREPARE reset_stmt FROM @reset_sql;
    EXECUTE reset_stmt;
    DEALLOCATE PREPARE reset_stmt;
    
    SELECT nuevo_id AS nuevo_id_usuario;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_available_id_categorias` () RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE next_id INT DEFAULT 1;
    DECLARE done INT DEFAULT 0;
    DECLARE current_id INT;
    
    DECLARE id_cursor CURSOR FOR 
        SELECT id FROM categorias ORDER BY id ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN id_cursor;
    
    read_loop: LOOP
        FETCH id_cursor INTO current_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF current_id = next_id THEN
            SET next_id = next_id + 1;
        ELSE
            LEAVE read_loop;
        END IF;
    END LOOP;
    
    CLOSE id_cursor;
    
    RETURN next_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_available_id_productos` () RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE next_id INT DEFAULT 1;
    DECLARE done INT DEFAULT 0;
    DECLARE current_id INT;
    
    DECLARE id_cursor CURSOR FOR 
        SELECT id FROM productos ORDER BY id ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN id_cursor;
    
    read_loop: LOOP
        FETCH id_cursor INTO current_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF current_id = next_id THEN
            SET next_id = next_id + 1;
        ELSE
            LEAVE read_loop;
        END IF;
    END LOOP;
    
    CLOSE id_cursor;
    
    RETURN next_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_available_id_usuarios` () RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE next_id INT DEFAULT 1;
    DECLARE done INT DEFAULT 0;
    DECLARE current_id INT;
    
    DECLARE id_cursor CURSOR FOR 
        SELECT id FROM usuarios ORDER BY id ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN id_cursor;
    
    read_loop: LOOP
        FETCH id_cursor INTO current_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF current_id = next_id THEN
            SET next_id = next_id + 1;
        ELSE
            LEAVE read_loop;
        END IF;
    END LOOP;
    
    CLOSE id_cursor;
    
    RETURN next_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(5, 'Accesorios'),
(4, 'Patinetas Cruiser'),
(3, 'Patinetas Longboard'),
(2, 'Patinetas para Principiantes'),
(7, 'Patinetas Profesionales'),
(1, 'Patinetas Semi-Profesionales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `venta_id`, `producto_id`, `cantidad`, `subtotal`) VALUES
(1, 1, 3, 1, 199.99),
(2, 2, 2, 2, 179.98),
(3, 2, 8, 1, 189.99),
(4, 3, 2, 1, 89.99),
(5, 4, 3, 1, 199.99),
(6, 5, 4, 1, 159.99),
(7, 6, 2, 1, 89.99),
(8, 7, 7, 1, 179.99),
(9, 8, 7, 1, 179.99),
(10, 9, 4, 1, 159.99),
(12, 11, 2, 1, 89.99),
(13, 11, 7, 1, 179.99),
(14, 11, 8, 1, 189.99);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `imagen` varchar(255) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `categoria_id`, `fecha_creacion`) VALUES
(1, 'Patineta Pro Element', 'Patineta profesional con trucks de alta calidad y ruedas de 52mm', 299.99, 15, '1752282233714.webp', 1, '2025-07-10 16:49:53'),
(2, 'Patineta Beginner Penny', 'Patineta perfecta para principiantes, fácil de manejar', 89.99, 20, '1752282030982.webp', 2, '2025-07-10 16:49:53'),
(3, 'Longboard Sector 9', 'Longboard de 42 pulgadas ideal para cruising y downhill', 199.99, 7, '1752281965943.jpg', 3, '2025-07-10 16:49:53'),
(4, 'Cruiser Santa Cruz', 'Patineta cruiser clásica con diseño retro', 159.99, 18, '1752281598587.webp', 4, '2025-07-10 16:49:53'),
(5, 'Ruedas Bones', 'Ruedas de 54mm con dureza 99A para máximo rendimiento', 29.99, 50, '1752282280907.webp', 5, '2025-07-10 16:49:53'),
(6, 'Trucks Independent', 'Trucks de aluminio forjado para mayor durabilidad', 45.99, 30, '1752282338873.jpg', 5, '2025-07-10 16:49:53'),
(7, 'Patineta Plan B', 'Patineta de madera de arce canadiense con gráficos únicos', 179.99, 9, '1752282164836.jpeg', 1, '2025-07-10 16:49:53'),
(8, 'Patineta Girl', 'Patineta con concavidad perfecta para trucos', 189.99, 16, '1752282101840.webp', 1, '2025-07-10 16:49:53'),
(10, 'Tablas de skate Fun Skateboards', 'de Guatambú 7 capas, calidad Premium, profesional, con concave, tail y nose, liviana y resistente.', 154.80, 12, '1752282752160.jpeg', 5, '2025-07-12 01:12:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `ruc` varchar(11) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `productos` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `ruc`, `telefono`, `productos`) VALUES
(1, 'peru patinas sac ', '78545545445', '937546225', 'patinetas penny');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `distrito` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','cliente') DEFAULT 'cliente',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `telefono`, `distrito`, `direccion`, `password`, `rol`, `fecha_registro`) VALUES
(1, 'Administrador', 'admin@tiendapatineta.com', '', '', '', '$2a$12$WwOeRpygqXfHbIxhCDpQ8.Zijb5pxZfJD3H7v7scHKSoJQTeP5xva', 'admin', '2025-07-10 16:49:52'),
(2, 'Cliente Test', 'cliente@test.com', '', '', '', 'cliente123', 'cliente', '2025-07-10 16:49:52'),
(6, 'Kevin ', 'Clemente11@gmail.com', '', '', '', '12345', 'admin', '2025-07-10 18:05:56'),
(8, 'angel', 'angel2@gmail.com', '905388644', 'ancon', 'ancon', '$2a$10$Mu2pHr13YaGR6u8LdFc1G.eS0ItIQbZKy50d4MxmIqMfphWrA34.2', 'cliente', '2025-07-11 15:43:26'),
(9, 'erik', 'erikmilla456@gmail.com', '908503404', 'ancon', 'las gardenias', '$2a$10$l.ipOWTBCkpxlio2Ozw22.IOiaNIxRyJMEt66fgEBE.fMHWcyxMSm', 'cliente', '2025-07-11 16:17:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `direccion_envio` varchar(255) NOT NULL,
  `metodo_pago` varchar(20) NOT NULL,
  `referencia_pago` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `usuario_id`, `fecha`, `total`, `direccion_envio`, `metodo_pago`, `referencia_pago`) VALUES
(1, 2, '2025-07-10 19:09:12', 199.99, '', '', NULL),
(2, 2, '2025-07-10 21:54:40', 369.97, '', '', NULL),
(3, 2, '2025-07-10 21:55:51', 89.99, '', '', NULL),
(4, 2, '2025-07-11 14:16:18', 199.99, '', '', NULL),
(5, 2, '2025-07-11 14:38:27', 169.99, 'ancon', 'tarjeta', '39123921738217332'),
(6, 2, '2025-07-11 14:47:54', 99.99, 'ancon', 'yape', '989823727'),
(7, 2, '2025-07-11 14:48:49', 189.99, 'ancon', 'tarjeta', '39123921738217332'),
(8, 2, '2025-07-11 14:52:34', 189.99, 'ancon', 'tarjeta', '39123921738217332'),
(9, 2, '2025-07-11 14:53:02', 169.99, 'ancon', 'yape', '989823727'),
(11, 9, '2025-07-11 19:19:59', 469.97, 'ancon', 'tarjeta', '39123921738217332');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_detalle_ventas_venta` (`venta_id`),
  ADD KEY `idx_detalle_ventas_producto` (`producto_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_productos_categoria` (`categoria_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ventas_usuario` (`usuario_id`),
  ADD KEY `idx_ventas_fecha` (`fecha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
