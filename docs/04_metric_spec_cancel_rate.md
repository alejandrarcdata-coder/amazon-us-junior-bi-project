# Metric spec — Cancel rate (1 página)

| Campo | Valor |
| --- | --- |
| Nombre | Cancel rate |
| ID | KPI-CANCEL-US-3P |
| Versión | 1.0 — 09/14/2026 |
| Accountable | Priya Shah |
| Steward | Diego Alvarez (Seller Performance) |
| Builder | Camila Quispe Rojas |
| Fuente mart | `mart_us.fct_cancellations_us` + denominador `fct_order_items_us` |
| Fuente oficial | `SP.US_CANCEL_WKLY` |
| Unidad | % |
| Formato PBI | `0.0%` |
| Grano nativo | order_item |
| Atribución temporal | semana fiscal de `order_datetime_et` (no de cancelled_at) |
| Marketplace | US only |

## Fórmula

```
Cancel_rate = cancelled_units / ordered_units_gross

cancelled_units      = SUM(cancelled_qty)            -- fct_cancellations_us
ordered_units_gross  = SUM(quantity_ordered)         -- todos los items US terna no-B2B no-replacement
                                                     -- INCLUYE los que después son CBS
```

No usar `COUNT(orders)` en v1 (un order puede cancelar 1 de 3 items).

## Inclusiones en el numerador

- CBS (`cancelled_before_ship_flag = true`).
- Cancel post-ship si el feed SP lo trae (raro; se marca `cancel_timing = AFTER_SHIP`).
- Actores BUYER, SELLER, AMAZON. El breakdown es drill, no filtro default.

## Exclusiones

| Excepción | Tratamiento |
| --- | --- |
| Returns | No son cancel. Van a return rate |
| Gift wrap / shipping lines | No hay línea de fee en el denominador |
| B2B | Fuera v1 |
| Replacement | Fuera numerador y denominador |
| CA/MX/PE | Fuera |

## Relación con GMV

- CBS **sale** de GMV y **entra** al numerador de cancel.
- Por eso GMV cae y cancel rate sube a la vez en Pet Supplies FBM: es coherente, no es doble conteo erróneo.

## Tolerancia vs SP

- Top-3 × semana: ≤ 0.25 pp
- Categoría × semana: ≤ 0.40 pp

## DAX de referencia

```
Cancelled Units = SUM(fct_cancellations_us[cancelled_qty])
Ordered Units Gross = SUM(fct_order_items_us[quantity_ordered])
Cancel Rate = DIVIDE([Cancelled Units], [Ordered Units Gross])
```

## Ejemplo (sample)

20 cancels / 32 items no es la tasa oficial (sample sesgado). La tasa que se enseña a liderazgo sale del flash SP y del mart a escala, no del CSV de 32 filas.
