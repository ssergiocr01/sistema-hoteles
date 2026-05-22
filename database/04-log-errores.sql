/* =====================================================================
   Tabla de log de errores del sistema
   Archivo: database/04-log-errores.sql

   Guarda los errores técnicos (excepciones) para diagnóstico.
   Es distinta de la bitácora (que registra acciones del usuario).

   Ejecutar: sqlcmd -S .\SQLEXPRESS -E -i database\04-log-errores.sql
   ===================================================================== */

USE sistema_hoteles;
GO

IF OBJECT_ID('log_errores', 'U') IS NULL
CREATE TABLE log_errores (
    id          BIGINT IDENTITY(1,1) NOT NULL,
    fecha_hora  DATETIME2      NOT NULL CONSTRAINT DF_log_errores_fhora DEFAULT SYSUTCDATETIME(),
    mensaje     NVARCHAR(1000) NOT NULL,
    detalle     NVARCHAR(MAX)  NULL,   -- stack trace u otros detalles
    ruta        NVARCHAR(300)  NULL,   -- URL donde ocurrió
    metodo      NVARCHAR(10)   NULL,   -- GET, POST, etc.
    origen      NVARCHAR(50)   NULL,   -- servidor, accion, etc.
    usuario_id  INT            NULL,   -- usuario en sesión (si se conoce)
    CONSTRAINT PK_log_errores PRIMARY KEY (id),
    CONSTRAINT FK_log_errores_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
GO

PRINT 'Tabla log_errores lista.';
GO
