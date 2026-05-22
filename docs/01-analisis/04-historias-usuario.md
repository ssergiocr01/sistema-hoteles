# Fase 1 — Análisis · Historias de Usuario (Product Backlog)

> **¿Qué es una historia de usuario?** Es un requisito escrito en lenguaje natural, desde el punto de vista de quien lo usa.
> Formato: **"Como** [rol], **quiero** [acción] **para** [beneficio]."
>
> En Scrum, la lista de todas las historias priorizadas se llama **Product Backlog**. Cada historia se convertirá en un **issue** de GitHub.

---

## ¿Cómo se prioriza? (MoSCoW)

- **Must** (debe): imprescindible para que el sistema funcione.
- **Should** (debería): importante, pero no bloquea el lanzamiento.
- **Could** (podría): deseable, si hay tiempo.

## ¿Qué son los "puntos de historia"?

Es una estimación del **esfuerzo** (no horas exactas), usando una escala simple: 1 = muy fácil, 2, 3, 5, 8 = muy complejo.

---

## Product Backlog

| ID | Historia de usuario | Prioridad | Puntos | RF asociado | Sprint sugerido |
|----|---------------------|-----------|--------|-------------|-----------------|
| HU-01 | Como administrador, quiero iniciar sesión con mi usuario y contraseña para acceder de forma segura. | Must | 3 | RF-32, RF-33 | 1 |
| HU-02 | Como administrador, quiero registrar los hoteles de la cadena para administrarlos en el sistema. | Must | 3 | RF-01 | 1 |
| HU-03 | Como recepcionista, quiero registrar habitaciones y sus tipos para gestionarlas. | Must | 5 | RF-02, RF-03 | 1 |
| HU-04 | Como recepcionista, quiero ver el estado de cada habitación para saber cuáles están libres. | Must | 3 | RF-04 | 1 |
| HU-05 | Como recepcionista, quiero consultar disponibilidad por fechas para ofrecer habitaciones al cliente. | Must | 5 | RF-05 | 2 |
| HU-06 | Como recepcionista, quiero registrar clientes para asociarlos a las reservas. | Must | 3 | RF-15, RF-17 | 2 |
| HU-07 | Como recepcionista, quiero crear una reserva para apartar una habitación a un cliente. | Must | 8 | RF-06, RF-07, RF-10 | 2 |
| HU-08 | Como recepcionista, quiero modificar o cancelar una reserva para atender cambios del cliente. | Should | 5 | RF-08, RF-09 | 2 |
| HU-09 | Como recepcionista, quiero registrar el check-in de un huésped para darle ingreso. | Must | 5 | RF-11, RF-12 | 3 |
| HU-10 | Como recepcionista, quiero registrar el check-out para cerrar la estadía y liberar la habitación. | Must | 5 | RF-13, RF-14 | 3 |
| HU-11 | Como cajero, quiero generar una factura al check-out para cobrar la estadía. | Must | 8 | RF-25, RF-26 | 3 |
| HU-12 | Como cajero, quiero registrar el pago de una factura para dejar la cuenta saldada. | Should | 3 | RF-27 | 3 |
| HU-13 | Como cajero, quiero anular una factura con justificación para corregir errores. | Could | 3 | RF-28 | 4 |
| HU-14 | Como encargado de inventario, quiero registrar proveedores para gestionar las compras. | Should | 3 | RF-18, RF-20 | 4 |
| HU-15 | Como encargado de inventario, quiero registrar insumos y su stock para controlar existencias. | Should | 5 | RF-21, RF-19 | 4 |
| HU-16 | Como encargado de inventario, quiero recibir alertas de stock bajo para reabastecer a tiempo. | Could | 5 | RF-23 | 4 |
| HU-17 | Como encargado de inventario, quiero registrar entradas de compra para actualizar el stock. | Could | 3 | RF-24 | 4 |
| HU-18 | Como administrador, quiero ver un reporte de ocupación para conocer el uso de los hoteles. | Should | 5 | RF-29 | 5 |
| HU-19 | Como administrador, quiero ver un reporte de ingresos para evaluar el rendimiento. | Should | 5 | RF-30 | 5 |
| HU-20 | Como administrador, quiero un reporte consolidado de la cadena para una visión global. | Could | 8 | RF-31 | 5 |

---

## Criterios de aceptación (ejemplo)

Cada historia debe tener **criterios de aceptación**: las condiciones que prueban que está "terminada". Ejemplo para **HU-07**:

> **HU-07 — Crear reserva**
> - [ ] Se puede seleccionar hotel, habitación, cliente y fechas de entrada/salida.
> - [ ] El sistema rechaza la reserva si la habitación ya está ocupada en esas fechas.
> - [ ] El sistema calcula y muestra el costo total (tarifa × noches).
> - [ ] Al confirmar, la reserva queda guardada y visible en el listado.

> En la fase de diseño y al crear los issues, escribiremos los criterios de aceptación de cada historia.
