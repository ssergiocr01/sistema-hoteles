/* =====================================================================
   Sistema de Administración de Cadena de Hoteles
   Datos semilla (datos iniciales mínimos) · SQL Server
   Archivo: database/02-seed.sql

   Inserta: perfiles, opciones de menú, usuario administrador inicial
   y los permisos del administrador.

   Es idempotente: puede ejecutarse varias veces sin duplicar datos.

   Ejecutar con sqlcmd:
     sqlcmd -S .\SQLEXPRESS -E -i database\02-seed.sql

   Usuario inicial:  admin@hoteles.com
   Contraseña:       Admin123$   (cámbiala después de la primera entrada)
   ===================================================================== */

USE sistema_hoteles;
GO

/* ----------------------------- PERFILES ----------------------------- */
IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'Administrador')
    INSERT INTO perfiles (nombre, descripcion) VALUES ('Administrador', 'Acceso total al sistema');
IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'Recepcionista')
    INSERT INTO perfiles (nombre, descripcion) VALUES ('Recepcionista', N'Operación de recepción del hotel');
IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'Cajero')
    INSERT INTO perfiles (nombre, descripcion) VALUES ('Cajero', N'Facturación y cobros');
IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'Inventario')
    INSERT INTO perfiles (nombre, descripcion) VALUES ('Inventario', 'Proveedores e inventario');
GO

/* -------------------- OPCIONES DE MENÚ (NIVEL 1) -------------------- */
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Habitaciones')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Habitaciones', '/habitaciones', 'bed', 1);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Reservas')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Reservas', '/reservas', 'calendar', 2);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Check-in / Check-out')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Check-in / Check-out', '/check-in', 'login', 3);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Clientes')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Clientes', '/clientes', 'users', 4);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = N'Facturación')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, N'Facturación', '/facturacion', 'receipt', 5);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Inventario')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Inventario', '/inventario', 'box', 6);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Proveedores')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Proveedores', '/proveedores', 'truck', 7);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Reportes')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, 'Reportes', '/reportes', 'chart', 8);
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = N'Configuración')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden) VALUES (NULL, N'Configuración', '/configuracion', 'settings', 9);
GO

/* ---------------------- OPCIONES DE MENÚ (SUBMENÚS) ---------------------- */
-- Submenús de Reportes
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = N'Reporte de ocupación')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, N'Reporte de ocupación', '/reportes/ocupacion', 'chart', 1 FROM opciones_menu WHERE nombre = 'Reportes';
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Reporte de ingresos')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, 'Reporte de ingresos', '/reportes/ingresos', 'chart', 2 FROM opciones_menu WHERE nombre = 'Reportes';
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Reporte consolidado')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, 'Reporte consolidado', '/reportes/consolidado', 'chart', 3 FROM opciones_menu WHERE nombre = 'Reportes';

-- Submenús de Configuración
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Usuarios')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, 'Usuarios', '/configuracion/usuarios', 'user', 1 FROM opciones_menu WHERE nombre = 'Configuración';
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Perfiles')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, 'Perfiles', '/configuracion/perfiles', 'shield', 2 FROM opciones_menu WHERE nombre = N'Configuración';
IF NOT EXISTS (SELECT 1 FROM opciones_menu WHERE nombre = 'Errores del sistema')
    INSERT INTO opciones_menu (padre_id, nombre, ruta, icono, orden)
    SELECT id, 'Errores del sistema', '/configuracion/errores', 'alert', 3 FROM opciones_menu WHERE nombre = N'Configuración';
GO

/* --------------------- USUARIO ADMINISTRADOR INICIAL --------------------- */
-- Contraseña: Admin123$  (hash bcrypt generado con bcryptjs)
IF NOT EXISTS (SELECT 1 FROM usuarios WHERE email = 'admin@hoteles.com')
    INSERT INTO usuarios (perfil_id, nombre, email, password_hash, activo)
    SELECT id, 'Administrador', 'admin@hoteles.com',
           '$2b$10$6zv3HlcSLjVqnALQVa8c3uoBk5FQD.B9wyJXedgCTPZ5ESGp.Wy2i', 1
    FROM perfiles WHERE nombre = 'Administrador';
GO

/* ------- PERMISOS: el Administrador puede TODO en TODAS las opciones ------- */
INSERT INTO perfil_opcion (perfil_id, opcion_id, puede_ver, puede_crear, puede_editar, puede_eliminar)
SELECT p.id, o.id, 1, 1, 1, 1
FROM perfiles p
CROSS JOIN opciones_menu o
WHERE p.nombre = 'Administrador'
  AND NOT EXISTS (
      SELECT 1 FROM perfil_opcion po WHERE po.perfil_id = p.id AND po.opcion_id = o.id
  );
GO

/* --------------- USUARIO RECEPCIONISTA (DE PRUEBA) --------------- */
-- Contraseña: Recep123$  (para demostrar el RBAC: menú reducido y 403)
IF NOT EXISTS (SELECT 1 FROM usuarios WHERE email = 'recepcion@hoteles.com')
    INSERT INTO usuarios (perfil_id, nombre, email, password_hash, activo)
    SELECT id, N'Ana Recepción', 'recepcion@hoteles.com',
           '$2b$10$rj5EWHwvlAEfna0IbT52M.Wt9IeZq6607.zOAiNgU.pHwW9YLfwim', 1
    FROM perfiles WHERE nombre = 'Recepcionista';
GO

/* ----- PERMISOS DEL RECEPCIONISTA: solo opciones operativas ----- */
INSERT INTO perfil_opcion (perfil_id, opcion_id, puede_ver, puede_crear, puede_editar, puede_eliminar)
SELECT p.id, o.id, 1, 1, 1, 0
FROM perfiles p
CROSS JOIN opciones_menu o
WHERE p.nombre = 'Recepcionista'
  AND o.ruta IN ('/habitaciones', '/reservas', '/check-in', '/clientes', '/facturacion')
  AND NOT EXISTS (
      SELECT 1 FROM perfil_opcion po WHERE po.perfil_id = p.id AND po.opcion_id = o.id
  );
GO

PRINT 'Datos semilla cargados correctamente.';
GO
