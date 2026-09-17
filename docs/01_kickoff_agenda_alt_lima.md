# Kickoff 30 min ALT Lima — AMP-US-OPS-WKLY-2026Q3

| Campo | Valor |
| --- | --- |
| Título reunión | Kickoff — Weekly US Top-3 GMV & Cancellation Visibility |
| Fecha propuesta | Tuesday 09/15/2026 |
| Hora | 11:00–11:30 AM America/New_York = **10:00–10:30 AM America/Lima** |
| Duración | 30 minutos (hard stop) |
| Formato | Chime. Facilitador desde Lima; decision owner en ET |
| Facilitador | Camila Quispe Rojas (JBI, GSC Lima) · Backup: Senior BI Lead |
| Decision owner | Priya Shah (BO, ET) |
| Pre-read | One-pager ALT Lima + RACI ALT Lima (enviar 16 h antes = lun 6:00 PM Lima / 7:00 PM ET) |
| Notetaker | Sofía Delgado (OA, SEA) |

## Convocatoria

| Asistente | Rol | TZ | Mandatory |
| --- | --- | --- | --- |
| Aisha Boateng | Sponsor | ET | Optional (0–10 min) |
| Priya Shah | Business owner | ET | Yes |
| Senior BI Lead | Técnico | ET | Yes |
| Camila Quispe Rojas | Facilitador / build | Lima | Yes |
| Marcus Lee | DE warehouse US | ET | Yes |
| Luis Huamán | DE accesos | Lima | Yes |
| Elena Voss / Jamal Wright / Andre Williams | CMs | ET | Yes (≥2 de 3; Andre ideal) |
| Sofía Delgado | Ops Analyst lead | ET | Yes |
| Rachel Cho | Finance — flash GMV | ET | Yes |
| Diego Alvarez | Seller Performance | ET | Optional |

## Agenda minuto a minuto

| Min ET | Bloque | Owner | Output |
| ---: | --- | --- | --- |
| 0–3 | Apertura desde Lima: problema + terna corregida (sale Tools, entra Pet) | Camila | Todos ven la terna nueva |
| 3–8 | Ratificar terna L1 y ventana W22–W33 | Priya | D1 |
| 8–14 | Congelar fuente oficial: `FIN.MP_US_3P_GMV_WKLY` + excepciones v1 (B2B out) | Rachel + Priya | D2 / D3 |
| 14–20 | Alcance junior, RLS, stack. Lima construye / ET decide | BIL | In / out verbal |
| 20–25 | RACI + ticket accesos Luis→Marcus | Camila + Luis | D4 |
| 25–29 | SLA pack Excel Sofía (lunes 08:00 ET) y riesgos | Priya | D5 / parking lot |
| 29–30 | Next: PASO 2 charter. Checkpoint vie 09/18 11:00 ET / 10:00 Lima | Camila | Fecha |

## Decisiones que Lima ya trae redactadas

1. Terna = Home & Kitchen / Sports & Outdoors / **Pet Supplies**. Tools fuera.
2. GMV oficial = **US MP 3P GMV Weekly Flash** (`FIN.MP_US_3P_GMV_WKLY`), no el Excel.
3. Cancel oficial = `SP.US_CANCEL_WKLY`. Reason codes del mismo feed.
4. B2B excluido de v1.
5. Go PASO 2 el mismo 09/15 si D1–D4 quedan en acta.

## Mensaje de calendar (copiar)

```
Title: Kickoff — US Top-3 GMV & Cancel Weekly Visibility (30m)
When: Tue 09/15/2026 11:00–11:30 AM ET (10:00–10:30 AM Lima)
Where: Chime — link TBD
Pre-read: one-pager ALT Lima + RACI ALT Lima
Please ratify: (1) Pet Supplies in / Tools out, (2) FIN.MP_US_3P_GMV_WKLY as official GMV, (3) go/no-go for charter.
Facilitator: Camila Quispe Rojas (GSC Lima)
```

## Acta — para llenar en la reunión

| # | Decisión / nota | Owner | Due |
| --- | --- | --- | --- |
| D1 | Categorías oficiales: HK + SO + Pet Supplies (sí/no) | Priya | 09/15 |
| D2 | Reporte oficial GMV: FIN.MP_US_3P_GMV_WKLY (sí/no) | Rachel | 09/15 |
| D3 | B2B out v1; gift wrap / CBS a PASO 4 | Priya + Rachel | PASO 4 |
| D4 | Ticket accesos US #: _____ | Luis / Marcus | 09/16 |
| D5 | Go PASO 2: Yes / No | Priya | 09/15 |
---
*Owner: Camila Quispe Rojas (Lima) · Revisión: Senior BI Lead · Status: ALT LIMA*
