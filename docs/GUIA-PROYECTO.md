# Guía de Proyecto — De cero a un sistema con Next.js + SQL Server

> Esta guía resume **todo lo que hicimos** para construir el Sistema de Administración de Cadena de Hoteles, pensada como **plantilla para proyectos futuros**. Sirve tanto para recordar el "cómo" como el "por qué" de cada decisión.

---

## 1. Metodología

Seguimos el **Ciclo de Vida del Software (SDLC)** recorriendo sus fases, gestionando el trabajo con **Scrum** sobre **GitHub**.

### Fases del ciclo de vida
| Fase | Pregunta | Qué se produjo |
|------|----------|----------------|
| 1. Análisis | ¿QUÉ se necesita? | Requisitos funcionales (RF) y no funcionales (RNF), historias de usuario |
| 2. Diseño | ¿CÓMO se construye? | Modelo de datos, arquitectura, casos de uso, mockups |
| 3. Implementación | Construir | Código + base de datos |
| 4. Pruebas | ¿Funciona? | Verificación de cada funcionalidad |
| 5. Despliegue | Ponerlo en producción | (pendiente) |
| 6. Mantenimiento | Corregir y mejorar | (continuo) |

### Scrum (lo esencial)
- **Product Backlog**: lista priorizada de historias de usuario (HU).
- **Sprint**: ciclo corto (2 semanas) que entrega algo funcional.
- **Roles**: Product Owner (qué se hace), Scrum Master (facilita), Equipo (construye).
- **MoSCoW** para priorizar: Must / Should / Could.

### GitHub como herramienta de Scrum
- **Issues** = historias de usuario.
- **Milestones** = Sprints.
- **Labels** = prioridad (`must`/`should`/`could`) y módulo.
- **Projects (tablero)** = Kanban (Por hacer → En progreso → Hecho).

---

## 2. Documentación por fase

Cada fase deja su rastro en `docs/`:

```
docs/
├── 00-gestion-proyecto/   → scrum.md (roles, sprints, ceremonias)
├── 01-analisis/           → visión, requisitos (RF/RNF), historias de usuario
├── 02-diseno/             → modelo de datos, arquitectura, casos de uso, mockups
├── 03-implementacion/     → notas técnicas
├── 04-pruebas/            → plan y casos de prueba
└── 05-despliegue/         → manual (pendiente)
```

**Regla de oro de trazabilidad:** cada requisito tiene un código (RF-XX, RNF-XX) que se referencia en el diseño, en los issues y en el código. Así siempre se sabe "de dónde viene" cada funcionalidad.

---

## 3. Stack tecnológico y arquitectura

### Stack
- **Next.js (App Router) + TypeScript** — frontend y backend en un solo proyecto.
- **Tailwind CSS** — estilos.
- **SQL Server** — base de datos relacional.
- **Procedimientos almacenados + node-mssql** — acceso a datos (en vez de un ORM).
- **Auth.js (NextAuth v5)** — autenticación y sesión.
- **bcryptjs** — hashing de contraseñas.

### Arquitectura en capas
```
Presentación (páginas/componentes)
   ↓
Lógica de negocio (Server Actions / API)
   ↓
Acceso a datos (node-mssql → procedimientos almacenados)
   ↓
Base de datos (SQL Server)
```
**Regla de oro:** la presentación nunca toca la BD directamente; pasa por las capas.

### Decisiones clave (y por qué)
- **SQL Server en vez de PostgreSQL**: se alinea con el entorno existente.
- **Procedimientos almacenados en vez de ORM (Prisma)**: la lógica de datos vive en la BD; encaja con equipos SQL Server. El esquema y los SPs se versionan como scripts `.sql` en `database/`.
- **Sin carpeta `src`**: preferencia del proyecto (`--no-src-dir`).
- **Sesión JWT (Auth.js)**: simple, sin tabla de sesiones.

---

## 4. Montaje paso a paso (replicable)

### A. Base de datos (SQL Server)
1. Crear la base y el esquema: `database/01-schema.sql` (tablas, PK, FK, CHECK, columnas de auditoría).
2. Crear un **login de aplicación** con permisos mínimos (lectura, escritura, EXECUTE de SPs).
3. Cargar datos semilla: `database/02-seed.sql` (perfiles, menú, usuario admin).
4. Crear los procedimientos almacenados en `database/procedures/`.

