# RAID log — AMP-US-OPS-WKLY-2026Q3

Actualizado: 09/14/2026 · Owner log: Camila Quispe Rojas · Revisión semanal: viernes 10:00 Lima / 11:00 ET

Leyenda: R Risk · A Assumption · I Issue · D Dependency.  
Severidad: H / M / L. Estado: Open / Watch / Closed.

## Risks

| ID | Tipo | Descripción | Prob. | Impacto | Sev. | Mitigación | Owner | Due | Estado |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R1 | Risk | Flash Finance y mart usan grano distinto (order_date vs payment_date) | M | H | H | Spec GMV atribuye a `order_datetime_et` truncado a semana fiscal. Validar con Rachel en PASO 4. | Rachel / Camila | 09/22 | Open |
| R2 | Risk | Reason codes de cancelación no están normalizados (texto libre + código) | H | M | H | dim_cancellation_reason con mapa oficial SP + bucket Other. | Diego / Camila | 09/25 | Open |
| R3 | Risk | Acceso Lima a PII de seller (email, bank) bloquea el extract | M | H | H | Pedir vistas US ya tokenizadas: seller_id + nombre comercial. Nada de PII en el mart. | Luis / Marcus | 09/16 | Open |
| R4 | Risk | Pet Supplies browse node L1 incluye subnodos de Grocery/Food | M | M | M | Congelar lista de browse_node_id con Andre. Excluir consumibles regulados si FIN los saca del flash. | Andre / Camila | 09/22 | Open |
| R5 | Risk | Refresh 06:00 ET falla porque el job Lima corre a las 05:00 Lima (igual que 06:00 ET en sep; en nov Lima=ET) | M | M | M | Job con TZ explícito `America/New_York`. Documentar DST en runbook. | Camila | 10/14 | Watch |
| R6 | Risk | Delta GMV > 1% por gift wrap / shipping / taxes | H | H | H | Excepciones escritas en spec. Tabla de puentes en PASO 7. | Rachel / Camila | 10/02 | Open |
| R7 | Risk | CMs piden una 4ª categoría a mitad de build | M | H | H | Charter: cambio de terna = change request con A de Priya. No se modela Tools. | Priya | continuo | Open |
| R8 | Risk | Pack Excel de Sofía y el PBI conviven y discrepan en liderazgo | M | H | H | Una sola fuente citada en readout: flash FIN + mart. Excel = QA only. | Priya / Sofía | 10/16 | Open |

## Assumptions

| ID | Tipo | Descripción | Si es falso | Owner | Estado |
| --- | --- | --- | --- | --- | --- |
| A1 | Assumption | `marketplace_id = 'ATVPDKIKX0DER'` = US retail website. | Recalibrar filtro con Marcus. | Marcus | Open |
| A2 | Assumption | GMV del flash es ordered merchandise USD, sin tax, sin shipping, sin gift wrap, net de CBS, **sin netear returns**. | Reescribir spec y PASO 7. | Rachel | Open |
| A3 | Assumption | B2B se identifica con `is_business_order = true` o `cba_flag`. | Pedir columna equivalente. | Marcus | Open |
| A4 | Assumption | Semana fiscal Amazon = domingo 00:00 ET → sábado 23:59:59 ET. | Ajustar dim_date. | BIL | Open |
| A5 | Assumption | 3P se filtra con `fulfillment_channel IN ('AFN','MFN')` y `merchant_id <> AMAZON_RETAIL`. | Confirmar ID 1P. | Marcus | Open |
| A6 | Assumption | Los 13 weeks del dashboard caben en extract incremental diario. | Full pull semanal aceptable en v1. | Luis | Open |
| A7 | Assumption | Cifras del one-pager son **sintéticas** para diseño; producción reemplaza en PASO 7. | N/A (ya declarado). | Camila | Closed |

## Issues

| ID | Tipo | Descripción | Sev. | Acción | Owner | Due | Estado |
| --- | --- | --- | --- | --- | --- | --- | --- |
| I1 | Issue | No hay ticket de acceso US abierto al 09/14 | M | Abrir ticket D4 post-kickoff | Luis | 09/16 | Open |
| I2 | Issue | No tenemos extracto real del flash FIN; usamos sample sintético | M | Rachel envía 13 semanas top-3 | Rachel | 09/18 | Open |

## Dependencies

| ID | Tipo | Descripción | Proveedor | Needed by | Estado |
| --- | --- | --- | --- | --- | --- |
| D1 | Dependency | Vistas US tokenizadas | Marcus / Luis | PASO 3 | Open |
| D2 | Dependency | Flash `FIN.MP_US_3P_GMV_WKLY` | Rachel | PASO 7 | Open |
| D3 | Dependency | Feed `SP.US_CANCEL_WKLY` + reason map | Diego | PASO 4–5 | Open |
| D4 | Dependency | Workspace PBI + gateway | PBI admin | PASO 9 | Open |
| D5 | Dependency | Lista browse node L1 oficial | CMs | PASO 5 | Open |
