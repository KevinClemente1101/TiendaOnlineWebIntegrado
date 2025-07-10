# Directorio Uploads

Este directorio se utiliza para almacenar las imágenes de los productos subidas por los administradores.

## Estructura
- Las imágenes se guardan con nombres únicos basados en timestamp
- Formato: `[timestamp]_[nombre_original]`
- Ejemplo: `1752115543952_Patineta.jpg`

## Configuración
- El directorio se crea automáticamente si no existe
- Las imágenes son accesibles públicamente a través de `/uploads/[nombre_archivo]`
- Tamaño máximo de archivo: 10MB
- Tipos permitidos: imágenes (image/*)

## Notas importantes
- Este directorio debe tener permisos de escritura para el servidor web
- En producción, considere usar un servicio de almacenamiento en la nube
- Las imágenes se eliminan manualmente al eliminar productos 