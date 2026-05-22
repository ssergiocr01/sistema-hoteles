# Fase 1 — Análisis · Requisitos Funcionales

> **¿Qué es un requisito funcional?** Es algo que el sistema **debe hacer**: una función o comportamiento concreto.
> Se escriben con la forma *"El sistema debe..."*. Cada uno tiene un código (RF-XX) para poder rastrearlo en las demás fases.

---

## Módulo: Habitaciones

| Código | Requisito |
|--------|-----------|
| RF-01 | El sistema debe permitir registrar hoteles de la cadena (nombre, ciudad, dirección). |
| RF-02 | El sistema debe permitir registrar habitaciones asociadas a un hotel. |
| RF-03 | El sistema debe permitir definir tipos de habitación (sencilla, doble, suite) con su tarifa. |
| RF-04 | El sistema debe mostrar el estado de cada habitación (disponible, ocupada, en limpieza, fuera de servicio). |
| RF-05 | El sistema debe consultar la disponibilidad de habitaciones por hotel y rango de fechas. |

## Módulo: Reservas

| Código | Requisito |
|--------|-----------|
| RF-06 | El sistema debe permitir crear una reserva indicando hotel, habitación, cliente y fechas. |
| RF-07 | El sistema debe validar que la habitación esté disponible antes de confirmar la reserva. |
| RF-08 | El sistema debe permitir modificar una reserva existente. |
| RF-09 | El sistema debe permitir cancelar una reserva. |
| RF-10 | El sistema debe calcular el costo total de la reserva según tarifa y número de noches. |

## Módulo: Check-in / Check-out

| Código | Requisito |
|--------|-----------|
| RF-11 | El sistema debe registrar el check-in de un huésped a partir de una reserva. |
| RF-12 | El sistema debe cambiar el estado de la habitación a "ocupada" tras el check-in. |
| RF-13 | El sistema debe registrar el check-out y liberar la habitación. |
| RF-14 | El sistema debe generar el resumen de la estadía al hacer check-out. |

## Módulo: Clientes

| Código | Requisito |
|--------|-----------|
| RF-15 | El sistema debe permitir registrar clientes (documento, nombre, contacto). |
| RF-16 | El sistema debe permitir consultar el historial de estadías de un cliente. |
| RF-17 | El sistema debe permitir editar los datos de un cliente. |

## Módulo: Proveedores

| Código | Requisito |
|--------|-----------|
| RF-18 | El sistema debe permitir registrar proveedores (nombre, contacto, productos que ofrece). |
| RF-19 | El sistema debe permitir asociar insumos a un proveedor. |
| RF-20 | El sistema debe permitir consultar el listado de proveedores. |

## Módulo: Inventario

| Código | Requisito |
|--------|-----------|
| RF-21 | El sistema debe permitir registrar insumos con su stock actual por hotel. |
| RF-22 | El sistema debe descontar stock cuando se consume un insumo. |
| RF-23 | El sistema debe alertar cuando un insumo esté por debajo del stock mínimo. |
| RF-24 | El sistema debe registrar entradas de inventario (compras a proveedores). |

## Módulo: Facturación

| Código | Requisito |
|--------|-----------|
| RF-25 | El sistema debe generar una factura al hacer check-out. |
| RF-26 | El sistema debe incluir en la factura la estadía y los servicios consumidos. |
| RF-27 | El sistema debe permitir registrar el pago de una factura. |
| RF-28 | El sistema debe permitir anular una factura con su justificación. |

## Módulo: Reportes

| Código | Requisito |
|--------|-----------|
| RF-29 | El sistema debe generar un reporte de ocupación por hotel y periodo. |
| RF-30 | El sistema debe generar un reporte de ingresos por hotel y periodo. |
| RF-31 | El sistema debe generar un reporte consolidado de toda la cadena. |

## Módulo: Seguridad / Usuarios

| Código | Requisito |
|--------|-----------|
| RF-32 | El sistema debe permitir el inicio de sesión con usuario y contraseña. |
| RF-33 | El sistema debe restringir las funciones según el rol del usuario. |
