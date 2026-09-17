# Reconciliation workbook — mart vs reporte oficial

**Proyecto:** AMP-US-OPS-WKLY-2026Q3  
**Población:** 3P US, terna HK / SO / PET, no-B2B, USD, semana fiscal ET.  
**Importante:** el CSV de 32 order_items es QA de pipeline. Esta hoja usa el **flash sintético a escala** (mismo contrato que `FIN.MP_US_3P_GMV_WKLY`) vs un mart simulado post-SQL. No citar las 32 filas como GMV de liderazgo.

Tolerancias (PASO 2): GMV top-3 ≤ 1.0% · GMV cat ≤ 2.0% · Cancel top-3 ≤ 0.25 pp · Cancel cat ≤ 0.40 pp.

Status: Pass | Explained | Fail.

## GMV USD

| Semana | Week start ET | KPI | Grano | Fuente oficial | Oficial | Mart | Delta | % | Status | Nota |
| --- | --- | --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- |
| 2026W28 | 2026-07-05 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $165.76M | $0.66M | +0.40% | Pass |  |
| 2026W28 | 2026-07-05 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $85.68M | -$0.52M | -0.60% | Pass |  |
| 2026W28 | 2026-07-05 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $55.39M | $0.49M | +0.90% | Pass |  |
| 2026W28 | 2026-07-05 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $306.84M | $0.64M | +0.21% | Pass |  |
| 2026W29 | 2026-07-12 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $164.60M | -$0.50M | -0.30% | Pass |  |
| 2026W29 | 2026-07-12 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $86.37M | $0.17M | +0.20% | Pass |  |
| 2026W29 | 2026-07-12 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $55.50M | $0.60M | +1.10% | Pass |  |
| 2026W29 | 2026-07-12 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $306.48M | $0.28M | +0.09% | Pass |  |
| 2026W30 | 2026-07-19 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $166.26M | $1.16M | +0.70% | Pass |  |
| 2026W30 | 2026-07-19 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $85.86M | -$0.34M | -0.40% | Pass |  |
| 2026W30 | 2026-07-19 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $55.34M | $0.44M | +0.80% | Pass |  |
| 2026W30 | 2026-07-19 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $307.45M | $1.25M | +0.41% | Pass |  |
| 2026W31 | 2026-07-26 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $164.77M | -$0.33M | -0.20% | Pass |  |
| 2026W31 | 2026-07-26 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $86.63M | $0.43M | +0.50% | Pass |  |
| 2026W31 | 2026-07-26 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $55.72M | $0.82M | +1.50% | Pass |  |
| 2026W31 | 2026-07-26 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $307.12M | $0.92M | +0.30% | Pass |  |
| 2026W32 | 2026-08-02 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $165.27M | $0.17M | +0.10% | Pass |  |
| 2026W32 | 2026-08-02 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $86.11M | -$0.09M | -0.10% | Pass |  |
| 2026W32 | 2026-08-02 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $55.89M | $0.99M | +1.80% | Pass |  |
| 2026W32 | 2026-08-02 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $307.27M | $1.07M | +0.35% | Pass |  |
| 2026W33 | 2026-08-09 | GMV USD | Home & Kitchen | FIN.MP_US_3P_GMV_WKLY | $165.10M | $163.78M | -$1.32M | -0.80% | Pass |  |
| 2026W33 | 2026-08-09 | GMV USD | Sports & Outdoors | FIN.MP_US_3P_GMV_WKLY | $86.20M | $86.46M | $0.26M | +0.30% | Pass |  |
| 2026W33 | 2026-08-09 | GMV USD | Pet Supplies | FIN.MP_US_3P_GMV_WKLY | $54.90M | $56.22M | $1.32M | +2.40% | Explained | PET FBM CBS timing vs flash payment-week; ticket FIN-441 |
| 2026W33 | 2026-08-09 | GMV USD | Top-3 | FIN.MP_US_3P_GMV_WKLY | $306.20M | $306.46M | $0.26M | +0.08% | Pass |  |

## Cancel rate

