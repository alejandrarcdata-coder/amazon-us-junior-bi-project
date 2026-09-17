# Issues log — fuentes y calidad

Owner: Camila · Cola: Luis / Marcus / Rachel / Diego

| ID | Fuente | Severidad | Hallazgo | Impacto | Acción | Owner | Due | Estado |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DQ-01 | S03 | M | reason_code sin jerarquía (BUYER vs SELLER vs AMAZON vs detalle) | dim_cancellation_reason incompleta | Pedir mapa SP | Diego | 09/25 | Open |
| DQ-02 | S04 | M | Sample de returns con 6 filas | return rate no es estable en diseño | Extraer 13 semanas US terna | Marcus | 09/18 | Open |
| DQ-03 | S02 | L | gift_wrap_amt y shipping_amt conviven con item_price | Riesgo de inflar GMV | Spec los excluye | Camila | 09/22 | Open |
| DQ-04 | S01 | L | order_datetime en UTC | Semana fiscal mal asignada si no se convierte | CONVERT_TIMEZONE en staging | Camila | PASO 6 | Open |
| DQ-05 | S10 | H | No hay archivo oficial browse_node → L1 | Filtrar Tools por error o meter Grocery en Pet | Lista firmada CMs | Andre/Elena/Jamal | 09/22 | Open |
| DQ-06 | S07 vs S02 | H | Sample items no escala a $165M (es extracto de 32 filas) | Nadie debe citar sample como GMV real | PASO 7 usa flash sintético de 12 semanas, no el sample de 32 items, para magnitudes | Camila | PASO 7 | Closed |
| DQ-07 | S09 | L | Ads no entregado | No hay tráfico en v1 | Dejar opcional | Priya | — | Closed |
| DQ-08 | S05 raw | H | Raw sellers tiene email | PII | Solo `sellers_pub` | Luis | 09/16 | Open |
