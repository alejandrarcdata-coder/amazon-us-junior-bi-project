# Criterios de aceptación — AMP-US-OPS-WKLY-2026Q3

**DoD de proyecto** (no de un solo paso). Priya A · Camila R · Rachel C en métricas.

Escala: Must / Should. Si un Must falla, no hay go-live ni retiro de Excel.

## Must — datos y métricas

| ID | Criterio | Evidencia | Owner prueba |
| --- | --- | --- | --- |
| AC-01 | Toda query y medida filtra marketplace US. Cero filas CA/MX/PE/RoW en el mart. | Test SQL `COUNT(*)` where country not US = 0 | Camila |
| AC-02 | Toda moneda en el mart es USD. | Test `currency_code <> 'USD' = 0` | Camila |
| AC-03 | Timestamps de negocio en ET. `dim_date` semana domingo–sábado. | Spot check 13 week_start | Camila |
| AC-04 | Terna L1 solo HK / SO / PET. Tools no aparece en slicer. | Distinct category_name | Camila |
| AC-05 | B2B excluido (`is_business_order = false`). | Test count B2B in mart = 0 | Camila |
| AC-06 | GMV usa la fórmula del spec `docs/04_metric_spec_gmv.md`. Gift wrap, shipping, tax, CBS fuera. Returns no netean GMV. | Code review BIL + fila PASO 7 | BIL / Rachel |
| AC-07 | Cancel rate usa el spec `docs/04_metric_spec_cancel_rate.md`. | Idem | Diego / Camila |
| AC-08 | \|GMV_mart − GMV_flash\| / GMV_flash ≤ 1.0% a nivel **top-3 × semana fiscal** en las 3 semanas más recientes, o gap explicado en nota. | Workbook PASO 7 status = Pass o Explained | Rachel |
| AC-09 | \|Cancel_rate_mart − Cancel_rate_SP\| ≤ 0.25 pp a nivel top-3 × semana, o Explained. | Workbook PASO 7 | Diego |
| AC-10 | No PII en mart (email, teléfono, cuenta bancaria, dirección 1:1). | Review columnas | Luis |

## Must — producto

| ID | Criterio | Evidencia |
| --- | --- | --- |
| AC-11 | Power BI: página `Ejecutiva` + página `Operativa`. | Screenshot QA |
| AC-12 | Ejecutiva cabe en 1080p sin scroll horizontal. KPI cards + tendencia 13w + categorías + cancelaciones. | QA checklist PASO 10 |
| AC-13 | Operativa drileable por categoría, seller, reason, fulfillment FBA/FBM. | QA |
| AC-14 | Slicers: semana fiscal, categoría, fulfillment, CM-safe date. Formato USD, 0.0%, mm/dd/yyyy. | QA |
| AC-15 | RLS: rol `Ops_US_National` ve las 3 cats; rol `CM_Category` solo su L1. | Test usuarios |
| AC-16 | Refresh diario 06:00 America/New_York documentado. | Runbook |
| AC-17 | Guía de usuario de 1 página. | `docs/10_user_guide.md` |

## Should

| ID | Criterio | Evidencia |
| --- | --- | --- |
| AC-18 | Traffic/ads como contexto, no KPI primario. | Modelo |
| AC-19 | Bookmark reset filtros en Ejecutiva. | PBI |
| AC-20 | Delta vs flash también a nivel categoría (tolerancia 2.0%). | PASO 7 |

## Tolerancias de reconciliación (congeladas aquí; se usan en PASO 7)

| Grano | KPI | Tolerancia | Si se excede |
| --- | --- | --- | --- |
| Top-3 × semana fiscal | GMV USD | ≤ 1.0% | Bloquea go-live salvo nota FIN |
| Categoría × semana | GMV USD | ≤ 2.0% | Explained aceptable |
| Top-3 × semana | Cancel rate | ≤ 0.25 pp | Bloquea salvo nota SP |
| Categoría × semana | Cancel rate | ≤ 0.40 pp | Explained aceptable |
| Top-3 × semana | # Orders | ≤ 1.5% | Watch |

## Fuera de aceptación (rechazo automático)

- Incluir CA/MX/PE “porque el junior está en Lima”.
- Segunda fórmula de GMV “para que pegue con Excel”.
- Publicar PBI sin RLS.
- Usar el pack de Sofía como source of truth.
