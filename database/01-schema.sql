/* =====================================================================
   Sistema de Administración de Cadena de Hoteles
   Esquema de base de datos · SQL Server
   Archivo: database/01-schema.sql

   Crea las 14 tablas del modelo de datos (ver docs/02-diseno/01-modelo-de-datos.md)
   con llaves primarias, foráneas, restricciones CHECK/UNIQUE y las
   columnas de auditoría (RNF-11).

   NOTA: el servidor y el nombre de la base de datos se definen al ejecutar.
   Si necesitas crear la base desde cero, descomenta el bloque siguiente.
   ===================================================================== */

-- CREATE DATABASE sistema_hoteles;
-- GO
-- USE sistema_hoteles;
-- GO

/* ---------------------------------------------------------------------
   Convención de auditoría: todas las tablas de negocio incluyen
   creado_por, fecha_creacion, modificado_por, fecha_modificacion.
   Las llaves foráneas de auditoría (-> usuarios) se agregan al final,
   una vez que la tabla usuarios ya existe.
   La tabla bitacora es la excepción: es un registro inmutable.
   --------------------------------------------------------------------- */

/* =========================== SEGURIDAD =============================== */

CREATE TABLE perfiles (
    id                  INT IDENTITY(1,1) NOT NULL,
    nombre              NVARCHAR(100)  NOT NULL,
    descripcion         NVARCHAR(255)  NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_perfiles_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_perfiles PRIMARY KEY (id),
    CONSTRAINT UQ_perfiles_nombre UNIQUE (nombre)
);
GO

CREATE TABLE usuarios (
    id                  INT IDENTITY(1,1) NOT NULL,
    perfil_id           INT            NOT NULL,
    nombre              NVARCHAR(150)  NOT NULL,
    email               NVARCHAR(150)  NOT NULL,
    password_hash       NVARCHAR(255)  NOT NULL,
    activo              BIT            NOT NULL CONSTRAINT DF_usuarios_activo DEFAULT 1,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_usuarios_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_usuarios PRIMARY KEY (id),
    CONSTRAINT UQ_usuarios_email UNIQUE (email),
    CONSTRAINT FK_usuarios_perfil FOREIGN KEY (perfil_id) REFERENCES perfiles(id)
);
GO

CREATE TABLE opciones_menu (
    id                  INT IDENTITY(1,1) NOT NULL,
    padre_id            INT            NULL,
    nombre              NVARCHAR(100)  NOT NULL,
    ruta                NVARCHAR(200)  NULL,
    icono               NVARCHAR(100)  NULL,
    orden               INT            NOT NULL CONSTRAINT DF_opciones_orden DEFAULT 0,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_opciones_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_opciones_menu PRIMARY KEY (id),
    CONSTRAINT FK_opciones_menu_padre FOREIGN KEY (padre_id) REFERENCES opciones_menu(id)
);
GO

CREATE TABLE perfil_opcion (
    id                  INT IDENTITY(1,1) NOT NULL,
    perfil_id           INT            NOT NULL,
    opcion_id           INT            NOT NULL,
    puede_ver           BIT            NOT NULL CONSTRAINT DF_po_ver      DEFAULT 0,
    puede_crear         BIT            NOT NULL CONSTRAINT DF_po_crear    DEFAULT 0,
    puede_editar        BIT            NOT NULL CONSTRAINT DF_po_editar   DEFAULT 0,
    puede_eliminar      BIT            NOT NULL CONSTRAINT DF_po_eliminar DEFAULT 0,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_po_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_perfil_opcion PRIMARY KEY (id),
    CONSTRAINT UQ_perfil_opcion UNIQUE (perfil_id, opcion_id),
    CONSTRAINT FK_perfil_opcion_perfil FOREIGN KEY (perfil_id) REFERENCES perfiles(id),
    CONSTRAINT FK_perfil_opcion_opcion FOREIGN KEY (opcion_id) REFERENCES opciones_menu(id)
);
GO

/* =========================== HOTELERÍA =============================== */

CREATE TABLE hoteles (
    id                  INT IDENTITY(1,1) NOT NULL,
    nombre              NVARCHAR(150)  NOT NULL,
    ciudad              NVARCHAR(100)  NULL,
    direccion           NVARCHAR(255)  NULL,
    telefono            NVARCHAR(30)   NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_hoteles_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_hoteles PRIMARY KEY (id)
);
GO

CREATE TABLE tipos_habitacion (
    id                  INT IDENTITY(1,1) NOT NULL,
    nombre              NVARCHAR(100)  NOT NULL,
    descripcion         NVARCHAR(255)  NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_tipos_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_tipos_habitacion PRIMARY KEY (id),
    CONSTRAINT UQ_tipos_habitacion_nombre UNIQUE (nombre)
);
GO

