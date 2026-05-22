# Sistema de Administración de Cadena de Hoteles

Proyecto académico/de aprendizaje para construir un sistema que administra una **cadena de hoteles**, siguiendo el **Ciclo de Vida del Software (SDLC)** y gestionado con **Scrum** sobre **GitHub**.

## ¿Qué hace el sistema?

Permite administrar varios hoteles de una misma cadena desde un solo lugar. Módulos principales:

- **Habitaciones** — tipos, tarifas, estado y disponibilidad por hotel.
- **Reservas** — crear, modificar y cancelar reservas.
- **Check-in / Check-out** — registro de entrada y salida de huéspedes.
- **Clientes** — datos y historial de huéspedes.
- **Proveedores** — empresas que abastecen insumos a los hoteles.
- **Inventario** — control de insumos y amenidades.
- **Facturación** — generación de facturas y cobros.
- **Reportes** — ocupación, ingresos y otros indicadores.

## ¿Cómo está organizado el proyecto?

Seguimos el ciclo de vida del software. Cada fase tiene su carpeta de documentación:

```
sistema-hoteles/
├── docs/
│   ├── 00-gestion-proyecto/   → Scrum: roles, sprints, backlog
│   ├── 01-analisis/           → requisitos e historias de usuario
│   ├── 02-diseno/             → diagramas, arquitectura, mockups
│   ├── 03-implementacion/     → notas técnicas del código
│   ├── 04-pruebas/            → plan y casos de prueba
│   └── 05-despliegue/         → manual de instalación y uso
├── src/                       → código fuente (se crea más adelante)
└── README.md
```

## Tecnología prevista

- **Next.js** + **TypeScript** (frontend y backend)
- **Tailwind CSS** (estilos)
- Base de datos (se define en la fase de diseño)

## Estado actual

| Fase | Estado |
|------|--------|
| 1. Análisis | Completa |
| 2. Diseño | Completa |
| 3. Implementación | Pendiente |
| 4. Pruebas | Pendiente |
| 5. Despliegue | Pendiente |
