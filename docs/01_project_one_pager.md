# One-pager — US Top-3 Category GMV & Cancellation Recovery

**Status:** OFICIAL (decisión Senior BI Lead, 09/14/2026). Base = ALT Lima. Draft v0 archivado en `docs/01_*_draft_v0.md`.

| Campo | Valor |
| --- | --- |
| Project ID | AMP-US-OPS-WKLY-2026Q3 |
| Nombre | US Top-3 Category GMV & Cancellation Recovery — Weekly Visibility |
| Organización | Amazon Marketplace Operations — United States |
| Hub del analista | GSC Lima, Perú (`America/Lima`). El marketplace analizado **no** es PE. |
| Marketplace | US only (`marketplace_id` US / `country_code = 'US'`). Excluye PE, CA, MX y RoW. |
| Moneda / TZ datos | USD / America/New_York |
| Semana | Semana fiscal Amazon: domingo 00:00 ET → sábado 23:59:59 ET |
| Sponsor | Aisha Boateng, Director, Marketplace Operations US |
| Business owner | Priya Shah, Senior Manager, Category Operations US |
| BI Lead | Senior BI Lead, Amazon Retail US |
| Analyst (build) | Camila Quispe Rojas, Junior BI Analyst — GSC Lima |
| Finance owner (GMV) | Rachel Cho, FP&A Marketplace US |
| Fecha brief | 09/14/2026 (oficializado desde Lima) |
| Horizonte | Kickoff 09/15/2026 11:00 AM ET / 10:00 AM Lima · readout ~4–5 semanas |
| Clasificación | Internal — Business Confidential. Cifras de ejemplo son sintéticas. |
| Reporte oficial GMV | US MP 3P GMV Weekly Flash · `FIN.MP_US_3P_GMV_WKLY` · lun 08:00 AM ET |
| Reporte oficial cancel | US SP Cancellation Weekly · `SP.US_CANCEL_WKLY` |

---

## 1. Problema (una frase)

En tres categorías del watchlist 3P US (Home & Kitchen, Sports & Outdoors, Pet Supplies) cayó el GMV semanal y subió la cancelación; Ops US sigue armando un pack Excel ~6 h/semana y liderazgo no tiene una vista semanal reconciliada contra el flash de Finance.

## 2. Evidencia de disparo (sintético US-only)

Ventana: W28–W33 2026 vs baseline W22–W27 2026.  
Filtro: `country_code = 'US'`, `currency_code = 'USD'`, 3P marketplace, **B2B excluido v1**.

| Categoría US (browse node L1) | GMV W22–W27 avg / sem | GMV W28–W33 avg / sem | Δ GMV | Cancel rate W22–W27 | Cancel rate W28–W33 | Δ pp | Horas Excel / sem (Ops) |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Home & Kitchen | $186.4M | $165.1M | −11.4% | 3.2% | 4.9% | +1.7 | 2.5 |
| Sports & Outdoors | $94.8M | $86.2M | −9.1% | 2.9% | 4.4% | +1.5 | 2.0 |
| Pet Supplies | $61.7M | $54.9M | −11.0% | 3.8% | 5.6% | +1.8 | 1.5 |
| **Top-3 combinado** | **$342.9M** | **$306.2M** | **−10.7%** | **3.22%** | **4.87%** | **+1.65** | **~6.0** |

Señal adicional (no reconciliada aún vs flash): late shipment rate +0.9 pp en Pet Supplies FBM; A-to-Z claim rate +0.14 pp; mix FBM +4 pp en Pet Supplies.

Tools & Home Improvement **fuera de alcance**: no está en el watchlist 3P de Category Ops US (Hardlines Retail).

## 3. Qué pedimos construir (alcance junior)

1. Datamart US pequeño (Redshift/Snowflake, estrella).
2. Power BI Desktop + servicio: página Ejecutiva + página Operativa.
3. Documentación KPI / QA / runbook / guía.
4. Memo 30 días + readout 8 min.

Fuera de alcance: PE/CA/MX/RoW, Tools & Home Improvement, B2B en v1, ML, Tableau, Looker.

## 4. KPIs (nombres; fórmulas en PASO 4)

GMV USD · # Orders · Units · AOV · Cancel rate · Late shipment rate · A-to-Z claim rate · Return rate · Active sellers.

Reconciliación GMV: mart vs `FIN.MP_US_3P_GMV_WKLY` (umbral se fija en PASO 7; hipótesis Lima ≤ 1.0%).

## 5. Usuarios y decisión que habilita

| Audiencia | Sede | Decisión semanal |
| --- | --- | --- |
| Aisha / Priya | US | ¿El GMV top-3 se estabilizó? ¿Dónde poner capacidad 4 semanas? |
| CMs (Elena, Jamal, Andre) | US | ¿Qué sellers / reasons / FBA-FBM explican la cancelación? |
| Sofía Delgado | SEA | Dejar el pack Excel cuando el PBI reconcilie 3 semanas. |
| Camila (build) + Luis (accesos) | Lima | Publicar mart + workspace; guardar linaje. |

## 6. Stack y guardrails

- SQL ANSI cercano a Redshift. Power BI. Excel solo QA.
- RLS: Ops nacional US vs Category Manager (su L1).
- Formato: USD, %, fechas `mm/dd/yyyy`, semana fiscal ET.
- El analista trabaja en Lima; **todos los timestamps del modelo son ET**.

## 7. Decisiones ya cerradas en PASO 1

1. Terna oficial = Home & Kitchen + Sports & Outdoors + Pet Supplies.
2. Fuente oficial GMV = `FIN.MP_US_3P_GMV_WKLY`.
3. Fuente oficial cancel = `SP.US_CANCEL_WKLY`.
4. B2B / Amazon Business excluido de v1.
5. Junior build = Camila Quispe Rojas (GSC Lima). Sponsor = Aisha Boateng.
---
*Owner: Camila Quispe Rojas (GSC Lima) · Revisión: Senior BI Lead · Status: OFICIAL*
