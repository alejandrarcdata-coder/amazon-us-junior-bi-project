# Amazon US Marketplace — Junior BI Analyst Project

End-to-end junior Business Intelligence project for **Amazon Marketplace Operations (US-only)**.

Stack: **SQL + star schema + Power BI**.  

This repo is a portfolio skeleton: deliverables go in the folders below as you complete each step.

---

## Business problem

US Marketplace Operations spends ~6 hours every week building a manual Excel pack. GMV dropped in three top US categories and cancellations rose. Leadership needs:

- a trusted weekly view (USD, US marketplace only)
- root-cause visibility
- 3–5 actions for the next 30 days

Out of scope: CA/MX/other marketplaces, ML forecasts, Tableau/Looker.

---

## Folder map

| Folder | What belongs here |
| --- | --- |
| `docs/` | Charter, RACI, KPI dictionary, QA, handover, insight memo, deck outline |
| `templates/` | Blank copies of every plantilla  |
| `sql/` | Staging → cleaned → mart scripts and data-quality tests |
| `powerbi/` | Model notes, measure list, RLS, `.pbix` when you build it locally |
| `data/sample/` | US-only sample extracts (20–30 rows per table) used for the exercise |

Suggested file names appear in [`docs/DELIVERABLE_CHECKLIST.md`](docs/DELIVERABLE_CHECKLIST.md).

---

## 12 steps

1. Brief and stakeholders  
2. Scope, assumptions, risks, definition of done  
3. Source inventory and data quality  
4. KPI dictionary (single source of truth)  
5. Dimensional model  
6. SQL transformations  
7. Reconciliation vs official report  
8. Power BI dashboard design  
9. Power BI model + DAX + RLS  
10. QA, documentation, handover  
11. Insights and 30-day recommendations  
12. Leadership readout and project close  

---

## Guardrails (junior scope)

- Marketplace filter is always US (`country_code = 'US'` or US `marketplace_id`).
- Currency is always USD. Timezone is `America/New_York`.
- Every KPI needs formula, grain, filters, owner, source, and exceptions.
- Do not invent a second definition of GMV or cancel rate.
- If source data is missing, use a realistic 20–30 row US sample and document the assumption.

---

## License

Use this repo as a personal portfolio piece. Do not present sample rows as production Amazon data. Sample figures are synthetic.
