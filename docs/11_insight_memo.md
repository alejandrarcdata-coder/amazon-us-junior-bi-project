# PASO 11 — Insight memo (30 días)

Población: US 3P, terna HK / SO / PET, USD, semana fiscal ET. Cifras sintéticas alineadas al flash.  
Ventana: W28–W33 vs W22–W27.

---

### I1 — Pet Supplies FBM: OOS + ship-late concentran el alza de cancel

**Hallazgo.** Pet Supplies GMV −11.0% y cancel +1.8 pp. En FBM el mix de reasons reciente es ~42% OUT_OF_STOCK y ~28% SHIP_LATE_RISK. BarkHarbor LLC y HomePet Bundle Co explican la mayor parte del numerador.

**Evidencia.** Operativa W33 · filtro Pet + FBM · seller table sort cancel rate · late ship +0.9 pp vs baseline.

**Hipótesis.** Sellers FBM no tienen cobertura de inventario US para ASINs de treats/beds; el promise time no se recortó cuando el OOS subió. No es un shock de demanda (orders caen en línea con GMV, AOV estable).

**Acción.** Andre Williams: 1:1 con BarkHarbor y HomePet en 7 días — restock US o mover ASINs problemáticos a FBA. Diego: forzar reason map SHIP_LATE_RISK en el flash.

**Owner.** Andre Williams (CM Pet) · **Esfuerzo.** M · **Impacto.** H (cierra ~0.6–0.8 pp de cancel Pet si OOS FBM baja 30%).

---

### I2 — Home & Kitchen: Oak & Linen (FBM) arrastra cancel y un trozo de GMV

**Hallazgo.** HK GMV −11.4% (mayor hueco en $). FBA sigue siendo ~71% del GMV pero FBM cancel rate está ~1.4× el de FBA. Oak & Linen Co aparece primero en cancel rate del nodo.

**Evidencia.** Seller table HK W33 · reason PRICING_ERROR + OUT_OF_STOCK vs HappyHome (FBA) estable.

**Hipótesis.** Seller sin IPI/FBA; stockouts + repricing agresivo generan CBS. El GMV perdido no se va a HappyHome en la misma semana (no hay offset visible).

**Acción.** Elena Voss: plan 14 días — FBA inbound o recorte de buy box en ASINs con cancel > 8%. Ops: watchlist semanal.

**Owner.** Elena Voss · **Esfuerzo.** M · **Impacto.** H en $ (HK es 54% del top-3).

---

### I3 — Sports & Outdoors baja menos; no priorizar igual

**Hallazgo.** SO −9.1% GMV, cancel +1.5 pp, mix FBA más sano. TrailPeak y CourtSide FBM suben cancel pero el nodo no es el primer dólar.

**Evidencia.** Barras de categoría E8; SO es el menor Δ $.

**Hipótesis.** Corrección de temporada (pre-back-to-school outdoor), no rotura estructural.

**Acción.** Jamal: monitoreo, no war-room. Revisar en W35.

**Owner.** Jamal Wright · **Esfuerzo.** L · **Impacto.** L–M.

---

### I4 — El pack Excel de 6 h ya no es source of truth

**Hallazgo.** Reconcil top-3 GMV Pass ≤ 1%. Pet W33 Explained (payment-week / CBS timing). El Excel de Sofía no está en el linaje.

**Acción.** Priya: comunicar que liderazgo cita el PBI + flash FIN. Sofía pasa a QA lunes. Retiro formal a las 3 semanas Pass consecutivas.

**Owner.** Priya Shah / Sofía Delgado · **Esfuerzo.** L · **Impacto.** M (capacidad +6 h/sem).

---

### I5 — B2B y Tools fuera evitan doble verdad

**Hallazgo.** Charter cumplido. No mezclar.

**Acción.** Ninguna en 30 días salvo change request.

**Owner.** Priya · **Esfuerzo.** — · **Impacto.** —
