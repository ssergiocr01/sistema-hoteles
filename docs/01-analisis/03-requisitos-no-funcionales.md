# Fase 1 — Análisis · Requisitos No Funcionales

> **¿Qué es un requisito no funcional?** No describe QUÉ hace el sistema, sino **CÓMO debe comportarse**: su calidad.
> Hablan de rapidez, seguridad, facilidad de uso, etc. También se codifican (RNF-XX) para rastrearlos.

---

| Código | Categoría | Requisito |
|--------|-----------|-----------|
| RNF-01 | Rendimiento | Las consultas de disponibilidad deben responder en menos de 3 segundos. |
| RNF-02 | Usabilidad | La interfaz debe ser intuitiva; un recepcionista debe poder crear una reserva sin capacitación extensa. |
| RNF-03 | Seguridad | Las contraseñas deben almacenarse cifradas, nunca en texto plano. |
| RNF-04 | Seguridad | El acceso a cada módulo debe depender del rol del usuario. |
| RNF-05 | Disponibilidad | El sistema debe estar disponible al menos el 99% del tiempo en horario laboral. |
| RNF-06 | Compatibilidad | Debe funcionar en los navegadores modernos (Chrome, Edge, Firefox). |
| RNF-07 | Mantenibilidad | El código debe estar organizado por módulos y documentado. |
| RNF-08 | Escalabilidad | Debe soportar la incorporación de nuevos hoteles sin rediseñar el sistema. |
| RNF-09 | Idioma | La interfaz debe estar en español. |
| RNF-10 | Respaldo | Los datos deben respaldarse periódicamente para evitar pérdidas. |
| RNF-11 | Auditabilidad | El sistema debe registrar en una bitácora los movimientos relevantes (quién, qué y cuándo) para garantizar la trazabilidad. |

---

## Diferencia clave (para que no se te olvide)

| Funcional (RF) | No funcional (RNF) |
|----------------|--------------------|
| "El sistema debe **crear una reserva**." | "La reserva debe **guardarse en menos de 3 segundos**." |
| Describe una **acción**. | Describe una **cualidad** de esa acción. |
