-- =============================================================================
-- 03_mart.sql
-- Dimensiones + facts US. Modelo estrella listo para Power BI Import.
-- =============================================================================

CREATE SCHEMA IF NOT EXISTS mart_us;

-- dim_category (terna congelada)
CREATE TABLE mart_us.dim_category (
    category_sk         INTEGER PRIMARY KEY,
    category_l1         VARCHAR(80) UNIQUE,
    browse_node_id_l1   VARCHAR(20),
    watchlist_flag      BOOLEAN
);

INSERT INTO mart_us.dim_category VALUES
    (1, 'Home & Kitchen',      '3760911',    TRUE),
    (2, 'Sports & Outdoors',   '3375251',    TRUE),
    (3, 'Pet Supplies',        '2619533011', TRUE);

-- dim_fulfillment
CREATE TABLE mart_us.dim_fulfillment (
    fulfillment_sk        INTEGER PRIMARY KEY,
    fulfillment_channel   VARCHAR(8) UNIQUE,
    fulfillment_name      VARCHAR(8)
);

INSERT INTO mart_us.dim_fulfillment VALUES
    (1, 'AFN', 'FBA'),
    (2, 'MFN', 'FBM');

-- dim_cancellation_reason
CREATE TABLE mart_us.dim_cancellation_reason AS
SELECT
    ROW_NUMBER() OVER (ORDER BY reason_code) AS reason_sk,
    reason_code,
    MAX(reason_desc) AS reason_desc,
    MAX(actor) AS actor,
    MAX(reason_bucket) AS reason_bucket
FROM cleaned_us.cancellations
GROUP BY reason_code;

-- dim_seller
CREATE TABLE mart_us.dim_seller AS
SELECT
    ROW_NUMBER() OVER (ORDER BY seller_id) AS seller_sk,
    seller_id,
    seller_name,
    seller_state_us,
    primary_category_l1,
    pref_fulfillment,
    active_flag
FROM cleaned_us.sellers;

-- dim_product
CREATE TABLE mart_us.dim_product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY asin) AS product_sk,
    asin,
    MAX(sku) AS sku_sample,
    MAX(product_title) AS product_title,
    MAX(browse_node_id) AS browse_node_id,
    MAX(c.category_sk) AS category_sk
FROM cleaned_us.order_items i
JOIN mart_us.dim_category c ON c.category_l1 = i.category_l1
GROUP BY asin;

-- dim_date: de las fechas observadas + seed si existe
CREATE TABLE mart_us.dim_date AS
SELECT DISTINCT
    CAST(TO_CHAR(d.date_et, 'YYYYMMDD') AS INTEGER) AS date_sk,
    d.date_et,
    TO_CHAR(d.date_et, 'Day') AS day_name,
    TO_CHAR(DATE_TRUNC('week', d.date_et + INTERVAL '1 day') - INTERVAL '1 day', 'IYYY') 
        || 'W' || TO_CHAR(DATE_TRUNC('week', d.date_et + INTERVAL '1 day') - INTERVAL '1 day', 'IW') 
        AS fiscal_week_iso_shift,
    DATE_TRUNC('week', d.date_et + INTERVAL '1 day')::DATE - 1 AS week_start_et,  -- domingo
    DATE_TRUNC('week', d.date_et + INTERVAL '1 day')::DATE + 5 AS week_end_et,    -- sábado
    EXTRACT(YEAR FROM d.date_et) AS fiscal_year,
    EXTRACT(MONTH FROM d.date_et) AS month_num,
    TO_CHAR(d.date_et, 'Month') AS month_name,
    CASE WHEN EXTRACT(DOW FROM d.date_et) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend,
    FALSE AS is_amazon_prime_event
FROM (
    SELECT DISTINCT order_date_et AS date_et FROM cleaned_us.order_items
    UNION
    SELECT CAST(week_start_et AS DATE) FROM cleaned_us.fin_gmv_flash
) d;

