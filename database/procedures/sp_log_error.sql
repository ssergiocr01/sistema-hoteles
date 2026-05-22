/* =====================================================================
   Procedimiento almacenado: sp_log_error
   Inserta un error en la tabla log_errores. Los parámetros opcionales
   tienen valor por defecto NULL.
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('sp_log_error', 'P') IS NOT NULL
    DROP PROCEDURE sp_log_error;
GO

CREATE PROCEDURE sp_log_error
    @mensaje    NVARCHAR(1000),
    @detalle    NVARCHAR(MAX) = NULL,
    @ruta       NVARCHAR(300) = NULL,
    @metodo     NVARCHAR(10)  = NULL,
    @origen     NVARCHAR(50)  = NULL,
    @usuario_id INT           = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO log_errores (mensaje, detalle, ruta, metodo, origen, usuario_id)
    VALUES (@mensaje, @detalle, @ruta, @metodo, @origen, @usuario_id);
END
GO

PRINT 'Procedimiento sp_log_error creado.';
GO