| Semana | Week start ET | KPI | Grano | Fuente oficial | Oficial | Mart | Delta pp | Status | Nota |
| --- | --- | --- | --- | --- | ---: | ---: | ---: | --- | --- |
| 2026W28 | 2026-07-05 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 4.98% | +0.08 | Pass |  |
| 2026W28 | 2026-07-05 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.35% | -0.05 | Pass |  |
| 2026W28 | 2026-07-05 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 5.72% | +0.12 | Pass |  |
| 2026W28 | 2026-07-05 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 5.00% | +0.06 | Pass |  |
| 2026W29 | 2026-07-12 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 4.94% | +0.04 | Pass |  |
| 2026W29 | 2026-07-12 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.50% | +0.10 | Pass |  |
| 2026W29 | 2026-07-12 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 5.78% | +0.18 | Pass |  |
| 2026W29 | 2026-07-12 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 5.03% | +0.09 | Pass |  |
| 2026W30 | 2026-07-19 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 4.84% | -0.06 | Pass |  |
| 2026W30 | 2026-07-19 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.47% | +0.07 | Pass |  |
| 2026W30 | 2026-07-19 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 5.80% | +0.20 | Pass |  |
| 2026W30 | 2026-07-19 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 4.98% | +0.04 | Pass |  |
| 2026W31 | 2026-07-26 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 5.01% | +0.11 | Pass |  |
| 2026W31 | 2026-07-26 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.38% | -0.02 | Pass |  |
| 2026W31 | 2026-07-26 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 5.82% | +0.22 | Pass |  |
| 2026W31 | 2026-07-26 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 5.05% | +0.10 | Pass |  |
| 2026W32 | 2026-08-02 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 4.99% | +0.09 | Pass |  |
| 2026W32 | 2026-08-02 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.46% | +0.06 | Pass |  |
| 2026W32 | 2026-08-02 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 5.88% | +0.28 | Pass |  |
| 2026W32 | 2026-08-02 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 5.07% | +0.13 | Pass |  |
| 2026W33 | 2026-08-09 | Cancel rate | Home & Kitchen | SP.US_CANCEL_WKLY | 4.90% | 5.04% | +0.14 | Pass |  |
| 2026W33 | 2026-08-09 | Cancel rate | Sports & Outdoors | SP.US_CANCEL_WKLY | 4.40% | 4.48% | +0.08 | Pass |  |
| 2026W33 | 2026-08-09 | Cancel rate | Pet Supplies | SP.US_CANCEL_WKLY | 5.60% | 6.05% | +0.45 | Explained | SP flash sin reason SHIP_LATE_RISK; mart sí los cuenta |
| 2026W33 | 2026-08-09 | Cancel rate | Top-3 | SP.US_CANCEL_WKLY | 4.94% | 5.14% | +0.20 | Pass |  |

## Resumen go / no-go

| Control | Resultado |
| --- | --- |
| GMV top-3 últimas 3 semanas | Pass (dentro de 1.0%) |
| GMV Pet Supplies W33 | Explained (2.4% > 2.0%) — CBS timing vs payment-week FIN-441 |
| Cancel rate top-3 | Pass salvo si se pondera solo PET |
| Cancel Pet W33 | Explained (0.45 pp) — SHIP_LATE_RISK en mart, no en flash agregado |
| Sample 32 items vs flash $165M | N/A — no se reconcilia extracto de diseño contra flash |
| Go-live métricas | **Condicional**: cerrar FIN-441 y mapa reason con Diego |

## Puentes conocidos (bridge to flash)

| Gap | Dirección | Acción |
| --- | --- | --- |
| Gift wrap / shipping / tax | Mart más bajo si alguien los suma | Spec los excluye; test T08 |
| CBS week (order date vs cancel date) | Mart GMV más bajo en la semana de order | Atribución = order_datetime_et |
| Payment-week Finance | Flash puede caer 1 semana después | Ticket FIN-441 |
| Reason no mapeado | Mart cancel > flash | dim_cancellation_reason + Diego |

## Sign-off

| Rol | Nombre | Status | Fecha |
| --- | --- | --- | --- |
| FIN | Rachel Cho | Pendiente W33 PET | |
| SP | Diego Alvarez | Pendiente reason map | |
| BO | Priya Shah | No go-live hasta Explained cerrado o aceptado | |
| JBI | Camila Quispe Rojas | Workbook listo | 09/14/2026 |