CREATE TABLE habitaciones (
    id                  INT IDENTITY(1,1) NOT NULL,
    hotel_id            INT            NOT NULL,
    tipo_id             INT            NOT NULL,
    numero              NVARCHAR(20)   NOT NULL,
    tarifa              DECIMAL(12,2)  NOT NULL,
    estado              NVARCHAR(20)   NOT NULL CONSTRAINT DF_habitaciones_estado DEFAULT 'disponible',
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_habitaciones_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_habitaciones PRIMARY KEY (id),
    CONSTRAINT FK_habitaciones_hotel FOREIGN KEY (hotel_id) REFERENCES hoteles(id),
    CONSTRAINT FK_habitaciones_tipo  FOREIGN KEY (tipo_id)  REFERENCES tipos_habitacion(id),
    CONSTRAINT UQ_habitaciones_hotel_numero UNIQUE (hotel_id, numero),
    CONSTRAINT CK_habitaciones_estado CHECK (estado IN ('disponible','ocupada','limpieza','fuera_de_servicio'))
);
GO

CREATE TABLE clientes (
    id                  INT IDENTITY(1,1) NOT NULL,
    documento           NVARCHAR(30)   NOT NULL,
    nombre              NVARCHAR(150)  NOT NULL,
    email               NVARCHAR(150)  NULL,
    telefono            NVARCHAR(30)   NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_clientes_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_clientes PRIMARY KEY (id),
    CONSTRAINT UQ_clientes_documento UNIQUE (documento)
);
GO

CREATE TABLE reservas (
    id                  INT IDENTITY(1,1) NOT NULL,
    habitacion_id       INT            NOT NULL,
    cliente_id          INT            NOT NULL,
    fecha_entrada       DATE           NOT NULL,
    fecha_salida        DATE           NOT NULL,
    estado              NVARCHAR(20)   NOT NULL CONSTRAINT DF_reservas_estado DEFAULT 'pendiente',
    costo_total         DECIMAL(12,2)  NOT NULL CONSTRAINT DF_reservas_costo DEFAULT 0,
    fecha_checkin       DATETIME2      NULL,
    fecha_checkout      DATETIME2      NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_reservas_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_reservas PRIMARY KEY (id),
    CONSTRAINT FK_reservas_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id),
    CONSTRAINT FK_reservas_cliente    FOREIGN KEY (cliente_id)    REFERENCES clientes(id),
    CONSTRAINT CK_reservas_estado CHECK (estado IN ('pendiente','confirmada','en_curso','finalizada','cancelada')),
    CONSTRAINT CK_reservas_fechas CHECK (fecha_salida > fecha_entrada)
);
GO

CREATE TABLE facturas (
    id                       INT IDENTITY(1,1) NOT NULL,
    reserva_id               INT            NOT NULL,
    fecha_emision            DATE           NOT NULL CONSTRAINT DF_facturas_femis DEFAULT CAST(SYSUTCDATETIME() AS DATE),
    subtotal                 DECIMAL(12,2)  NOT NULL CONSTRAINT DF_facturas_subtotal  DEFAULT 0,
    impuestos                DECIMAL(12,2)  NOT NULL CONSTRAINT DF_facturas_impuestos DEFAULT 0,
    total                    DECIMAL(12,2)  NOT NULL CONSTRAINT DF_facturas_total     DEFAULT 0,
    estado                   NVARCHAR(20)   NOT NULL CONSTRAINT DF_facturas_estado DEFAULT 'pendiente',
    justificacion_anulacion  NVARCHAR(255)  NULL,
    creado_por               INT            NULL,
    fecha_creacion           DATETIME2      NOT NULL CONSTRAINT DF_facturas_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por           INT            NULL,
    fecha_modificacion       DATETIME2      NULL,
    CONSTRAINT PK_facturas PRIMARY KEY (id),
    CONSTRAINT FK_facturas_reserva FOREIGN KEY (reserva_id) REFERENCES reservas(id),
    CONSTRAINT UQ_facturas_reserva UNIQUE (reserva_id),  -- relación 1:1 con reservas
    CONSTRAINT CK_facturas_estado CHECK (estado IN ('pendiente','pagada','anulada'))
);
GO

/* ===================== PROVEEDORES E INVENTARIO ===================== */

CREATE TABLE proveedores (
    id                  INT IDENTITY(1,1) NOT NULL,
    nombre              NVARCHAR(150)  NOT NULL,
    contacto            NVARCHAR(150)  NULL,
    telefono            NVARCHAR(30)   NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_proveedores_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_proveedores PRIMARY KEY (id)
);
GO

