# Base de datos · SQL Server

La base de datos se versiona como scripts `.sql` (no usamos migraciones automáticas).

## Contenido

- `01-schema.sql` — Crea las 14 tablas con sus llaves primarias, foráneas, restricciones `CHECK`/`UNIQUE` y columnas de auditoría.
- `procedures/` — Un archivo `.sql` por procedimiento almacenado (se irán agregando por sprint).

## Orden de ejecución

1. Crear la base de datos (o usar una existente).
2. Ejecutar `01-schema.sql`.
3. Ejecutar los scripts de `procedures/`.

## Codificación (tildes y ñ)

- Los textos con acentos o ñ deben escribirse como literales Unicode: `N'Facturación'` (prefijo `N`).
- Al ejecutar scripts con acentos vía `sqlcmd`, indica UTF-8 con `-f 65001`:
  ```
  sqlcmd -S .\SQLEXPRESS -E -f 65001 -i database\02-seed.sql
  ```
  Sin esto, `sqlcmd` puede leer mal el archivo y guardar "ó" como "Ã³".

## Notas

- El script usa `IDENTITY(1,1)` para los `id` autoincrementales.
- Las llaves foráneas de auditoría (`creado_por` / `modificado_por` → `usuarios`) se agregan al final del `01-schema.sql`, porque dependen de la tabla `usuarios`.
- Las columnas de fecha usan `SYSUTCDATETIME()` (hora UTC) por defecto.
- El servidor y el nombre de la base de datos se definen al momento de ejecutar.
