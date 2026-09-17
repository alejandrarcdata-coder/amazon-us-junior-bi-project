# PASO 8 — Wireframe Power BI

**Report:** `amazon_us_ops_weekly`  
**Workspace:** Marketplace Ops US · App: Weekly Top-3  
**Páginas:** `01 Ejecutiva` · `02 Operativa`  
**Canvas:** 1280 × 720 (1 pantalla ejecutiva, sin scroll horizontal)  
**Tema:** Amazon-like sobrio (navy `#232F3E`, papel `#F4F2EE`, acento `#E47911` solo selección, rojo `#B12704` / verde `#067D62` semántico).  
**Formato:** USD `$#,##0,,,.0M`; % `0.0%`; fechas `mm/dd/yyyy`; semana `2026W33`.

Filtros persistentes (slicers en ambas páginas, sync slicers ON):

| Slicer | Campo | Tipo | Default |
| --- | --- | --- | --- |
| Fiscal week | dim_date[fiscal_week] | dropdown, single | latest complete week |
| Category | dim_category[category_l1] | dropdown multi | all (RLS recorta) |
| Fulfillment | dim_fulfillment[fulfillment_name] | FBA / FBM / All | All |
| Compare | disconnected `Compare Mode` | vs baseline W22–W27 / vs WoW | vs baseline |

---

## Página 1 — Ejecutiva (1 pantalla)

| # | Visual | Campo / medida | Filtro | Interacción |
| --- | --- | --- | --- | --- |
| E0 | Title + subtitle | “US Top-3 GMV & Cancel · Weekly” + marketplace US · TZ ET · flash FIN | none | none |
| E1 | Card GMV USD | [GMV USD] + [GMV Δ vs baseline %] | slicers | highlight trend |
| E2 | Card Cancel rate | [Cancel Rate] + [Cancel Δ pp] | slicers | highlight reasons |
| E3 | Card # Orders | [Orders] + Δ% | slicers | none |
| E4 | Card AOV | [AOV] + Δ% | slicers | none |
| E5 | Card Late ship | [Late Shipment Rate] | slicers | none |
| E6 | Card Active sellers | [Active Sellers] | slicers | none |
| E7 | Line + column 13w | X: fiscal_week (13w) · Col: [GMV USD] · Line: [Cancel Rate] | category/fulfillment | click week → filter page |
| E8 | Clustered bar | X: category_l1 · Y: [GMV USD] · legend: current vs baseline avg | week | click cat → filter E7/E9 |
| E9 | 100% stacked bar | X: category_l1 · Y: [Cancelled Units] · legend: reason_bucket | week | tooltip actor |
| E10 | KPI ribbon | “Top-3 GMV −10.7% vs W22–W27 · Cancel +1.65 pp · reconcil Pass cond.” | none | bookmark to Operativa |

Bookmark `Reset Ejecutiva` limpia slicers a default (excepto RLS).

---

## Página 2 — Operativa

| # | Visual | Campo / medida | Filtro | Interacción |
| --- | --- | --- | --- | --- |
| O1 | Matrix categoría × fulfillment | Rows: category, fulfillment · Values: GMV, Cancel rate, Late ship, A-to-Z, Return rate | slicers | expand |
| O2 | Column FBA vs FBM | X: fulfillment_name · Y: [Cancel Rate] · legend: category | week | click |
| O3 | Table sellers | seller_name, fulfillment, GMV, Cancel rate, cancelled units, WoW GMV | top N 12 + “show more” | sort cancel desc |
| O4 | Bar reason code | X: cancelled units · Y: reason_code · legend: actor | slicers | tooltip bucket |
| O5 | Card CBS share | [CBS Units] / [Cancelled Units] | slicers | none |
| O6 | Button | “Back to Executive” bookmark | — | bookmark |

Drill path: Category → Fulfillment → Seller → Reason.

---

## Paleta y reglas visuales

| Token | Hex | Uso |
| --- | --- | --- |
| Navy | #232F3E | header, títulos |
| Paper | #F4F2EE | canvas |
| Surface | #FFFFFF | cards |
| Ink | #16181D | body |
| Muted | #5C6370 | labels |
| Accent | #E47911 | selección / semana actual (nunca fills masivos) |
| Down | #B12704 | Δ negativo GMV, Δ positivo cancel |
| Up | #067D62 | Δ favorable |
| Grid | #E6E3DC | ejes |

No emojis. No gradients. Eje Y GMV en millones. Cancel nunca en eje compartido sin dual axis. Tooltip: categoría, semana, valor, Δ.
