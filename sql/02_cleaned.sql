-- =============================================================================
-- 02_cleaned.sql
-- Limpieza: nulos, duplicados, USD, timezone ET, terna, no-B2B, flags GMV.
-- =============================================================================

CREATE SCHEMA IF NOT EXISTS cleaned_us;

-- Date spine domingo-sábado 2026 (generado una vez).
-- Redshift: se puede materializar desde una tabla números. Aquí el contrato.
CREATE TABLE IF NOT EXISTS cleaned_us.dim_date_seed (
    date_et DATE PRIMARY KEY
);

-- ---------------------------------------------------------------------------
-- Orders cleaned: ET + excluye B2B
-- ---------------------------------------------------------------------------
CREATE TABLE cleaned_us.orders AS
SELECT
    o.order_id,
    o.marketplace_id,
    o.country_code,
    o.seller_id,
    o.order_datetime_utc,
    CONVERT_TIMEZONE('UTC', 'America/New_York', o.order_datetime_utc) AS order_datetime_et,
    CAST(CONVERT_TIMEZONE('UTC', 'America/New_York', o.order_datetime_utc) AS DATE) AS order_date_et,
    o.fulfillment_channel,
    CASE o.fulfillment_channel WHEN 'AFN' THEN 'FBA' WHEN 'MFN' THEN 'FBM' END AS fulfillment_name,
    o.is_business_order,
    o.order_status,
    CONVERT_TIMEZONE('UTC', 'America/New_York', o.ship_promise_datetime_utc) AS ship_promise_et
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_datetime_utc DESC) AS rn
    FROM stg_us.orders
) o
WHERE o.rn = 1
  AND o.country_code = 'US'
  AND o.marketplace_id = 'ATVPDKIKX0DER'
  AND COALESCE(o.is_business_order, FALSE) = FALSE
  AND o.order_id IS NOT NULL;

-- ---------------------------------------------------------------------------
-- Items cleaned: USD + terna + join order + CBS flag
-- ---------------------------------------------------------------------------
CREATE TABLE cleaned_us.order_items AS
SELECT
    i.order_item_id,
    i.order_id,
    o.order_date_et,
    o.order_datetime_et,
    i.asin,
    i.sku,
    i.product_title,
    i.browse_node_id,
    i.category_l1,
    i.quantity_ordered,
    i.item_price_amt,
    i.currency_code,
    COALESCE(i.gift_wrap_amt, 0) AS gift_wrap_amt,
    COALESCE(i.shipping_amt, 0) AS shipping_amt,
    COALESCE(i.tax_amt, 0) AS tax_amt,
    COALESCE(i.is_replacement, FALSE) AS is_replacement,
    i.seller_id,
    o.fulfillment_channel,
    o.fulfillment_name,
    CASE WHEN c.order_item_id IS NOT NULL THEN TRUE ELSE FALSE END AS has_cancel,
    COALESCE(c.cancelled_before_ship_flag, FALSE) AS cancelled_before_ship_flag,
    -- gmv eligible: spec KPI-GMV-US-3P
    CASE
        WHEN i.quantity_ordered > 0
         AND i.currency_code = 'USD'
         AND i.item_price_amt IS NOT NULL
         AND COALESCE(i.is_replacement, FALSE) = FALSE
         AND i.category_l1 IN ('Home & Kitchen', 'Sports & Outdoors', 'Pet Supplies')
         AND COALESCE(c.cancelled_before_ship_flag, FALSE) = FALSE
        THEN TRUE ELSE FALSE
    END AS gmv_eligible_flag
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_item_id ORDER BY order_id) AS rn
    FROM stg_us.order_items
) i
JOIN cleaned_us.orders o
  ON o.order_id = i.order_id
LEFT JOIN (
    SELECT order_item_id,
           BOOL_OR(cancelled_before_ship_flag) AS cancelled_before_ship_flag
    FROM stg_us.cancellations
    GROUP BY order_item_id
) c ON c.order_item_id = i.order_item_id
WHERE i.rn = 1
  AND i.currency_code = 'USD'
  AND i.category_l1 IN ('Home & Kitchen', 'Sports & Outdoors', 'Pet Supplies')
  AND i.quantity_ordered IS NOT NULL
  AND i.quantity_ordered > 0;

-- ---------------------------------------------------------------------------
-- Cancellations cleaned
-- ---------------------------------------------------------------------------
CREATE TABLE cleaned_us.cancellations AS
SELECT
    c.cancel_id,
    c.order_item_id,
    c.order_id,
    i.order_date_et,          -- atribución = order date
    CONVERT_TIMEZONE('UTC', 'America/New_York', c.cancelled_at_utc) AS cancelled_at_et,
    COALESCE(c.cancelled_before_ship_flag, TRUE) AS cancelled_before_ship_flag,
    UPPER(TRIM(c.reason_code)) AS reason_code,
    c.reason_desc,
    CASE
        WHEN UPPER(c.reason_code) IN ('OUT_OF_STOCK') THEN 'Inventory'
        WHEN UPPER(c.reason_code) IN ('SHIP_LATE_RISK') THEN 'Logistics'
        WHEN UPPER(c.reason_code) IN ('BUYER_CANCEL', 'ADDR_INVALID') THEN 'Buyer'
        WHEN UPPER(c.reason_code) IN ('AMZ_POLICY') THEN 'Policy'
        WHEN UPPER(c.reason_code) IN ('PAYMENT_FAIL') THEN 'Payment'
        WHEN UPPER(c.reason_code) IN ('PRICING_ERROR') THEN 'Seller ops'
        ELSE 'Other'
    END AS reason_bucket,
    c.cancelled_qty,
    UPPER(c.actor) AS actor,
    i.category_l1,
    i.seller_id,
    i.fulfillment_channel
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY cancel_id ORDER BY cancelled_at_utc DESC) AS rn
    FROM stg_us.cancellations
) c
JOIN cleaned_us.order_items i
  ON i.order_item_id = c.order_item_id
WHERE c.rn = 1
  AND c.cancelled_qty > 0;

-- ---------------------------------------------------------------------------
-- Returns / sellers / flashes (passthrough limpio)
-- ---------------------------------------------------------------------------
CREATE TABLE cleaned_us.returns AS
SELECT r.*, CONVERT_TIMEZONE('UTC', 'America/New_York', r.returned_at_utc) AS returned_at_et
FROM stg_us.returns r
JOIN cleaned_us.order_items i ON i.order_item_id = r.order_item_id;

CREATE TABLE cleaned_us.sellers AS
SELECT *
FROM stg_us.sellers
WHERE country_code = 'US';

CREATE TABLE cleaned_us.fin_gmv_flash AS
SELECT *
FROM stg_us.fin_gmv_flash
WHERE category_l1 IN ('Home & Kitchen', 'Sports & Outdoors', 'Pet Supplies');

CREATE TABLE cleaned_us.sp_cancel_flash AS
SELECT *
FROM stg_us.sp_cancel_flash
WHERE category_l1 IN ('Home & Kitchen', 'Sports & Outdoors', 'Pet Supplies');
