/* =====================================================================
   Procedimiento almacenado: sp_login
   Busca un usuario por su email y devuelve sus datos (incluido el
   password_hash y su perfil). NO compara la contraseña: de eso se
   encarga la aplicación con bcrypt.

   Usado por: HU-01 (login) · Sprint 1

   Nota: SQL Server 2008 no soporta CREATE OR ALTER, por eso se usa
   el patrón "DROP si existe + CREATE".
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('sp_login', 'P') IS NOT NULL
    DROP PROCEDURE sp_login;
GO

CREATE PROCEDURE sp_login
    @email NVARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        u.id,
        u.nombre,
        u.email,
        u.password_hash,
        u.activo,
        u.perfil_id,
        p.nombre AS perfil
    FROM usuarios u
    INNER JOIN perfiles p ON p.id = u.perfil_id
    WHERE u.email = @email;
END
GO

PRINT 'Procedimiento sp_login creado.';
GO
