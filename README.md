# 🛹 Tienda de Patinetas - Perú

Sistema web de gestión comercial para una tienda de patinetas desarrollado con JSP, Servlets y MySQL.

## 📋 Descripción

Este proyecto implementa un sistema completo de gestión comercial para una tienda de patinetas en Perú, incluyendo:

- **Panel de Administración**: Gestión completa de productos, categorías, usuarios y ventas
- **Tienda Online**: Catálogo de productos con filtros y búsqueda
- **Sistema de Usuarios**: Autenticación y roles (admin/cliente)
- **Gestión de Stock**: Control de inventario en tiempo real
- **Interfaz Moderna**: Diseño responsive con Bootstrap 5

## 🛠️ Tecnologías Utilizadas

- **Backend**: Java EE (Jakarta), JSP, Servlets
- **Base de Datos**: MySQL 8.0
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Servidor**: Apache Tomcat 10
- **Herramientas**: Maven, NetBeans

## 📦 Requisitos Previos

- Java JDK 11 o superior
- Apache Tomcat 10
- MySQL 8.0
- Maven 3.6+
- NetBeans IDE (recomendado)

## 🚀 Instalación y Configuración

### 1. Clonar el Proyecto

```bash
git clone <url-del-repositorio>
cd TiendaPatineta
```

### 2. Configurar la Base de Datos

1. **Crear la base de datos MySQL:**
   ```sql
   CREATE DATABASE tienda_patineta CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. **Ejecutar el script de inicialización:**
   ```bash
   mysql -u root -p tienda_patineta < database.sql
   ```

3. **Configurar la conexión** en `src/main/java/com/tiendapatineta/util/DatabaseConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/tienda_patineta?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
   private static final String USER = "tu_usuario";
   private static final String PASSWORD = "tu_contraseña";
   ```

### 3. Compilar y Desplegar

1. **Compilar con Maven:**
   ```bash
   mvn clean package
   ```

2. **Desplegar en Tomcat:**
   - Copiar el archivo `target/TiendaPatineta-1.0-SNAPSHOT.war` a la carpeta `webapps` de Tomcat
   - O usar el IDE para desplegar directamente

### 4. Crear Directorio de Uploads

```bash
mkdir -p $CATALINA_HOME/webapps/TiendaPatineta/uploads
chmod 755 $CATALINA_HOME/webapps/TiendaPatineta/uploads
```

## 👥 Usuarios de Prueba

El sistema incluye usuarios predefinidos para pruebas:

### Administrador
- **Email**: admin@tiendapatineta.com
- **Contraseña**: admin123
- **Rol**: Administrador completo

### Cliente
- **Email**: cliente@test.com
- **Contraseña**: cliente123
- **Rol**: Cliente

## 🎯 Funcionalidades Principales

### Panel de Administración

#### Gestión de Productos
- ✅ Agregar nuevos productos
- ✅ Editar productos existentes
- ✅ Eliminar productos
- ✅ Subir imágenes de productos
- ✅ Control de stock
- ✅ Categorización de productos

#### Gestión de Categorías
- ✅ Crear categorías
- ✅ Editar categorías
- ✅ Eliminar categorías

#### Gestión de Usuarios
- ✅ Ver lista de usuarios
- ✅ Editar información de usuarios
- ✅ Eliminar usuarios

#### Reportes
- ✅ Ventas por período
- ✅ Productos más vendidos
- ✅ Alertas de stock bajo

### Tienda Online

#### Catálogo de Productos
- ✅ Visualización de productos
- ✅ Filtrado por categorías
- ✅ Búsqueda de productos
- ✅ Información detallada de productos

#### Sistema de Usuarios
- ✅ Registro de usuarios
- ✅ Inicio de sesión
- ✅ Gestión de perfiles

## 📁 Estructura del Proyecto

```
TiendaPatineta/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── tiendapatineta/
│       │           ├── dao/           # Data Access Objects
│       │           ├── model/         # Modelos de datos
│       │           ├── servlet/       # Servlets
│       │           └── util/          # Utilidades
│       ├── resources/
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── jsp/              # Páginas JSP
│           │   │   ├── admin/        # Panel de administración
│           │   │   └── error/        # Páginas de error
│           │   └── web.xml           # Configuración web
│           ├── uploads/              # Imágenes subidas
│           └── index.jsp             # Página principal
├── database.sql                      # Script de base de datos
├── pom.xml                          # Configuración Maven
└── README.md                        # Este archivo
```

## 🔧 Configuración Adicional

### Variables de Entorno (Opcional)

```bash
export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=tienda_patineta
export DB_USER=root
export DB_PASS=tu_contraseña
```

### Configuración de Tomcat

Agregar en `$CATALINA_HOME/conf/server.xml`:

```xml
<Context path="/TiendaPatineta" docBase="TiendaPatineta" reloadable="true">
    <Resources cachingAllowed="true" cacheMaxSize="100000" />
</Context>
```

## 🐛 Solución de Problemas

### Error de Conexión a Base de Datos
- Verificar que MySQL esté ejecutándose
- Confirmar credenciales en `DatabaseConnection.java`
- Verificar que la base de datos `tienda_patineta` exista

### Error de Permisos en Uploads
```bash
chmod -R 755 $CATALINA_HOME/webapps/TiendaPatineta/uploads
chown -R tomcat:tomcat $CATALINA_HOME/webapps/TiendaPatineta/uploads
```

### Error de Compilación
- Verificar versión de Java (JDK 11+)
- Limpiar y recompilar: `mvn clean compile`

## 📝 Casos de Uso Implementados

### RF1: Búsqueda y Filtrado de Productos
- ✅ Búsqueda por nombre de producto
- ✅ Filtrado por categorías
- ✅ Visualización de stock disponible

### RF2: Registro de Ventas
- ✅ Sistema de carrito de compras
- ✅ Registro de ventas con detalles
- ✅ Actualización automática de stock

### RF3: Validación de Credenciales
- ✅ Autenticación de usuarios
- ✅ Control de acceso por roles
- ✅ Protección de rutas administrativas

## 🚀 Despliegue en Producción

### Configuración de Seguridad

1. **Cambiar contraseñas por defecto**
2. **Configurar HTTPS**
3. **Implementar rate limiting**
4. **Configurar backup automático de base de datos**

### Optimización de Rendimiento

1. **Configurar pool de conexiones**
2. **Implementar caché de productos**
3. **Optimizar consultas SQL**
4. **Configurar CDN para imágenes**

## 📞 Soporte

Para soporte técnico o reportar problemas:

- **Email**: soporte@tiendapatineta.com
- **Documentación**: [Wiki del proyecto]
- **Issues**: [GitHub Issues]

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

**Desarrollado con ❤️ para la comunidad de patinetas en Perú** 