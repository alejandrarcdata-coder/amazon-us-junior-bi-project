# RACI — AMP-US-OPS-WKLY-2026Q3

**Status:** OFICIAL (base ALT Lima, 09/14/2026).

Leyenda: **R** Responsible · **A** Accountable (una sola A por fila) · **C** Consulted · **I** Informed.

| Código | Rol | Nombre | Sede / equipo |
| --- | --- | --- | --- |
| SPN | Sponsor | Aisha Boateng | SEA / Marketplace Operations US |
| BO | Business owner | Priya Shah | SEA / Category Operations US |
| BIL | Senior BI Lead | (este rol) | Retail BI US |
| JBI | Junior BI Analyst | Camila Quispe Rojas | **GSC Lima** / Retail BI |
| DE-US | Data Engineer warehouse US | Marcus Lee | Data Platform US |
| DE-LIM | Data Engineer accesos | Luis Huamán | **GSC Lima** / Data Platform |
| CM-HK | Category Manager Home & Kitchen | Elena Voss | Category Ops US |
| CM-SO | Category Manager Sports & Outdoors | Jamal Wright | Category Ops US |
| CM-PET | Category Manager Pet Supplies | Andre Williams | Category Ops US |
| OA | Ops Analyst lead (pack Excel) | Sofía Delgado | Marketplace Ops US (SEA) |
| FIN | Finance partner (flash GMV) | Rachel Cho | FP&A Marketplace US |
| SP | Seller Performance / A-to-Z | Diego Alvarez | Selling Partner Support US |
| PBI | Power BI service admin | Platform queue | BI Platform US |

Mei Chen (Tools) **fuera del RACI**. Dana Okonkwo y Chris Nguyen quedan solo en `docs/01_*_draft_v0.md`.

---

## Matriz por entregable

| # | Entregable / decisión | SPN | BO | BIL | JBI | DE-US | DE-LIM | CM* | OA | FIN | SP |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Aprobar brief, terna Pet Supplies y kickoff | A | C | C | R | I | I | C | C | I | I |
| 2 | Charter, RAID, acceptance criteria | I | A | C | R | C | C | I | C | I | I |
| 3 | Acceso fuentes US + catalog / DQ | I | C | C | R | A | R | I | C | C | C |
| 4 | Diccionario KPI (versión única) | I | A | C | R | C | I | C | C | C | C |
| 4b | Congelar GMV (= flash FIN) y cancel rate | I | A | C | R | I | I | C | C | C | C |
| 5 | Star schema | I | I | A | R | C | I | I | I | I | I |
| 6 | SQL staging → mart + tests | I | I | A | R | C | C | I | I | I | I |
| 7 | Reconciliation vs `FIN.MP_US_3P_GMV_WKLY` | I | A | C | R | C | I | I | C | C | I |
| 8 | Wireframe dashboard 2 páginas | I | A | C | R | I | I | C | C | I | I |
| 9 | Modelo PBI, DAX, RLS, calendario ET | I | I | A | R | I | I | I | I | I | I |
| 10 | QA, runbook Lima→ET, handover | I | C | A | R | C | C | I | C | I | I |
| 11 | Insight memo + acciones 30 días | C | A | C | R | I | I | C | C | I | C |
| 12 | Readout 8 min liderazgo US + cierre | A | C | C | R | I | I | I | I | I | I |
| — | Publicar workspace + refresh 06:00 ET | I | I | A | R | C | C | I | I | I | I |
| — | Retirar pack Excel (go-live) | I | A | C | C | I | I | I | R | I | I |

\*CM = Elena + Jamal + Andre.

## Escalamiento (huso Lima)

| Tema | Primer contacto | Escale a (48 h ET) |
| --- | --- | --- |
| Definición de métrica | Priya + Rachel | Aisha |
| Acceso warehouse | Luis Huamán → Marcus Lee | BIL → Aisha |
| Delta vs flash FIN > umbral | Camila + Sofía | Priya |
| RLS / publicación PBI | PBI admin + BIL | Priya |
---
*Owner: Camila Quispe Rojas · Revisión: Senior BI Lead · Status: OFICIAL*
