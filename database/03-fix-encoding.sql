/* =====================================================================
   Corrección de codificación de caracteres (tildes y ñ)
   Archivo: database/03-fix-encoding.sql

   Repara los textos que se guardaron mal (mojibake) en una carga previa.
   Usa literales Unicode con prefijo N'...'.

   IMPORTANTE: ejecutar indicando UTF-8 para que sqlcmd lea bien el archivo:
     sqlcmd -S .\SQLEXPRESS -E -f 65001 -i database\03-fix-encoding.sql
   ===================================================================== */

USE sistema_hoteles;
GO

UPDATE opciones_menu SET nombre = N'Facturación'          WHERE ruta = '/facturacion';
UPDATE opciones_menu SET nombre = N'Configuración'        WHERE ruta = '/configuracion';
UPDATE opciones_menu SET nombre = N'Reporte de ocupación' WHERE ruta = '/reportes/ocupacion';

UPDATE perfiles SET descripcion = N'Operación de recepción del hotel' WHERE nombre = 'Recepcionista';
UPDATE perfiles SET descripcion = N'Facturación y cobros'             WHERE nombre = 'Cajero';
GO

PRINT 'Codificación corregida.';
GO
