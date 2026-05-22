/* =====================================================================
   Procedimiento almacenado: sp_log_errores_listar
   Devuelve los últimos errores registrados (más recientes primero).
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('sp_log_errores_listar', 'P') IS NOT NULL
    DROP PROCEDURE sp_log_errores_listar;
GO

CREATE PROCEDURE sp_log_errores_listar
    @top INT = 100
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@top)
        l.id,
        l.fecha_hora,
        l.mensaje,
        l.detalle,
        l.ruta,
        l.metodo,
        l.origen,
        l.usuario_id,
        u.email AS usuario_email
    FROM log_errores l
    LEFT JOIN usuarios u ON u.id = l.usuario_id
    ORDER BY l.id DESC;
END
GO

PRINT 'Procedimiento sp_log_errores_listar creado.';
GO
