# KPI dictionary — única versión de la verdad

Proyecto: AMP-US-OPS-WKLY-2026Q3  
Congelado por: Priya Shah (A) · Rachel Cho (C GMV) · Diego Alvarez (C cancel) · Camila (R)  
Fecha: 09/14/2026 · Marketplace: US · Moneda: USD · TZ: America/New_York  
Semana: domingo 00:00 ET → sábado 23:59:59 ET

Filtros globales (aplican a TODA fila salvo que la spec diga lo contrario):

- `marketplace_id = 'ATVPDKIKX0DER'` OR `country_code = 'US'`
- `currency_code = 'USD'`
- `category_l1 IN ('Home & Kitchen','Sports & Outdoors','Pet Supplies')`
- `is_business_order = false`
- `is_replacement = false`
- 3P only (`merchant_id` no es Amazon Retail 1P)

---

| KPI | Fórmula exacta | Grano de cálculo | Grano de reporte | Owner | Fuente primaria | Excepciones |
| --- | --- | --- | --- | --- | --- | --- |
| GMV USD | `SUM(item_price_amt * quantity_ordered)` sobre items **elegibles GMV** | order_item | semana fiscal × categoría (también seller / fulfillment) | Rachel Cho | `fct_order_items_us` reconciliado vs `FIN.MP_US_3P_GMV_WKLY` | Ver spec. Fuera: tax, shipping, gift wrap, CBS, replacements, B2B, returns (returns NO restan). |
| # Orders | `COUNT(DISTINCT order_id)` donde el order tiene ≥1 item elegible GMV | order | semana × cat | Priya | `fct_order_items_us` | Un order multi-cat cuenta en cada cat donde tenga item (reporte por cat) y una sola vez en top-3. |
| Units | `SUM(quantity_ordered)` items elegibles GMV | order_item | semana × cat | Priya | `fct_order_items_us` | CBS no cuenta (el item salió de elegibles GMV). |
| AOV | `GMV USD / # Orders` | derivado | semana × cat / top-3 | Priya | medidas DAX | No usar items; usar orders del mismo filtro. |
| Cancel rate | `SUM(cancelled_qty) / SUM(quantity_ordered_gross)` | order_item | semana × cat | Diego Alvarez | `fct_cancellations_us` + denominador gross en items | Denominador = qty ordered **antes** de excluir CBS. Numerador incluye CBS y cancel post-ship raro. Ver spec. |
| Late shipment rate | `COUNT(shipments late) / COUNT(shipments)` donde `actual_ship_et > ship_promise_et` | shipment / order | semana × cat × fulfillment | FBA Ops / Priya | orders + ship events (proxy: promise vs cancel SHIP_LATE_RISK si no hay ship table) | Excluye CBS (nunca shipped). FBA y FBM se reportan separado. |
| A-to-Z claim rate | `COUNT(distinct a2z_claim_id) / # Orders` | claim / order | semana × cat | Diego | SP feed (si no hay tabla, placeholder 0 + issue) | Solo claims US. No es lo mismo que cancel. |
| Return rate | `SUM(returned_qty) / SUM(quantity_shipped)` | return_item | semana × cat | Returns US | `returns` + items shipped | Returns no tocan GMV. Semana = semana del return, no de la order (documentado). |
| Active sellers | `COUNT(DISTINCT seller_id)` con ≥1 item elegible GMV en la semana | seller × semana | semana × cat | Priya | `fct_order_items_us` | Seller multi-cat cuenta en cada cat y una vez en top-3. |

## Items elegibles GMV (definición corta)

```
quantity_ordered > 0
AND currency_code = 'USD'
AND marketplace US
AND category in terna
AND is_business_order = false
AND is_replacement = false
AND NOT cancelled_before_ship
AND item_price_amt IS NOT NULL
```

`gift_wrap_amt` y `shipping_amt` y `tax_amt` **nunca** se suman.

## Qué no es un KPI v1

- Sessions, ads spend, TACOS, conversion (S09 opcional).
- Net GMV after returns.
- GMV CAD/MXN convertido.
