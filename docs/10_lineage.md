# PASO 10 — Linaje corto

```
raw_us.orders / order_items / cancellations / returns / sellers_pub
        │  filtro marketplace_id = ATVPDKIKX0DER
        ▼
stg_us.*                          sql/01_staging.sql
        │  ET · USD · terna · no B2B · gmv_eligible_flag
        ▼
cleaned_us.*                      sql/02_cleaned.sql
        │
        ▼
mart_us.fct_order_items_us
mart_us.fct_cancellations_us
mart_us.dim_*                     sql/03_mart.sql
        │
        ├─ Power BI Import  →  páginas Ejecutiva / Operativa
        │     medidas: powerbi/09_measures.dax
        │     RLS: Ops_US_National | CM_Category
        │
        └─ PASO 7 reconcil  ←  FIN.MP_US_3P_GMV_WKLY
                               SP.US_CANCEL_WKLY
```

GMV no pasa por Excel. Gift wrap / shipping / tax mueren en cleaned (columnas quedan para audit, no en medidas).