```powershell
sqlcmd -S .\SQLEXPRESS -E -f 65001 -i database\01-schema.sql
sqlcmd -S .\SQLEXPRESS -E -f 65001 -i database\02-seed.sql
```

### B. Proyecto Next.js
```powershell
npx create-next-app@latest . --ts --tailwind --eslint --app --no-src-dir --import-alias "@/*" --use-npm
```
> Si la carpeta ya tiene archivos (README, etc.), aparta los que estorban; `create-next-app` solo tolera algunos (`docs`, `.git`, `.gitignore`).

### C. Conexión a la base de datos
- Instalar: `npm install mssql` (+ `@types/mssql`).
- `lib/db.ts`: **pool de conexiones** reutilizable (un solo pool para toda la app).
- Credenciales en `.env.local` (NO se sube a git) + plantilla `.env.example`.

### D. Autenticación (Auth.js + procedimiento + bcrypt)
1. `npm install next-auth@beta bcryptjs`.
2. Generar `AUTH_SECRET` y ponerlo en `.env.local`.
3. `sp_login`: busca el usuario por email y devuelve sus datos + hash (NO compara la contraseña).
4. `auth.ts`: Credentials provider → llama a `sp_login`, compara con bcrypt, devuelve el usuario.
5. `auth.config.ts`: configuración base (edge-safe) para el middleware.
6. `app/api/auth/[...nextauth]/route.ts`: el endpoint de Auth.js.
7. Pantalla de login (`app/login`) con Server Action que llama a `signIn`.
8. `middleware.ts`: protege rutas (sin sesión → al login).

### E. Layout y menú dinámico (RBAC)
- `sp_menu_por_perfil`: devuelve las opciones que el perfil puede ver.
- `services/menu.ts`: arma el árbol (padres/hijos).
- `Sidebar` + `NavLinks` (submenús colapsables) dentro de un *route group* `app/(app)/`.

### F. Manejo de errores y seguridad
- Páginas: `not-found.tsx` (404), `error.tsx` (boundary), `global-error.tsx`.
- **Refuerzo RBAC en servidor**: `sp_perfil_puede_ver` + `services/permisos.ts` (`puedeVer`) + componente `NoAutorizado`. Cada página protegida valida el permiso, no basta con ocultar el menú.

### G. Log de errores
- Tabla `log_errores` + `sp_log_error` + `sp_log_errores_listar`.
- `instrumentation.ts` (`onRequestError`): captura automática de errores del servidor.
- `services/log.ts`: `registrarError` (con respaldo a consola) y `listarErrores`.
- Página de admin para verlos.

---

## 5. Convenciones

### Base de datos
- **Procedimientos almacenados** para toda la lógica de datos. Patrón en SQL Server 2008: `IF OBJECT_ID('sp_x','P') IS NOT NULL DROP PROCEDURE sp_x; GO CREATE PROCEDURE ...`.
- **Columnas de auditoría** en todas las tablas de negocio: `creado_por`, `fecha_creacion`, `modificado_por`, `fecha_modificacion`.
- **Bitácora** (acciones de usuario) ≠ **log de errores** (fallos técnicos).
- **Literales Unicode**: siempre `N'texto'` para columnas `NVARCHAR` (tildes y ñ).
- Nombres de restricciones explícitos: `PK_`, `FK_`, `UQ_`, `CK_`, `DF_`.

### Seguridad
- Contraseñas **siempre con hash** (bcrypt), nunca en texto plano.
- **RBAC en el servidor**: ocultar el menú NO es proteger; validar el permiso en el backend.
- Cookies de sesión **httpOnly**.
- Secretos en `.env.local` (ignorado por git); plantilla pública en `.env.example`.

### Código (Next.js)
- **Server Components** por defecto (pueden leer BD/sesión).
- **Client Components** (`"use client"`) solo cuando hay interactividad (estado, eventos).
- **Server Actions** (`"use server"`) para procesar formularios.
- Acceso a datos en `services/` (una función por operación, que llama a un SP).

---

## 6. Errores comunes y cómo se resolvieron (¡muy importante!)

Estos son tropiezos reales que tuvimos. Tenerlos presentes ahorra horas.

