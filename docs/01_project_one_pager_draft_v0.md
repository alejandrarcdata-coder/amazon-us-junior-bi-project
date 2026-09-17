# One-pager — US Top-3 Category GMV & Cancellation Recovery

| Campo | Valor |
| --- | --- |
| Project ID | AMP-US-OPS-WKLY-2026Q3 |
| Nombre | US Top-3 Category GMV & Cancellation Recovery — Weekly Visibility |
| Organización | Amazon Marketplace Operations — United States |
| Marketplace | US only (`marketplace_id` US / `country_code = 'US'`). Excluye CA, MX y resto del mundo. |
| Moneda / TZ | USD / America/New_York |
| Semana | Semana fiscal Amazon: domingo 00:00 ET → sábado 23:59:59 ET |
| Sponsor | Dana Okonkwo, Director, Marketplace Operations US |
| Business owner | Priya Shah, Senior Manager, Category Operations US |
| BI Lead | Senior BI Lead, Amazon Retail US |
| Analyst (build) | Junior Business Intelligence Analyst |
| Fecha brief | 09/14/2026 |
| Horizonte | Kickoff semana del 09/14/2026 · readout liderazgo 8 min en ~4–5 semanas |
| Clasificación | Internal — Business Confidential. Cifras de ejemplo son sintéticas. |

---

## 1. Problema (una frase)

En tres categorías top del marketplace US, GMV semanal cayó y la tasa de cancelación subió; Operations dedica ~6 h/semana a un pack Excel manual y liderazgo no tiene una vista semanal confiable para causa raíz ni un plan de 30 días.

## 2. Evidencia de disparo (extracto sintético US-only, no dato de producción)

Ventana: 6 semanas fiscales Amazon W28–W33 2026 vs. baseline W22–W27 2026.  
Filtro: `country_code = 'US'`, `currency_code = 'USD'`, órdenes 3P marketplace.

| Categoría US (browse node L1) | GMV W22–W27 avg / sem | GMV W28–W33 avg / sem | Δ GMV | Cancel rate W22–W27 | Cancel rate W28–W33 | Δ pp | Horas Excel / sem (Ops) |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Home & Kitchen | $186.4M | $165.1M | −11.4% | 3.2% | 4.9% | +1.7 | 2.5 |
| Sports & Outdoors | $94.8M | $86.2M | −9.1% | 2.9% | 4.4% | +1.5 | 2.0 |
| Tools & Home Improvement | $79.1M | $74.0M | −6.4% | 3.4% | 5.1% | +1.7 | 1.5 |
| **Top-3 combinado** | **$360.3M** | **$325.3M** | **−9.7%** | **3.15%** | **4.78%** | **+1.63** | **~6.0** |

Señal adicional (mismo filtro, no reconciliada aún): late shipment rate +0.8 pp; A-to-Z claim rate +0.12 pp; mix FBM subió ~3 pp en Home & Kitchen.

## 3. Qué pedimos construir (alcance junior)

1. Datamart US pequeño en warehouse estilo Redshift/Snowflake, modelo estrella.
2. Dashboard Power BI (Desktop + servicio) con **2 páginas**: Ejecutiva (1 pantalla) y Operativa (drill categoría / seller / reason / FBA vs FBM).
3. Documentación: diccionario de KPIs (una versión de la verdad), QA, runbook, guía de usuario.
4. Memo de insights + 3–5 acciones priorizadas a 30 días.
5. Readout de 8 minutos a liderazgo US.

Fuera de alcance de este brief: CA/MX/RoW, ML, Tableau, Looker, app mobile, self-serve ad-hoc ilimitado, rediseño de Seller Central.

## 4. KPIs que existirán (nombres; fórmulas en PASO 4)

GMV USD · # Orders · Units · AOV · Cancel rate · Late shipment rate · A-to-Z claim rate · Return rate · Active sellers.

Toda métrica llevará: fórmula, grano, filtros US, owner, fuente, excepciones (devoluciones, cancelled-before-ship, gift wrap, B2B).

## 5. Usuarios y decisión que habilita

| Audiencia | Decisión semanal |
| --- | --- |
| Director / Sr. Manager Ops US | ¿El GMV top-3 se estabilizó? ¿Dónde poner capacidad las próximas 4 semanas? |
| Category Manager (3 nodos) | ¿Qué sellers, reasons y fulfillment explican la cancelación? |
| Ops Analysts US | Dejar el pack Excel; usar el dashboard + export controlado para QA. |

## 6. Stack y guardrails

- SQL ANSI cercano a Redshift → staging → cleaned → mart.
- Power BI Desktop + servicio. Excel solo QA y plantillas.
- RLS: Ops nacional US vs Category Manager (solo su categoría).
- Formato: USD, %, fechas `mm/dd/yyyy`, semana fiscal domingo–sábado ET.

## 7. Pregunta de kickoff que debe quedar cerrada

¿Confirmamos Home & Kitchen, Sports & Outdoors y Tools & Home Improvement como las 3 categorías, o liderazgo tiene otra terna oficial (ASIN browse node L1)?
---
*Owner del documento: Junior BI Analyst · Revisión: Senior BI Lead · Status: DRAFT — pendiente OK kickoff*