CREATE TABLE insumos (
    id                  INT IDENTITY(1,1) NOT NULL,
    hotel_id            INT            NOT NULL,
    proveedor_id        INT            NULL,
    nombre              NVARCHAR(150)  NOT NULL,
    stock_actual        INT            NOT NULL CONSTRAINT DF_insumos_stock_actual DEFAULT 0,
    stock_minimo        INT            NOT NULL CONSTRAINT DF_insumos_stock_minimo DEFAULT 0,
    unidad              NVARCHAR(30)   NULL,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_insumos_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_insumos PRIMARY KEY (id),
    CONSTRAINT FK_insumos_hotel     FOREIGN KEY (hotel_id)     REFERENCES hoteles(id),
    CONSTRAINT FK_insumos_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
GO

CREATE TABLE entradas_inventario (
    id                  INT IDENTITY(1,1) NOT NULL,
    insumo_id           INT            NOT NULL,
    proveedor_id        INT            NULL,
    cantidad            INT            NOT NULL,
    fecha               DATE           NOT NULL CONSTRAINT DF_entradas_fecha DEFAULT CAST(SYSUTCDATETIME() AS DATE),
    costo               DECIMAL(12,2)  NOT NULL CONSTRAINT DF_entradas_costo DEFAULT 0,
    creado_por          INT            NULL,
    fecha_creacion      DATETIME2      NOT NULL CONSTRAINT DF_entradas_fcrea DEFAULT SYSUTCDATETIME(),
    modificado_por      INT            NULL,
    fecha_modificacion  DATETIME2      NULL,
    CONSTRAINT PK_entradas_inventario PRIMARY KEY (id),
    CONSTRAINT FK_entradas_insumo    FOREIGN KEY (insumo_id)    REFERENCES insumos(id),
    CONSTRAINT FK_entradas_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    CONSTRAINT CK_entradas_cantidad CHECK (cantidad > 0)
);
GO

/* ============================ AUDITORÍA ============================= */

CREATE TABLE bitacora (
    id                  BIGINT IDENTITY(1,1) NOT NULL,
    usuario_id          INT            NULL,
    fecha_hora          DATETIME2      NOT NULL CONSTRAINT DF_bitacora_fhora DEFAULT SYSUTCDATETIME(),
    accion              NVARCHAR(50)   NOT NULL,
    entidad             NVARCHAR(50)   NULL,
    registro_id         INT            NULL,
    descripcion         NVARCHAR(500)  NULL,
    ip                  NVARCHAR(45)   NULL,
    CONSTRAINT PK_bitacora PRIMARY KEY (id),
    CONSTRAINT FK_bitacora_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
GO

/* =====================================================================
   Llaves foráneas de auditoría (creado_por / modificado_por -> usuarios)
   Se agregan al final porque dependen de la tabla usuarios.
   Usan NO ACTION (por defecto) para evitar ciclos de cascada.
   ===================================================================== */

ALTER TABLE perfiles            ADD CONSTRAINT FK_perfiles_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE perfiles            ADD CONSTRAINT FK_perfiles_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE usuarios            ADD CONSTRAINT FK_usuarios_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE usuarios            ADD CONSTRAINT FK_usuarios_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE opciones_menu       ADD CONSTRAINT FK_opciones_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE opciones_menu       ADD CONSTRAINT FK_opciones_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE perfil_opcion       ADD CONSTRAINT FK_po_creadopor            FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE perfil_opcion       ADD CONSTRAINT FK_po_modpor               FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE hoteles             ADD CONSTRAINT FK_hoteles_creadopor       FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE hoteles             ADD CONSTRAINT FK_hoteles_modpor          FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE tipos_habitacion    ADD CONSTRAINT FK_tipos_creadopor         FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE tipos_habitacion    ADD CONSTRAINT FK_tipos_modpor            FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE habitaciones        ADD CONSTRAINT FK_habitaciones_creadopor  FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE habitaciones        ADD CONSTRAINT FK_habitaciones_modpor     FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE clientes            ADD CONSTRAINT FK_clientes_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE clientes            ADD CONSTRAINT FK_clientes_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE reservas            ADD CONSTRAINT FK_reservas_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE reservas            ADD CONSTRAINT FK_reservas_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE facturas            ADD CONSTRAINT FK_facturas_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE facturas            ADD CONSTRAINT FK_facturas_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE proveedores         ADD CONSTRAINT FK_proveedores_creadopor   FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE proveedores         ADD CONSTRAINT FK_proveedores_modpor      FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE insumos             ADD CONSTRAINT FK_insumos_creadopor       FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE insumos             ADD CONSTRAINT FK_insumos_modpor          FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
ALTER TABLE entradas_inventario ADD CONSTRAINT FK_entradas_creadopor      FOREIGN KEY (creado_por)     REFERENCES usuarios(id);
ALTER TABLE entradas_inventario ADD CONSTRAINT FK_entradas_modpor         FOREIGN KEY (modificado_por) REFERENCES usuarios(id);
GO
