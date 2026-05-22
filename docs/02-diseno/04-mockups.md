# Fase 2 — Diseño · Mockups (Wireframes)

> Un **mockup** es un boceto de la pantalla: muestra **dónde va cada elemento** (campos, botones, tablas), sin preocuparse aún por colores ni diseño final.
> Aquí se presentan como esquemas en texto (ASCII). Sirven para acordar la interfaz **antes** de programarla.

---

## 1. Login

```
+--------------------------------------------------+
|                                                  |
|            CADENA HOTELERA ANDINA                |
|                                                  |
|        +----------------------------------+      |
|        |  Correo:  [____________________] |      |
|        |  Clave:   [____________________] |      |
|        |                                  |      |
|        |          [  Ingresar  ]          |      |
|        +----------------------------------+      |
|                                                  |
+--------------------------------------------------+
```
- Si las credenciales son correctas → entra al sistema (RF-32).
- Si son incorrectas → mensaje de error bajo el formulario.

---

## 2. Estructura general (layout con menú dinámico)

El menú de la izquierda se arma según el **perfil** del usuario (RBAC). Un recepcionista no verá "Proveedores".

```
+------------------+-------------------------------------------+
|  HOTELES ANDINA  |   [Hotel: Sede Centro v]   Usuario: Ana ⌄ |
+------------------+-------------------------------------------+
| > Habitaciones   |                                           |
| > Reservas       |        (contenido de la pantalla          |
| > Check-in/out   |         seleccionada va aquí)             |
| > Clientes       |                                           |
| > Facturación    |                                           |
| > Inventario     |                                           |
| > Proveedores    |                                           |
| > Reportes       |                                           |
| > Configuración  |                                           |
+------------------+-------------------------------------------+
```

---

## 3. Listado de habitaciones

```
+----------------------------------------------------------+
|  Habitaciones — Hotel: Sede Centro      [ + Nueva ]       |
+----------------------------------------------------------+
|  Buscar: [__________]   Tipo: [Todos v]  Estado: [Todos v]|
+--------+-----------+----------+-----------+---------------+
| Número | Tipo      | Tarifa   | Estado    | Acciones      |
+--------+-----------+----------+-----------+---------------+
| 101    | Sencilla  | $50.000  | Disponible| [Ver][Editar] |
| 102    | Doble     | $80.000  | Ocupada   | [Ver][Editar] |
| 201    | Suite     | $150.000 | Limpieza  | [Ver][Editar] |
+--------+-----------+----------+-----------+---------------+
```

---

## 4. Crear reserva (CU-07)

```
+----------------------------------------------------------+
|  Nueva reserva                                           |
+----------------------------------------------------------+
|  Hotel:        [ Sede Centro            v ]              |
|  Fecha entrada:[ 25/05/2026 ]  Salida: [ 28/05/2026 ]   |
|                                                          |
|            [ Buscar disponibilidad ]                     |
|                                                          |
|  Habitaciones disponibles:                               |
|   ( ) 101 - Sencilla - $50.000/noche                     |
|   (•) 305 - Doble    - $80.000/noche                     |
|                                                          |
|  Cliente: [ Buscar por documento... ] [ + Nuevo ]        |
|                                                          |
|  ----------------------------------------------------    |
|  Noches: 3   Tarifa: $80.000   TOTAL: $240.000           |
|                                                          |
|                  [ Cancelar ]   [ Confirmar reserva ]    |
+----------------------------------------------------------+
```
- El total se calcula solo (tarifa × noches).
- Si la habitación ya fue tomada, el sistema avisa al confirmar.

---

## 5. Check-in / Check-out

```
+----------------------------------------------------------+
|  Check-in / Check-out                                    |
+----------------------------------------------------------+
|  Buscar reserva: [ #_____ o documento ]   [ Buscar ]     |
+----------------------------------------------------------+
|  Reserva #45  -  Juan Pérez  -  Hab. 305 (Doble)         |
|  Entrada: 25/05/2026   Salida: 28/05/2026                |
|  Estado: Confirmada                                      |
|                                                          |
|        [ Registrar CHECK-IN ]   [ Registrar CHECK-OUT ]  |
+----------------------------------------------------------+
```
- Check-in → habitación pasa a "Ocupada".
- Check-out → genera factura y libera la habitación.

---

## 6. Facturación

```
+----------------------------------------------------------+
|  Factura #1023            Estado: Pendiente              |
+----------------------------------------------------------+
|  Cliente: Juan Pérez       Reserva: #45                  |
|  Hab. 305 (Doble) · 3 noches × $80.000 .... $240.000     |
|  Servicios: Minibar ........................  $20.000     |
|  ----------------------------------------------------    |
|  Subtotal: $260.000   Impuestos: $26.000                 |
|  TOTAL: $286.000                                         |
|                                                          |
|        [ Registrar pago ]        [ Anular factura ]      |
+----------------------------------------------------------+
```

---

## 7. Reporte de ocupación (Administrador)

```
+----------------------------------------------------------+
|  Reporte de ocupación                                    |
+----------------------------------------------------------+
|  Hotel: [ Todos v ]   Del: [01/05/2026] Al: [31/05/2026] |
|                                  [ Generar ]             |
+----------------------------------------------------------+
|  Hotel         | Habitaciones | Ocupadas | % Ocupación   |
|  Sede Centro   |     40       |    32    |    80%        |
|  Sede Norte    |     25       |    15    |    60%        |
|  ------------------------------------------------------  |
|  TOTAL CADENA  |     65       |    47    |    72%        |
+----------------------------------------------------------+
```

---

## Nota

Estos wireframes son **de baja fidelidad** (solo estructura). El diseño visual final (colores, tipografías) se aplicará con Tailwind CSS en la fase de implementación. Lo importante aquí es validar **qué información y acciones** tiene cada pantalla.