-- Nota: fiscal_week de negocio se recalcula en el fact con week_start_et del dim.
-- Label canónico YYYYWww se aplica en PBI o:
--   '2026W' || LPAD(week_of_amazon, 2, '0')
-- El shift +1 day / -1 day convierte weeks ISO-lunes a domingo-sábado.

-- fct_order_items_us
CREATE TABLE mart_us.fct_order_items_us AS
SELECT
    ROW_NUMBER() OVER (ORDER BY i.order_item_id) AS order_item_sk,
    i.order_item_id,
    i.order_id,
    CAST(TO_CHAR(i.order_date_et, 'YYYYMMDD') AS INTEGER) AS date_sk,
    s.seller_sk,
    p.product_sk,
    c.category_sk,
    f.fulfillment_sk,
    i.quantity_ordered,
    i.item_price_amt,
    i.gift_wrap_amt,
    i.shipping_amt,
    i.tax_amt,
    i.gmv_eligible_flag,
    i.cancelled_before_ship_flag,
    CAST(NULL AS BOOLEAN) AS is_late_ship_flag,  -- v1.1 cuando exista actual_ship
    CASE WHEN i.gmv_eligible_flag
         THEN i.item_price_amt * i.quantity_ordered
         ELSE 0
    END AS gmv_usd
FROM cleaned_us.order_items i
JOIN mart_us.dim_seller s       ON s.seller_id = i.seller_id
JOIN mart_us.dim_product p      ON p.asin = i.asin
JOIN mart_us.dim_category c     ON c.category_l1 = i.category_l1
JOIN mart_us.dim_fulfillment f  ON f.fulfillment_channel = i.fulfillment_channel;

-- fct_cancellations_us
CREATE TABLE mart_us.fct_cancellations_us AS
SELECT
    ROW_NUMBER() OVER (ORDER BY k.cancel_id) AS cancel_sk,
    k.cancel_id,
    k.order_item_id,
    k.order_id,
    CAST(TO_CHAR(k.order_date_et, 'YYYYMMDD') AS INTEGER) AS date_sk,
    CAST(TO_CHAR(CAST(k.cancelled_at_et AS DATE), 'YYYYMMDD') AS INTEGER) AS cancel_date_sk,
    s.seller_sk,
    p.product_sk,
    c.category_sk,
    f.fulfillment_sk,
    r.reason_sk,
    k.cancelled_qty,
    k.cancelled_before_ship_flag,
    k.actor
FROM cleaned_us.cancellations k
JOIN cleaned_us.order_items i   ON i.order_item_id = k.order_item_id
JOIN mart_us.dim_seller s       ON s.seller_id = k.seller_id
JOIN mart_us.dim_product p      ON p.asin = i.asin
JOIN mart_us.dim_category c     ON c.category_l1 = k.category_l1
JOIN mart_us.dim_fulfillment f  ON f.fulfillment_channel = k.fulfillment_channel
JOIN mart_us.dim_cancellation_reason r ON r.reason_code = k.reason_code;

-- Vista de trabajo para PASO 7 (agregado semanal vs flash)
CREATE VIEW mart_us.vw_gmv_weekly AS
SELECT
    d.week_start_et,
    c.category_l1,
    SUM(f.gmv_usd) AS gmv_usd_mart,
    COUNT(DISTINCT f.order_id) AS orders_mart,
    SUM(f.quantity_ordered) AS units_gross_mart
FROM mart_us.fct_order_items_us f
JOIN mart_us.dim_date d     ON d.date_sk = f.date_sk
JOIN mart_us.dim_category c ON c.category_sk = f.category_sk
GROUP BY d.week_start_et, c.category_l1;

CREATE VIEW mart_us.vw_cancel_weekly AS
SELECT
    d.week_start_et,
    c.category_l1,
    SUM(k.cancelled_qty) AS cancelled_units_mart
FROM mart_us.fct_cancellations_us k
JOIN mart_us.dim_date d     ON d.date_sk = k.date_sk
JOIN mart_us.dim_category c ON c.category_sk = k.category_sk
GROUP BY d.week_start_et, c.category_l1;
