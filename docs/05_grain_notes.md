# Grain notes

## fct_order_items_us

**Una fila = un order_item_id del marketplace US en la terna, no-B2B, no-replacement.**

- No agregar a nivel order en el fact (rompe Units y Cancel rate).
- `gmv_usd` es una columna materializada para QA; la medida DAX debe poder reconstruirla.
- Un order con 2 items de 2 categorías produce 2 filas y 2 category_sk distintos.
- `# Orders` top-3 usa DISTINCT order_id; `# Orders` por categoría cuenta el order si tiene ≥1 item en esa cat.

## fct_cancellations_us

**Una fila = un cancel_id** (evento). Si un item se cancelara dos veces (no esperado), habría 2 filas; el test DQ falla si `COUNT(*) <> COUNT(DISTINCT order_item_id)` sin nota.

Atribución de semana = semana de la **order**, no de la cancel, para alinear numerador y denominador con SP flash.

## dim_date

Cubrir 2026-01-01 a 2026-12-31 mínimo. `week_start_et` siempre domingo. No usar `DATE_TRUNC('week', ...)` ISO (lunes) de Redshift sin ajustar.

## Relación facts ↔ dims

- Many-to-one desde fact a cada dim.
- `dim_product.category_sk` es denormalización conveniente; el fact también lleva `category_sk` para filtros rápidos (la categoría de la venta, no la primaria del ASIN si divergieran).

## Lo que no es un fact v1

- inventory_health queda en `stg` / `cleaned` para hipótesis, no en el modelo PBI Must.
- returns puede ser `fct_returns_us` en v1.1; v1 calcula return rate desde cleaned en SQL y una medida simple si da tiempo (Should).
