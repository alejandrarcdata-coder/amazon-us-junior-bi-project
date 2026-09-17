# PASO 9 — Modelo Power BI

**Modo:** Import (no DirectQuery). Datamart cabe en memoria junior.  
**Refresh:** 06:00 America/New_York diario (gateway no requerido si el mart está en cloud warehouse + PBI service native connector).

## Tablas importadas

| Tabla | Origen | Modo | Hidden |
| --- | --- | --- | --- |
| fct_order_items_us | mart_us.fct_order_items_us | Import | No |
| fct_cancellations_us | mart_us.fct_cancellations_us | Import | No |
| dim_date | mart_us.dim_date | Import | No |
| dim_seller | mart_us.dim_seller | Import | No |
| dim_product | mart_us.dim_product | Import | Yes (v1, no visual ASIN) |
| dim_category | mart_us.dim_category | Import | No |
| dim_fulfillment | mart_us.dim_fulfillment | Import | No |
| dim_cancellation_reason | mart_us.dim_cancellation_reason | Import | No |
| prm_compare | Enter data (2 rows) | Import | No |
| fin_gmv_flash | cleaned_us.fin_gmv_flash | Import | Yes (solo reconcil) |

DirectQuery: **ninguna**.

## Relaciones

| From | To | Card | Cross filter | Active |
| --- | --- | --- | --- | --- |
| fct_order_items_us[date_sk] | dim_date[date_sk] | * : 1 | Single | Yes |
| fct_order_items_us[seller_sk] | dim_seller[seller_sk] | * : 1 | Single | Yes |
| fct_order_items_us[product_sk] | dim_product[product_sk] | * : 1 | Single | Yes |
| fct_order_items_us[category_sk] | dim_category[category_sk] | * : 1 | Single | Yes |
| fct_order_items_us[fulfillment_sk] | dim_fulfillment[fulfillment_sk] | * : 1 | Single | Yes |
| fct_cancellations_us[date_sk] | dim_date[date_sk] | * : 1 | Single | Yes |
| fct_cancellations_us[seller_sk] | dim_seller[seller_sk] | * : 1 | Single | Yes |
| fct_cancellations_us[reason_sk] | dim_cancellation_reason[reason_sk] | * : 1 | Single | Yes |
| fct_cancellations_us[category_sk] | dim_category[category_sk] | * : 1 | Single | Yes |
| fct_cancellations_us[fulfillment_sk] | dim_fulfillment[fulfillment_sk] | * : 1 | Single | Yes |

Ambos facts filtran por las mismas dims. No hay relación fact-to-fact. Bidirectional **off**.

## Calendario

`dim_date` es la tabla de fechas. Mark as date table = `date_et`.  
Semana fiscal: `week_start_et` = domingo ET. Sort `fiscal_week` by `week_start_et`.

## Columnas calculadas

Ninguna en v1. `gmv_usd` y `gmv_eligible_flag` vienen del mart.

## Hide

Hide all `*_sk` FKs, `gift_wrap_amt`, `shipping_amt`, `tax_amt` (evitar que alguien los sume).
