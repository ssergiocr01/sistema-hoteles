# Fase 1 — Análisis · Visión General del Proyecto

> **¿Qué es esta fase?** El análisis responde a la pregunta **"¿QUÉ necesitamos construir?"**.
> Todavía NO hablamos de cómo se programa ni con qué tecnología. Solo entendemos el problema y lo que el sistema debe hacer.

---

## 1. Descripción del problema

La cadena de hoteles **"Cadena Hotelera Andina"** (nombre de ejemplo) tiene varios hoteles en distintas ciudades. Hoy administra cada hotel por separado, con hojas de cálculo y registros en papel. Esto causa:

- Reservas duplicadas o perdidas.
- No saber en tiempo real qué habitaciones están disponibles.
- Dificultad para controlar el inventario de insumos y los proveedores.
- Facturación manual y propensa a errores.
- Imposibilidad de ver reportes consolidados de toda la cadena.

## 2. Objetivo del sistema

Construir un sistema web centralizado que permita administrar **todos los hoteles de la cadena** desde una sola plataforma, automatizando reservas, check-in/check-out, inventario, proveedores, facturación y reportes.

## 3. Alcance (qué SÍ incluye)

- Gestión de varios hoteles bajo una misma cadena.
- Gestión de habitaciones, tipos y tarifas por hotel.
- Reservas y disponibilidad en tiempo real.
- Check-in y check-out de huéspedes.
- Registro de clientes y su historial.
- Gestión de proveedores e inventario de insumos.
- Facturación de estadías y servicios.
- Reportes de ocupación e ingresos.

## 4. Fuera de alcance (qué NO incluye, por ahora)

- Pasarela de pagos en línea real (tarjetas de crédito).
- Aplicación móvil nativa.
- Integración con portales externos (Booking, Expedia, etc.).
- Nómina o recursos humanos del personal.

> Definir lo que NO se hará es tan importante como definir lo que sí. Evita que el proyecto crezca sin control.

## 5. Actores del sistema (¿quién lo usa?)

| Actor | Descripción |
|-------|-------------|
| **Administrador de la cadena** | Ve todos los hoteles, gestiona usuarios y consulta reportes globales. |
| **Recepcionista** | Gestiona reservas, check-in/check-out y clientes de su hotel. |
| **Encargado de inventario** | Administra insumos, proveedores y pedidos. |
| **Cajero / Facturación** | Genera facturas y registra cobros. |

> Estos actores se convertirán más adelante en **roles de usuario** dentro del sistema.

## 6. Glosario de términos

- **Cadena**: conjunto de hoteles administrados por la misma empresa.
- **Disponibilidad**: habitaciones libres en un rango de fechas.
- **Tarifa**: precio de una habitación según su tipo y temporada.
- **Check-in**: registro de entrada del huésped.
- **Check-out**: registro de salida y cierre de la cuenta.
- **Insumo**: producto consumible del hotel (toallas, jabones, alimentos, etc.).
