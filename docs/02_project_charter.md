# Project charter junior — AMP-US-OPS-WKLY-2026Q3

**Status:** OFICIAL sobre baseline PASO 1 Lima · Fecha: 09/14/2026  
**Accountable:** Priya Shah (BO) · **Responsible (build):** Camila Quispe Rojas (GSC Lima)

---

## 1. Propósito

Dar a Marketplace Operations US una vista semanal **única y reconciliada** de GMV y cancelaciones en tres categorías del watchlist 3P, con causa raíz operativa (seller, reason, FBA/FBM) y un paquete de 3–5 acciones a 30 días. Retirar el pack Excel de ~6 h/semana cuando el mart reconcilie contra Finance.

## 2. In / out de alcance

| In (v1) | Out (v1) |
| --- | --- |
| Marketplace US only (`ATVPDKIKX0DER` / `country_code = 'US'`) | PE, CA, MX, RoW |
| Categorías L1: Home & Kitchen, Sports & Outdoors, Pet Supplies | Tools & Home Improvement y resto del catálogo |
| 3P seller-fulfilled + FBA (MFN + AFN) | 1P Retail puro (Vendor Central) |
| Datamart estrella pequeño + 2 páginas Power BI | ML, forecast, Tableau, Looker, app |
| GMV, orders, units, AOV, cancel rate, late ship, A-to-Z, return rate, active sellers | Ads ROI como KPI primario (traffic/ads solo contexto opcional) |
| Semana fiscal Amazon domingo–sábado ET, USD | Semana ISO / moneda local |
| RLS Ops nacional vs Category Manager | RLS por ASIN o por seller individual |
| Lookback 13 semanas fiscales + detalle W22–W33 2026 | Historia > 18 meses |
| B2B / Amazon Business | **Excluido v1** (decisión PASO 1) |
| Gift wrap / shipping credits | **Excluidos del GMV** (fee, no merchandise) |
| Cancelled-before-ship (CBS) | CBS **fuera del GMV**; **dentro** del numerador de cancel rate |

## 3. Objetivos medibles (junior)

| # | Objetivo | Métrica de éxito |
| --- | --- | --- |
| O1 | Una versión de la verdad para GMV y cancel rate | Spec de 1 página firmada por BO + FIN |
| O2 | Mart US publicable | SQL staging→cleaned→mart + tests DQ en verde |
| O3 | Reconciliación vs flash Finance | \|delta GMV\| ≤ 1.0% a nivel top-3 semanal en ≥ 3 semanas fiscales |
| O4 | Dashboard usable en 1 pantalla ejecutiva | Página Ejecutiva + Operativa en servicio PBI, refresh 06:00 ET |
| O5 | Sustituir Excel | Sofía deja de mandar el pack cuando O3 se cumpla 3 semanas seguidas |

## 4. No-objetivos

- No pronosticamos GMV.
- No negociamos con sellers (eso es CM / SP).
- No cambiamos policy de cancelación; solo visibilidad y recomendaciones.

## 5. Timeline (Lima construye / ET decide)

| Hito | Fecha objetivo (ET) | Owner |
| --- | --- | --- |
| PASO 1 brief oficial | 09/14/2026 | Camila |
| Kickoff 30 min | 09/15/2026 11:00 ET / 10:00 Lima | Priya |
| Charter + RAID + DoD (este doc) | 09/16/2026 | Camila / Priya A |
| Inventario fuentes + samples | 09/18/2026 | Camila + Luis + Marcus |
| KPI dictionary freeze | 09/22/2026 | Priya A / Rachel C |
| Star + SQL mart | 09/29/2026 | Camila / BIL A |
| Reconciliation vs flash | 10/02/2026 | Camila + Rachel |
| Wireframe + DAX + RLS | 10/09/2026 | Camila |
| QA + handover | 10/14/2026 | Camila / BIL |
| Insights 30 días + readout 8 min | 10/16/2026 | Camila / Aisha A |

## 6. Organización y RACI corto

Ver `docs/01_raci.md`. Resumen: Priya A de producto de datos; BIL A de modelo/SQL/PBI; Camila R de build; Marcus A de contrato de fuente; Luis R de tickets de acceso; Rachel C de GMV.

## 7. Dependencias

1. Acceso lectura a `orders`, `order_items`, `cancellations`, `returns`, `sellers`, `inventory_health` filtrable a US.
2. Extracto o vista del flash `FIN.MP_US_3P_GMV_WKLY` (13 semanas).
3. Extracto `SP.US_CANCEL_WKLY` + catálogo de reason codes.
4. Workspace Power BI US + capacidad de refresh programado.
5. Lista oficial browse node L1 ↔ category_sk (la da Andre / Elena / Jamal).

## 8. Presupuesto / esfuerzo junior (indicativo)

| Bloque | Horas Lima (est.) |
| --- | --- |
| Alcance + KPI + modelo | 16 |
| SQL + DQ + reconciliación | 28 |
| Power BI + RLS + QA | 24 |
| Insights + readout + docs | 12 |
| **Total v1** | **~80 h** (~4–5 semanas calendario, no full-time) |

Excel solo QA. Sin vendor.

## 9. Definition of done del proyecto (preview; detalle en 02_acceptance_criteria.md)

- Filtro US + USD + ET + terna L1 aplicados en todo el linaje.
- GMV y cancel rate coinciden con el diccionario (una sola fórmula).
- Delta vs `FIN.MP_US_3P_GMV_WKLY` ≤ 1.0% top-3 semanal o excepción documentada.
- PBI: 2 páginas, slicers, RLS dos roles, formato USD / % / mm/dd/yyyy.
- Runbook de refresh y guía de 1 página en Lima→ET.
- Memo con 3–5 acciones ownerizadas a 30 días.
- Readout 8 min entregado.

## 10. Aprobación

| Rol | Nombre | Firma / fecha |
| --- | --- | --- |
| BO | Priya Shah | pendiente kickoff |
| FIN (GMV) | Rachel Cho | pendiente kickoff |
| BIL | Senior BI Lead | 09/14/2026 |
| JBI | Camila Quispe Rojas | 09/14/2026 |
