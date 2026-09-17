# Source catalog — US Marketplace (v1)

Filtro permanente de consumo: `marketplace_id = 'ATVPDKIKX0DER'` y/o `country_code = 'US'`.  
Owner catálogo: Camila · Contrato fuente: Marcus Lee · Accesos: Luis Huamán  
Actualizado: 09/14/2026

## Inventario

| Source ID | Nombre negocio | Sistema / objeto warehouse | Grano | Refresh | Owner negocio | PII | Usado en v1 | Notas |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S01 | Orders header | `raw_us.orders` | 1 row = 1 order_id | Diario 03:00 ET | Category Ops | Dirección ship (no traer) | Sí | order_datetime UTC → convertir ET |
| S02 | Order items | `raw_us.order_items` | 1 row = 1 order_item_id | Diario 03:00 ET | Category Ops | No | Sí | Precio item + qty. Base de GMV |
| S03 | Cancellations | `raw_us.cancellations` | 1 row = 1 cancel event por order_item | Diario 03:30 ET | Seller Performance | No | Sí | reason_code + cancelled_before_ship_flag |
| S04 | Returns | `raw_us.returns` | 1 row = 1 return_item | Diario 04:00 ET | Customer Returns US | No | Sí | No netea GMV |
| S05 | Sellers | `raw_us.sellers` | 1 row = 1 seller_id | Diario 02:00 ET | Selling Partner | Email, bank — **no extraer** | Sí | Vista tokenizada `raw_us.sellers_pub` |
| S06 | Inventory health | `raw_us.inventory_health_daily` | 1 row = seller × ASIN × fecha | Diario 05:00 ET | FBA Ops | No | Sí (contexto late ship) | IPI, OOS, aged inventory |
| S07 | Official GMV flash | `fin.mp_us_3p_gmv_wkly` (`FIN.MP_US_3P_GMV_WKLY`) | categoría L1 × semana fiscal | Lun 08:00 ET | Rachel Cho (FP&A) | No | Sí (PASO 7) | Source of truth GMV |
| S08 | Official cancel weekly | `sp.us_cancel_wkly` (`SP.US_CANCEL_WKLY`) | categoría L1 × reason × semana | Lun 08:30 ET | Diego Alvarez | No | Sí (PASO 7) | Source of truth cancel |
| S09 | Traffic / ads (opc.) | `ads.us_traffic_weekly` | categoría × semana | Lun 09:00 ET | Ads | No | Opcional | No es KPI primario |
| S10 | Browse node map | `ref.browse_node_l1_us` | browse_node_id → L1 | Manual | CMs | No | Sí | Congela terna HK/SO/PET |

## Campos mínimos que el junior debe pedir (no PII)

### S01 orders
`order_id, marketplace_id, country_code, seller_id, order_datetime_utc, fulfillment_channel, is_business_order, order_status, ship_promise_datetime_utc`

### S02 order_items
`order_item_id, order_id, asin, sku, browse_node_id, quantity_ordered, item_price_amt, currency_code, gift_wrap_amt, shipping_amt, tax_amt, is_replacement`

### S03 cancellations
`cancel_id, order_item_id, order_id, cancelled_at_utc, cancelled_before_ship_flag, reason_code, reason_desc, cancelled_qty, actor` (BUYER / SELLER / AMAZON)

### S04 returns
`return_id, order_item_id, returned_qty, return_reason, returned_at_utc, refund_amt_usd`

### S05 sellers_pub
`seller_id, seller_name, seller_state_us, primary_category_l1, active_flag, pref_fulfillment`

### S06 inventory_health_daily
`snapshot_date, seller_id, asin, fulfillment_channel, on_hand_units, oos_flag, aged_90_units, ipi_score`

## Reglas de ingestión v1

1. Nada entra al mart si `marketplace_id <> 'ATVPDKIKX0DER'`.
2. Convertir timestamps: `CONVERT_TIMEZONE('UTC','America/New_York', ts)`.
3. Descartar `currency_code <> 'USD'` (no FX en v1; si aparece, log issue).
4. No persistir columnas PII aunque existan en raw.
5. Samples de diseño en `data/sample/` son sintéticos.

## Mapa sample → raw

| Sample file | Source ID |
| --- | --- |
| `data/sample/orders_us.csv` | S01 |
| `data/sample/order_items_us.csv` | S02 |
| `data/sample/cancellations_us.csv` | S03 |
| `data/sample/returns_us.csv` | S04 |
| `data/sample/sellers_us.csv` | S05 |
| `data/sample/inventory_health_us.csv` | S06 |
| `data/sample/fin_gmv_flash_us.csv` | S07 |
| `data/sample/sp_cancel_flash_us.csv` | S08 |
