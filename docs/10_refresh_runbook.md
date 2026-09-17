# PASO 10 — Data refresh runbook

**Dataset:** amazon_us_ops_weekly  
**Schedule:** Daily 06:00 America/New_York  
**Job owner Lima:** Camila Quispe Rojas  
**Oncall ET:** Marketplace Ops US analyst (Sofía)

## Secuencia

1. 03:00 ET — warehouse raw_us.orders / items / cancels (Marcus).
2. 04:30 ET — SQL staging → cleaned → mart (`sql/01`–`03`) + `sql/04_dq_tests.sql`. Si T01–T09 fail_cnt > 0: **no refresh PBI**, avisar Slack `#mp-us-ops-bi`.
3. 06:00 ET — Power BI service refresh Import.
4. 06:20 ET — Camila (07:20 Lima en DST / 06:00 Lima en invierno) verifica card GMV vs flash (lunes el flash llega 08:00 ET: el martes es el primer check vs FIN).
5. Lunes 08:30 ET — actualizar `fin_gmv_flash` y `sp_cancel_flash`; segundo refresh.

## DST

El job se programa en **America/New_York**, nunca en Lima. En noviembre Lima = ET; en septiembre Lima = ET−1.

## Fallo

| Síntoma | Acción |
| --- | --- |
| Gateway / credential | PBI admin |
| DQ T07 CBS in GMV | rollback mart, no publicar |
| Delta vs flash > 1% top-3 | status Explained, no call leadership |
| Refresh > 30 min | abrir ticket DE-US |

## Contactos

Luis Huamán (accesos) → Marcus Lee (warehouse) → BIL.
