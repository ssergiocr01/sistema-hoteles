/* =====================================================================
   Procedimiento almacenado: sp_perfil_puede_ver
   Indica (1/0) si un perfil tiene permiso de VER una ruta concreta.
   Se usa para reforzar el RBAC en el servidor: no basta con ocultar el
   menú, hay que validar el permiso aunque el usuario escriba la URL.
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('sp_perfil_puede_ver', 'P') IS NOT NULL
    DROP PROCEDURE sp_perfil_puede_ver;
GO

CREATE PROCEDURE sp_perfil_puede_ver
    @perfil_id INT,
    @ruta NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CAST(
        CASE WHEN EXISTS (
            SELECT 1
            FROM perfil_opcion po
            INNER JOIN opciones_menu o ON o.id = po.opcion_id
            WHERE po.perfil_id = @perfil_id
              AND o.ruta = @ruta
              AND po.puede_ver = 1
        ) THEN 1 ELSE 0 END
    AS BIT) AS puede_ver;
END
GO

PRINT 'Procedimiento sp_perfil_puede_ver creado.';
GO