| Problema | Causa | Solución |
|----------|-------|----------|
| Login fallaba ("login del usuario") | Next.js **expande `$`** en los `.env` | Escapar: `DB_PASSWORD=Clave\$abc` |
| Tildes/ñ se veían como "Ã³" | `sqlcmd` leyó el `.sql` con codificación equivocada + faltó `N'...'` | Usar `sqlcmd -f 65001` y literales `N'texto'` |
| `parameter.type.validate is not a function` | Tipo de parámetro de `mssql` duplicado por el recompilado en caliente | Dejar que `mssql` **infiera** el tipo (no pasar `sql.NVarChar(...)`) |
| `ALTER ROLE ... ADD MEMBER` falla | SQL Server **2008** no lo soporta | Usar `sp_addrolemember` |
| `CREATE OR ALTER PROCEDURE` falla | No existe en 2008 | `IF OBJECT_ID(...) DROP` + `CREATE` |
| `create-next-app` se niega a instalar | Carpeta con archivos que "chocan" (ej. `README.md`) | Apartar esos archivos y restaurarlos después |
| Error de tipos `app/page.js` | Caché `.next` desactualizada tras borrar/mover páginas | Borrar `.next` y reconstruir |
| node-mssql no conecta | TCP/IP de SQL Express deshabilitado o sin puerto | Habilitar TCP/IP (puerto 1433) + SQL Browser |

---

## 7. Checklist para un proyecto nuevo

1. [ ] **Análisis**: requisitos (RF/RNF) e historias de usuario priorizadas.
2. [ ] **Diseño**: modelo de datos (ER), arquitectura, casos de uso, mockups.
3. [ ] **GitHub**: repo, labels, milestones (sprints), issues, tablero.
4. [ ] **BD**: esquema + login de app + datos semilla + procedimientos.
5. [ ] **Proyecto**: `create-next-app` (TS + Tailwind).
6. [ ] **Conexión**: pool de BD + `.env.local` / `.env.example`.
7. [ ] **Autenticación**: SP de login + Auth.js + login + middleware.
8. [ ] **Layout + menú dinámico** (si hay roles): RBAC.
9. [ ] **Manejo de errores**: 404, error boundary, refuerzo RBAC (403).
10. [ ] **Log de errores**: tabla + captura automática + visor.
11. [ ] **Por cada módulo**: SPs → servicio → página → prueba → cerrar issue.

---

## 8. Estructura del repositorio

```
proyecto/
├── app/
│   ├── (app)/             → área privada (con menú): layout, páginas, error.tsx
│   ├── login/             → pantalla de login
│   ├── api/auth/          → endpoint de Auth.js
│   ├── not-found.tsx      → 404
│   └── global-error.tsx   → error catastrófico
├── components/            → Sidebar, NavLinks, NoAutorizado, etc.
├── services/             → acceso a datos (menu, permisos, log…)
├── lib/db.ts              → pool de conexión a SQL Server
├── auth.ts / auth.config.ts → configuración de Auth.js
├── middleware.ts          → protección de rutas
├── instrumentation.ts     → captura de errores del servidor
├── database/
│   ├── 01-schema.sql      → tablas
│   ├── 02-seed.sql        → datos iniciales
│   ├── 04-log-errores.sql → tabla de log
│   └── procedures/        → un .sql por procedimiento
├── docs/                  → documentación por fase
├── .env.local             → secretos (NO se sube)
└── .env.example           → plantilla de variables
```

---

## 9. Comandos útiles

```powershell
# Base de datos (con codificación UTF-8 para tildes)
sqlcmd -S .\SQLEXPRESS -E -f 65001 -i database\01-schema.sql

# Desarrollo
npm run dev            # servidor en http://localhost:3000
npm run build          # build de producción (valida tipos)
npx tsc --noEmit       # solo chequeo de tipos

# Git
git add -A
git commit -m "mensaje"
git push origin main
```

---

## 10. Flujo de trabajo por funcionalidad (resumen)

Para cada historia de usuario:
1. Escribir el/los **procedimientos almacenados** y probarlos con `sqlcmd`.
2. Crear la **función de servicio** (`services/`) que llama al SP.
3. Construir la **página/componente** (Server o Client según corresponda).
4. **Reforzar permisos** (RBAC) si la sección lo requiere.
5. **Probar** el flujo completo.
6. **Commit + push** y **cerrar el issue** en GitHub.
