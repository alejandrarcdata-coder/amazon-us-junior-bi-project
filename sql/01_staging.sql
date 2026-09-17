-- =============================================================================
-- 01_staging.sql
-- AMP-US-OPS-WKLY-2026Q3
-- Copia raw -> stg_us sin transformar negocio. Solo US + columnas no-PII.
-- Dialecto: ANSI cercano a Redshift.
-- =============================================================================

CREATE SCHEMA IF NOT EXISTS stg_us;
CREATE SCHEMA IF NOT EXISTS raw_us;

-- ---------------------------------------------------------------------------
-- Orders: un pedido US. Descartamos ship address / phone si existieran en raw.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stg_us.orders (
    order_id                    VARCHAR(24),
    marketplace_id              VARCHAR(20),
    country_code                VARCHAR(2),
    seller_id                   VARCHAR(20),
    order_datetime_utc          TIMESTAMP,
    fulfillment_channel         VARCHAR(8),
    is_business_order           BOOLEAN,
    order_status                VARCHAR(20),
    ship_promise_datetime_utc   TIMESTAMP,
    _ingested_at                TIMESTAMP DEFAULT GETDATE()
);

-- Staging load pattern (Redshift COPY o INSERT SELECT).
INSERT INTO stg_us.orders (
    order_id, marketplace_id, country_code, seller_id,
    order_datetime_utc, fulfillment_channel, is_business_order,
    order_status, ship_promise_datetime_utc
)
SELECT
    o.order_id,
    o.marketplace_id,
    o.country_code,
    o.seller_id,
    o.order_datetime_utc,
    o.fulfillment_channel,
    o.is_business_order,
    o.order_status,
    o.ship_promise_datetime_utc
FROM raw_us.orders o
WHERE o.marketplace_id = 'ATVPDKIKX0DER'   -- US website
   OR o.country_code = 'US';

-- ---------------------------------------------------------------------------
-- Order items
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stg_us.order_items (
    order_item_id       VARCHAR(24),
    order_id            VARCHAR(24),
    asin                VARCHAR(10),
    sku                 VARCHAR(40),
    product_title       VARCHAR(200),
    browse_node_id      VARCHAR(20),
    category_l1         VARCHAR(80),
    quantity_ordered    INTEGER,
    item_price_amt      NUMERIC(18,2),
    currency_code       VARCHAR(3),
    gift_wrap_amt       NUMERIC(18,2),
    shipping_amt        NUMERIC(18,2),
    tax_amt             NUMERIC(18,2),
    is_replacement      BOOLEAN,
    seller_id           VARCHAR(20),
    fulfillment_channel VARCHAR(8),
    _ingested_at        TIMESTAMP DEFAULT GETDATE()
);

INSERT INTO stg_us.order_items (
    order_item_id, order_id, asin, sku, product_title, browse_node_id,
    category_l1, quantity_ordered, item_price_amt, currency_code,
    gift_wrap_amt, shipping_amt, tax_amt, is_replacement,
    seller_id, fulfillment_channel
)
SELECT
    i.order_item_id, i.order_id, i.asin, i.sku, i.product_title, i.browse_node_id,
    i.category_l1, i.quantity_ordered, i.item_price_amt, i.currency_code,
    COALESCE(i.gift_wrap_amt, 0), COALESCE(i.shipping_amt, 0), COALESCE(i.tax_amt, 0),
    COALESCE(i.is_replacement, FALSE),
    i.seller_id, i.fulfillment_channel
FROM raw_us.order_items i
JOIN stg_us.orders o ON o.order_id = i.order_id;   -- hereda filtro US

-- ---------------------------------------------------------------------------
-- Cancellations
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stg_us.cancellations (
    cancel_id                   VARCHAR(24),
    order_item_id               VARCHAR(24),
    order_id                    VARCHAR(24),
    cancelled_at_utc            TIMESTAMP,
    cancelled_before_ship_flag  BOOLEAN,
    reason_code                 VARCHAR(40),
    reason_desc                 VARCHAR(200),
    cancelled_qty               INTEGER,
    actor                       VARCHAR(10),
    category_l1                 VARCHAR(80),
    seller_id                   VARCHAR(20),
    _ingested_at                TIMESTAMP DEFAULT GETDATE()
);

INSERT INTO stg_us.cancellations (
    cancel_id, order_item_id, order_id, cancelled_at_utc,
    cancelled_before_ship_flag, reason_code, reason_desc,
    cancelled_qty, actor, category_l1, seller_id
)
SELECT
    c.cancel_id, c.order_item_id, c.order_id, c.cancelled_at_utc,
    COALESCE(c.cancelled_before_ship_flag, TRUE),
    c.reason_code, c.reason_desc, c.cancelled_qty, c.actor,
    c.category_l1, c.seller_id
FROM raw_us.cancellations c
JOIN stg_us.orders o ON o.order_id = c.order_id;

-- ---------------------------------------------------------------------------
-- Returns, sellers, inventory, official flashes
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stg_us.returns (
    return_id         VARCHAR(24),
    order_item_id     VARCHAR(24),
    order_id          VARCHAR(24),
    returned_qty      INTEGER,
    return_reason     VARCHAR(40),
    returned_at_utc   TIMESTAMP,
    refund_amt_usd    NUMERIC(18,2),
    category_l1       VARCHAR(80),
    _ingested_at      TIMESTAMP DEFAULT GETDATE()
);

INSERT INTO stg_us.returns (
    return_id, order_item_id, order_id, returned_qty,
    return_reason, returned_at_utc, refund_amt_usd, category_l1
)
SELECT
    r.return_id, r.order_item_id, r.order_id, r.returned_qty,
    r.return_reason, r.returned_at_utc, r.refund_amt_usd, r.category_l1
FROM raw_us.returns r
JOIN stg_us.orders o ON o.order_id = r.order_id;

CREATE TABLE IF NOT EXISTS stg_us.sellers AS
SELECT seller_id, seller_name, seller_state_us, primary_category_l1,
       active_flag, pref_fulfillment, marketplace_id, country_code
FROM raw_us.sellers_pub
WHERE marketplace_id = 'ATVPDKIKX0DER';

CREATE TABLE IF NOT EXISTS stg_us.inventory_health AS
SELECT snapshot_date, seller_id, asin, fulfillment_channel,
       on_hand_units, oos_flag, aged_90_units, ipi_score, category_l1
FROM raw_us.inventory_health_daily
WHERE seller_id IN (SELECT seller_id FROM stg_us.sellers);

CREATE TABLE IF NOT EXISTS stg_us.fin_gmv_flash AS
SELECT fiscal_week, week_start_et, marketplace, category_l1, gmv_usd, orders, source
FROM raw_us.fin_gmv_flash
WHERE marketplace = 'US';

CREATE TABLE IF NOT EXISTS stg_us.sp_cancel_flash AS
SELECT fiscal_week, week_start_et, marketplace, category_l1,
       cancel_rate, cancelled_items, ordered_items, source
FROM raw_us.sp_cancel_flash
WHERE marketplace = 'US';
