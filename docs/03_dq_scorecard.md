# Data quality scorecard — extractos US v1

Método: perfil sobre `data/sample/*.csv` + reglas que aplicarán al raw.  
Escala 1–5. Umbral de entrada al mart: score ≥ 3 y cero blockers.

| Source | Completeness | Validity | Uniqueness | Consistency | Timeliness | Score | Blocker |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| S01 orders | 5 | 5 | 5 | 5 | 4 | 4.8 | No. marketplace_id 100% ATVPDKIKX0DER |
| S02 order_items | 5 | 5 | 5 | 4 | 4 | 4.6 | No. currency 100% USD |
| S03 cancellations | 4 | 4 | 5 | 3 | 4 | 4.0 | Watch: reason_code no tiene mapa padre aún |
| S04 returns | 3 | 4 | 5 | 3 | 3 | 3.6 | Watch: sample corto (6 filas). Pedir 13w completas |
| S05 sellers_pub | 5 | 5 | 5 | 5 | 5 | 5.0 | No. Vista sin PII |
| S06 inventory_health | 4 | 4 | 4 | 3 | 4 | 3.8 | Watch: IPI no es diario real; es snapshot |
| S07 FIN GMV flash | 5 | 5 | 5 | 5 | 5 | 5.0 | No. 12 semanas × 3 cats |
| S08 SP cancel flash | 5 | 5 | 5 | 4 | 5 | 4.8 | Watch: reason no viene al grano flash (solo rate) |
| S09 ads (opc.) | 1 | n/a | n/a | n/a | n/a | 1.0 | Fuera de v1 Must |
| S10 browse node | 2 | n/a | n/a | n/a | n/a | 2.0 | Pedir lista firmada a CMs |

## Checks puntuales (sample)

| Check | Resultado | Acción |
| --- | --- | --- |
| country_code distinto de US | 0 filas | OK |
| currency_code distinto de USD | 0 filas | OK |
| is_business_order = true | 0 filas | OK (v1) |
| order_id huérfano en items | 0 | OK |
| cancel.order_item_id no está en items | 0 | OK |
| gift_wrap_amt > 0 | presente en minoría de items | Excluir del GMV (spec) |
| OOS flag = true en inventory | ~18% del snapshot | Hipótesis late ship / cancel OOS |

## Score de entrada a PASO 5–6

**GO condicionado:** S01–S03 y S07–S08 suficientes para modelo y reconciliación GMV/cancel. S04 thin. S09 out. S10 pendiente (usamos 3 nodos hardcodeados).
