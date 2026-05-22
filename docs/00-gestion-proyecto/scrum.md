# Gestión del Proyecto · Scrum

> Este documento explica cómo organizamos el trabajo con **Scrum**. Es transversal a todas las fases del ciclo de vida:
> en cada sprint hacemos un poco de análisis, diseño, código y pruebas.

---

## 1. Roles del equipo

| Rol | Responsabilidad | En este proyecto |
|-----|-----------------|------------------|
| **Product Owner (PO)** | Define y prioriza el Product Backlog. Decide QUÉ se construye. | Tú (representas al cliente). |
| **Scrum Master (SM)** | Facilita el proceso, elimina obstáculos. | Tú (o el profesor). |
| **Equipo de desarrollo** | Construye el producto. | Tú (+ Claude como asistente). |

> En un proyecto de aprendizaje es normal que una sola persona asuma varios roles.

## 2. Sprints planificados

Cada **sprint** dura 2 semanas (ajústalo a tu necesidad). Agrupamos las historias así:

| Sprint | Objetivo (meta del sprint) | Historias |
|--------|----------------------------|-----------|
| **Sprint 1** | Base del sistema: login, hoteles y habitaciones. | HU-01, HU-02, HU-03, HU-04 |
| **Sprint 2** | Reservas y clientes funcionando. | HU-05, HU-06, HU-07, HU-08 |
| **Sprint 3** | Check-in/out y facturación. | HU-09, HU-10, HU-11, HU-12 |
| **Sprint 4** | Proveedores e inventario. | HU-13, HU-14, HU-15, HU-16, HU-17 |
| **Sprint 5** | Reportes y consolidado. | HU-18, HU-19, HU-20 |

> En GitHub, **cada sprint será un Milestone**.

## 3. Ceremonias (reuniones de Scrum)

| Ceremonia | Cuándo | Para qué |
|-----------|--------|----------|
| **Sprint Planning** | Al inicio del sprint | Elegir qué historias se harán. |
| **Daily Scrum** | Cada día (15 min) | ¿Qué hice? ¿Qué haré? ¿Qué me bloquea? |
| **Sprint Review** | Al final del sprint | Mostrar lo construido. |
| **Sprint Retrospective** | Al final del sprint | ¿Qué mejoramos para el próximo sprint? |

## 4. Tablero (Kanban) en GitHub Projects

Usaremos un tablero con estas columnas:

```
┌─────────────┬───────────────┬──────────────┬──────────┐
│  Por hacer  │  En progreso  │  En revisión │  Hecho   │
│  (Backlog)  │   (Doing)     │   (Review)   │  (Done)  │
└─────────────┴───────────────┴──────────────┴──────────┘
```

Cada **issue** (historia de usuario) se mueve de izquierda a derecha según avanza.

## 5. Definición de "Hecho" (Definition of Done)

Una historia se considera **terminada** cuando:

- [ ] El código cumple todos los criterios de aceptación.
- [ ] Funciona y fue probado manualmente.
- [ ] No rompe funcionalidades anteriores.
- [ ] El cambio está subido a GitHub (commit + push).
- [ ] El issue está cerrado.
