# Metric spec — GMV USD (1 página)

| Campo | Valor |
| --- | --- |
| Nombre | GMV USD |
| ID | KPI-GMV-US-3P |
| Versión | 1.0 — 09/14/2026 |
| Accountable | Priya Shah |
| Steward Finance | Rachel Cho |
| Builder | Camila Quispe Rojas |
| Fuente mart | `mart_us.fct_order_items_us` |
| Fuente oficial | `FIN.MP_US_3P_GMV_WKLY` |
| Unidad | USD |
| Formato PBI | `$#,##0;($#,##0)` |
| Grano nativo | 1 fila = 1 `order_item_id` |
| Atribución temporal | `order_datetime_et` → `fiscal_week` domingo–sábado |
| Marketplace | US only (`ATVPDKIKX0DER`) |

## Fórmula

```
GMV_USD = SUM( item_price_amt * quantity_ordered )
          FILTER items_elegibles_gmv
```

No hay FX. No hay redondeo intermedio distinto de NUMERIC(18,2).

## Inclusiones

- 3P FBA (AFN) y FBM (MFN).
- Home & Kitchen, Sports & Outdoors, Pet Supplies.
- Pedidos buyer pagados con item_price en USD.
- Órdenes que luego se cancelan **después** de ship (quedan en GMV; el refund va a returns).

## Exclusiones (explícitas)

| Excepción | Tratamiento | Razón |
| --- | --- | --- |
| Cancelled before ship (CBS) | Fuera del GMV | El flash FIN no reconoce mercancía no comprometida |
| Devoluciones | **No restan** GMV | Return rate es KPI aparte. Evita doble neteo |
| Gift wrap | Fuera | Es fee, no merchandise |
| Shipping | Fuera | Es fee |
| Tax / VAT-like | Fuera | Flash FIN es pre-tax merchandise |
| B2B / Amazon Business | Fuera v1 | Decisión PASO 1 |
| Replacement / reship | Fuera | Evita doble conteo |
| 1P Retail | Fuera | Otro P&L |
| CA / MX / PE / RoW | Fuera | Alcance |
| Tools & Home Improvement | Fuera | Fuera de terna |

## Controles

- Checksum semanal vs flash: tolerancia top-3 ≤ 1.0%; cat ≤ 2.0%.
- Test: `SUM(gift_wrap_amt)` no entra en medida DAX `GMV_USD`.
- Test: items con `cancelled_before_ship_flag = true` tienen `gmv_eligible_flag = false`.

## DAX de referencia (se implementa en PASO 9)

```
GMV_USD = SUMX( FILTER(fct_order_items_us, fct_order_items_us[gmv_eligible_flag] = TRUE()),
                fct_order_items_us[item_price_amt] * fct_order_items_us[quantity_ordered] )
```

## Ejemplo numérico (sample, no producción)

Item `OI-50001`: qty 2 × $29.99 = $59.98. Gift wrap $4.99 **ignorado**. Si CBS → GMV $0.
