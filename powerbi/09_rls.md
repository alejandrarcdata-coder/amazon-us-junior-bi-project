# PASO 9 — RLS

Roles en el dataset. Username = email corporativo. Mapa categoría en tabla `rls_cm_map` (Enter data) o `USERPRINCIPALNAME()`.

## Roles

### 1. Ops_US_National

Filtro DAX en `dim_category`:

```dax
TRUE ()
```

Ve Home & Kitchen, Sports & Outdoors y Pet Supplies. No ve Tools (no está en el modelo).

Miembros: Aisha Boateng, Priya Shah, Sofía Delgado, Camila Quispe Rojas, Senior BI Lead, Rachel Cho (view).

### 2. CM_Category

Filtro DAX en `dim_category`:

```dax
dim_category[category_l1] =
LOOKUPVALUE (
    rls_cm_map[category_l1],
    rls_cm_map[upn], USERPRINCIPALNAME ()
)
```

| UPN (ejemplo) | category_l1 |
| --- | --- |
| elena.voss@amazon.com | Home & Kitchen |
| jamal.wright@amazon.com | Sports & Outdoors |
| andre.williams@amazon.com | Pet Supplies |

Si el UPN no está en el mapa → ninguna categoría (fail closed).

### 3. Viewer_Finance (opcional)

Igual que Ops_US_National. Sin build permission.

## Pruebas

| Usuario | Rol | Ve HK | Ve SO | Ve PET |
| --- | --- | --- | --- | --- |
| Priya | Ops_US_National | Sí | Sí | Sí |
| Elena | CM_Category | Sí | No | No |
| Andre | CM_Category | No | No | Sí |
| Mei Chen | — | No (fuera del proyecto) | | |

## Mock web

El preview simula RLS con un selector de rol (no existe en PBI servicio; allí el rol es el login). El selector es solo para demo/QA.
