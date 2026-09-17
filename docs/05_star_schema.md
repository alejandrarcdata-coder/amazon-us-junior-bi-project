# Star schema — mart_us

Warehouse estilo Redshift. Schema `mart_us`.  
Convención: `*_sk` INTEGER identity, PK surrogate. FKs en facts.  
Todo ya filtrado US / USD / terna / no-B2B.

```
                    dim_date
                       |
                       | date_sk
                       v
dim_seller -----> fct_order_items_us <----- dim_product
                       |   ^                    |
                       |   |                    v
                       |   |               dim_category
                       |   |
              dim_fulfillment
                       |
                       v
              fct_cancellations_us ---- dim_cancellation_reason
                       |
                    dim_date, dim_seller, dim_product, dim_category, dim_fulfillment
```

## dim_date

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| date_sk | INTEGER | PK | YYYYMMDD |
| date_et | DATE | UK | Fecha ET |
| day_name | VARCHAR(10) | | Sunday..Saturday |
| fiscal_week | VARCHAR(8) | | `2026W28` |
| week_start_et | DATE | | Domingo |
| week_end_et | DATE | | Sábado |
| fiscal_year | INTEGER | | 2026 |
| month_num | SMALLINT | | 1–12 |
| month_name | VARCHAR(12) | | |
| is_weekend | BOOLEAN | | Sat/Sun |
| is_amazon_prime_event | BOOLEAN | | default false v1 |

## dim_seller

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| seller_sk | INTEGER | PK | |
| seller_id | VARCHAR(20) | UK | natural |
| seller_name | VARCHAR(200) | | comercial |
| seller_state_us | CHAR(2) | | |
| primary_category_l1 | VARCHAR(80) | | |
| pref_fulfillment | VARCHAR(8) | | AFN/MFN |
| active_flag | BOOLEAN | | |

Sin email / bank / address.

## dim_product

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| product_sk | INTEGER | PK | |
| asin | VARCHAR(10) | UK | |
| sku_sample | VARCHAR(40) | | descriptivo |
| product_title | VARCHAR(200) | | |
| browse_node_id | VARCHAR(20) | | |
| category_sk | INTEGER | FK | → dim_category |

## dim_category

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| category_sk | INTEGER | PK | 1 HK, 2 SO, 3 PET |
| category_l1 | VARCHAR(80) | UK | |
| browse_node_id_l1 | VARCHAR(20) | | 3760911 / 3375251 / 2619533011 |
| watchlist_flag | BOOLEAN | | true |

## dim_fulfillment

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| fulfillment_sk | INTEGER | PK | |
| fulfillment_channel | VARCHAR(8) | UK | AFN / MFN |
| fulfillment_name | VARCHAR(8) | | FBA / FBM |

## dim_cancellation_reason

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| reason_sk | INTEGER | PK | |
| reason_code | VARCHAR(40) | UK | |
| reason_desc | VARCHAR(200) | | |
| actor | VARCHAR(10) | | BUYER / SELLER / AMAZON |
| reason_bucket | VARCHAR(40) | | Inventory / Buyer / Policy / Logistics / Payment / Other |

## fct_order_items_us

Grano: 1 fila = 1 order_item US terna.

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| order_item_sk | BIGINT | PK | |
| order_item_id | VARCHAR(24) | UK | natural |
| order_id | VARCHAR(24) | | |
| date_sk | INTEGER | FK | order date ET |
| seller_sk | INTEGER | FK | |
| product_sk | INTEGER | FK | |
| category_sk | INTEGER | FK | |
| fulfillment_sk | INTEGER | FK | |
| quantity_ordered | INTEGER | | gross (denominador cancel) |
| item_price_amt | NUMERIC(18,2) | | USD |
| gift_wrap_amt | NUMERIC(18,2) | | no entra GMV |
| shipping_amt | NUMERIC(18,2) | | no entra GMV |
| tax_amt | NUMERIC(18,2) | | no entra GMV |
| gmv_eligible_flag | BOOLEAN | | spec GMV |
| cancelled_before_ship_flag | BOOLEAN | | |
| is_late_ship_flag | BOOLEAN | | proxy si hay actual ship |
| gmv_usd | NUMERIC(18,2) | | item_price*qty si eligible else 0 |

## fct_cancellations_us

Grano: 1 fila = 1 evento cancel por order_item.

| Columna | Tipo | PK/FK | Notas |
| --- | --- | --- | --- |
| cancel_sk | BIGINT | PK | |
| cancel_id | VARCHAR(24) | UK | |
| order_item_id | VARCHAR(24) | | |
| order_id | VARCHAR(24) | | |
| date_sk | INTEGER | FK | **order** date ET (atribución) |
| cancel_date_sk | INTEGER | FK | fecha cancel ET |
| seller_sk | INTEGER | FK | |
| product_sk | INTEGER | FK | |
| category_sk | INTEGER | FK | |
| fulfillment_sk | INTEGER | FK | |
| reason_sk | INTEGER | FK | |
| cancelled_qty | INTEGER | | |
| cancelled_before_ship_flag | BOOLEAN | | |
| actor | VARCHAR(10) | | |

No se guarda PII. No se guarda RoW.
