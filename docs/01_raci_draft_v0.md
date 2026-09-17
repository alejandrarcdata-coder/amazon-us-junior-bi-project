# RACI — AMP-US-OPS-WKLY-2026Q3

Leyenda: **R** Responsible (hace el trabajo) · **A** Accountable (una sola A por fila) · **C** Consulted · **I** Informed.

Personas / roles (US-only):

| Código | Rol | Nombre (ejemplo operativo) | Equipo |
| --- | --- | --- | --- |
| SPN | Sponsor | Dana Okonkwo | Marketplace Operations US |
| BO | Business owner | Priya Shah | Category Operations US |
| BIL | Senior BI Lead | (este rol) | Retail BI US |
| JBI | Junior BI Analyst | (tú) | Retail BI US |
| DE | Data Engineer (warehouse) | Marcus Lee | Data Platform US |
| CM-HK | Category Manager Home & Kitchen | Elena Voss | Category Ops US |
| CM-SO | Category Manager Sports & Outdoors | Jamal Wright | Category Ops US |
| CM-TH | Category Manager Tools & Home Imp. | Mei Chen | Category Ops US |
| OA | Ops Analyst lead (pack Excel actual) | Chris Nguyen | Marketplace Ops US |
| FIN | Finance partner (definición GMV) | Rachel Cho | FP&A Marketplace US |
| SP | Seller Performance / A-to-Z | Diego Alvarez | Selling Partner Support US |
| PBI | Power BI service admin | Platform queue | BI Platform US |

---

## Matriz por entregable

| # | Entregable / decisión | SPN | BO | BIL | JBI | DE | CM* | OA | FIN | SP | PBI |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Aprobar brief, terna de categorías y kickoff | A | C | C | R | I | C | C | I | I | I |
| 2 | Charter, RAID, acceptance criteria | I | A | C | R | C | I | C | I | I | I |
| 3 | Acceso a fuentes US + catalog / DQ | I | C | C | R | A | I | C | C | C | I |
| 4 | Diccionario KPI (versión única) | I | A | C | R | C | C | C | C | C | I |
| 4b | Congelar fórmula GMV y cancel rate | I | A | C | R | I | C | C | C | C | I |
| 5 | Star schema (facts / dims) | I | I | A | R | C | I | I | I | I | I |
| 6 | SQL staging → cleaned → mart + tests | I | I | A | R | C | I | I | I | I | I |
| 7 | Reconciliation vs reporte oficial | I | A | C | R | C | I | C | C | I | I |
| 8 | Wireframe dashboard 2 páginas | I | A | C | R | I | C | C | I | I | I |
| 9 | Modelo PBI, DAX, RLS, calendario | I | I | A | R | I | I | I | I | I | C |
| 10 | QA, runbook, guía, handover | I | C | A | R | C | I | C | I | I | C |
| 11 | Insight memo + acciones 30 días | C | A | C | R | I | C | C | I | C | I |
| 12 | Readout 8 min liderazgo + cierre | A | C | C | R | I | I | I | I | I | I |
| — | Publicar workspace PBI + refresh diario | I | I | A | R | C | I | I | I | I | C |
| — | Retirar pack Excel semanal (go-live) | I | A | C | C | I | I | R | I | I | I |

\*CM = CM-HK + CM-SO + CM-TH (Consulted en las filas marcadas CM*).

---

## Reglas de RACI (no negociables en este proyecto)

1. Una sola **A** por fila. Si hay duda, la A de producto de datos es **BO**; la A técnica de modelo/SQL/PBI es **BIL**.
2. **JBI** es R de construcción en todos los entregables junior. No delega SQL ni DAX a un vendor.
3. **FIN** debe ser C antes de congelar GMV. Sin eso no hay PASO 7 válido.
4. **DE** es A de *acceso y contratos de fuente*; no de la lógica de negocio del mart.
5. Cambios de alcance después del PASO 2 solo con A de BO y C de BIL.

## Escalamiento

| Tema | Primer contacto | Escale a (48 h) |
| --- | --- | --- |
| Definición de métrica | BO + FIN | SPN |
| Acceso / SLA warehouse | DE | BIL → SPN |
| Discrepancia vs reporte oficial > umbral | JBI + OA | BO |
| RLS / publicación PBI | PBI admin + BIL | BO |
---
*Owner: Junior BI Analyst · Revisión: Senior BI Lead · Status: DRAFT*
