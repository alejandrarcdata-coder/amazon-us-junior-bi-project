# PASO 8 — Visual spec (detalle de campos)

## Slicers (sync group `US_Top3_Weekly`)

1. `slicer_week` → `dim_date[fiscal_week]` sorted by `week_start_et`
2. `slicer_category` → `dim_category[category_l1]`
3. `slicer_fulfillment` → `dim_fulfillment[fulfillment_name]`
4. `slicer_compare` → `prm_compare[mode]` (disconnected)

## Medidas en cada visual

Ver `powerbi/09_measures.dax`. Cards Ejecutiva usan:

- `GMV USD`, `GMV Δ vs Baseline %`
- `Cancel Rate`, `Cancel Δ vs Baseline pp`
- `Orders`, `Orders Δ vs Baseline %`
- `AOV`, `Late Shipment Rate`, `Active Sellers`

## Interacciones (edit interactions)

- E8 category bar → filtra E7 y E9; no filtra cards (cards siguen al slicer).
- E7 click semana → **no** pisa el slicer de semana (highlight only) para no romper 13w.
- O3 seller table → filtra O4 reasons; no filtra O1 matrix (evita vacío).

## Accesibilidad

- Contraste AA en cards.
- Tab order: slicers → cards → trend → category → reasons.
- Alt text en cada visual: “GMV USD top-3 US by fiscal week”.

## Mobile (servicio PBI)

v1 no publica layout phone. El mock web reflow a 390px apila cards 2×3 y esconde dual-axis labels cortas.
