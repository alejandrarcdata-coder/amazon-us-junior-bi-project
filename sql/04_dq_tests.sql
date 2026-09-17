-- =============================================================================
-- 04_dq_tests.sql
-- Tests de calidad post-mart. Un test "PASS" = la query devuelve 0 filas.
-- Correr después de 03_mart.sql.
-- =============================================================================

-- T01 blocker: filas no-US en facts
SELECT 'T01_non_us_orders' AS test_id, COUNT(*) AS fail_cnt
FROM cleaned_us.orders
WHERE country_code <> 'US' OR marketplace_id <> 'ATVPDKIKX0DER';

-- T02 blocker: moneda no USD
SELECT 'T02_non_usd_items' AS test_id, COUNT(*) AS fail_cnt
FROM cleaned_us.order_items
WHERE currency_code <> 'USD';

-- T03 blocker: B2B filtrado
SELECT 'T03_b2b_leaked' AS test_id, COUNT(*) AS fail_cnt
FROM cleaned_us.orders
WHERE is_business_order = TRUE;

-- T04 blocker: categoría fuera de terna
SELECT 'T04_bad_category' AS test_id, COUNT(*) AS fail_cnt
FROM mart_us.fct_order_items_us f
JOIN mart_us.dim_category c ON c.category_sk = f.category_sk
WHERE c.category_l1 NOT IN ('Home & Kitchen','Sports & Outdoors','Pet Supplies');

-- T05 duplicados order_item
SELECT 'T05_dup_order_item' AS test_id, COUNT(*) AS fail_cnt
FROM (
    SELECT order_item_id
    FROM mart_us.fct_order_items_us
    GROUP BY order_item_id
    HAVING COUNT(*) > 1
) d;

-- T06 GMV materializado vs fórmula
SELECT 'T06_gmv_formula' AS test_id, COUNT(*) AS fail_cnt
FROM mart_us.fct_order_items_us
WHERE gmv_eligible_flag = TRUE
  AND gmv_usd <> item_price_amt * quantity_ordered
   OR (gmv_eligible_flag = FALSE AND gmv_usd <> 0);

-- T07 CBS no puede ser GMV eligible
SELECT 'T07_cbs_in_gmv' AS test_id, COUNT(*) AS fail_cnt
FROM mart_us.fct_order_items_us
WHERE cancelled_before_ship_flag = TRUE
  AND gmv_eligible_flag = TRUE;

-- T08 gift wrap no se coló en gmv_usd
SELECT 'T08_giftwrap_in_gmv' AS test_id, COUNT(*) AS fail_cnt
FROM mart_us.fct_order_items_us
WHERE gmv_usd = (item_price_amt * quantity_ordered) + gift_wrap_amt
  AND gift_wrap_amt > 0;

-- T09 cancel huérfano
SELECT 'T09_orphan_cancel' AS test_id, COUNT(*) AS fail_cnt
FROM mart_us.fct_cancellations_us k
LEFT JOIN mart_us.fct_order_items_us f ON f.order_item_id = k.order_item_id
WHERE f.order_item_id IS NULL;

-- T10 counts staging vs cleaned vs mart (checksum)
SELECT 'T10_item_count_drop' AS test_id,
       (SELECT COUNT(*) FROM stg_us.order_items) AS stg_cnt,
       (SELECT COUNT(*) FROM cleaned_us.order_items) AS cleaned_cnt,
       (SELECT COUNT(*) FROM mart_us.fct_order_items_us) AS mart_cnt;

-- T11 no PII columns in mart seller
SELECT 'T11_pii_guard' AS test_id, COUNT(*) AS fail_cnt
FROM information_schema.columns
WHERE table_schema = 'mart_us'
  AND table_name = 'dim_seller'
  AND column_name IN ('email','phone','bank_account','address1','ssn');

-- T12 flash categorías
SELECT 'T12_flash_cat' AS test_id, COUNT(*) AS fail_cnt
FROM cleaned_us.fin_gmv_flash
WHERE category_l1 NOT IN ('Home & Kitchen','Sports & Outdoors','Pet Supplies');
