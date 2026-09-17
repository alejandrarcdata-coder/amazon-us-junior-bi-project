# PASO 1 — Correcciones validadas desde Lima

| Campo | Valor |
| --- | --- |
| Quién valida | Junior BI Analyst — Amazon GSC Lima (PE) |
| TZ junior | America/Lima (UTC−5). En sep-2026 ET está en EDT (UTC−4): Lima = ET − 1 h |
| Fecha validación | 09/14/2026 |
| Marketplace del proyecto | Sigue siendo **US only**. Lima es solo ubicación del analista, no un mercado. |
| Status | OFICIAL — Senior BI Lead eligió ALT Lima el 09/14/2026. Draft v0 archivado. |

## Qué cambió vs. draft v0

| Ítem | Draft v0 (inventado en brief) | Versión Lima (usar de aquí en adelante) | Por qué |
| --- | --- | --- | --- |
| Terna L1 | Home & Kitchen / Sports & Outdoors / **Tools & Home Improvement** | Home & Kitchen / Sports & Outdoors / **Pet Supplies** | Tools reporta a Hardlines Retail, no al watchlist 3P de Category Ops US. Pet Supplies está en el flash oficial y tiene peor cancel rate. |
| Reporte oficial GMV | “por confirmar en kickoff” | **US MP 3P GMV Weekly Flash** (`FIN.MP_US_3P_GMV_WKLY`) | Owner Finance Marketplace US; grano semana fiscal ET; publicado lunes 08:00 AM ET |
| Reporte oficial cancel | pack Excel de Ops | **US SP Cancellation Weekly** (`SP.US_CANCEL_WKLY`) + reason codes | Owner Seller Performance US; no usar el Excel como source of truth |
| Junior | sin sede | Camila Quispe Rojas — Junior BI, GSC Lima | Quien construye; R de todos los entregables de build |
| Sponsor | Dana Okonkwo | **Aisha Boateng**, Director, Marketplace Operations US | Nombre que Category Ops Lima tenía en el alias del DL |
| Business owner | Priya Shah | **Priya Shah** (sin cambio) | Confirmado en el DL `mp-catops-us@` |
| Finance | Rachel Cho | **Rachel Cho** (sin cambio) | Owner del flash GMV |
| DE | Marcus Lee | **Luis Huamán** (Data Platform, nodo Lima) + Marcus Lee (contrato fuente US) | Acceso lo pide Lima; el owner del warehouse US sigue en NA |
| OA pack Excel | Chris Nguyen | **Sofía Delgado**, Ops Analyst US (SEA) | Quien hoy arma el pack lunes AM ET |
| CM Pet Supplies | n/d (antes Tools = Mei Chen) | **Andre Williams**, Category Manager Pet Supplies US | Reemplaza a Mei Chen en este proyecto |
| Kickoff hora | 11:00–11:30 AM ET | 11:00–11:30 AM ET = **10:00–10:30 AM Lima** | Misma reunión, dos TZ |

## Decisiones que Lima deja escritas (equivalente a D1–D5 pre-kickoff)

| # | Decisión propuesta | Owner que debe ratificar |
| --- | --- | --- |
| D1 | Terna oficial = Home & Kitchen + Sports & Outdoors + Pet Supplies | Priya Shah |
| D2 | Reconciliación GMV = `FIN.MP_US_3P_GMV_WKLY` (no el Excel) | Rachel Cho |
| D3 | B2B / Amazon Business: **excluido de v1** salvo que FIN lo pida por escrito | Priya + Rachel |
| D4 | Ticket de acceso: `orders`, `order_items`, `cancellations`, `returns`, `sellers`, `inventory_health` US | Luis Huamán / Marcus Lee |
| D5 | Pack Excel se retira cuando el flash PBI reconcilie ≤ 1.0% vs FIN por 3 semanas fiscales | Priya + Sofía |
---
*No es PASO 2. Solo corrige el paquete de kickoff.*
