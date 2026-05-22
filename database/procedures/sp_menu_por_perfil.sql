/* =====================================================================
   Procedimiento almacenado: sp_menu_por_perfil
   Devuelve las opciones de menú que un perfil puede VER (puede_ver = 1),
   ordenadas. La aplicación arma el árbol (padres e hijos) a partir de
   padre_id. Implementa el menú dinámico del RBAC (RF-36).
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('sp_menu_por_perfil', 'P') IS NOT NULL
    DROP PROCEDURE sp_menu_por_perfil;
GO

CREATE PROCEDURE sp_menu_por_perfil
    @perfil_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.id,
        o.padre_id,
        o.nombre,
        o.ruta,
        o.icono,
        o.orden
    FROM opciones_menu o
    INNER JOIN perfil_opcion po ON po.opcion_id = o.id
    WHERE po.perfil_id = @perfil_id
      AND po.puede_ver = 1
    ORDER BY o.orden;
END
GO

PRINT 'Procedimiento sp_menu_por_perfil creado.';
GO
