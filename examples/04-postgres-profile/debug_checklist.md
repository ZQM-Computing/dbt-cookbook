# dbt 04-postgres-profile — `dbt debug` checklist (target pg)

Run: `dbt debug --profiles-dir . --project-dir . --target pg`

Every check below must report OK before `dbt run` is attempted.
A red check names the failing piece — fix that piece, do not re-run
hoping it clears. (Exact 1.12.6 output wording: to confirm at validation.)

1. **Profile file found** — `profiles.yml` loads, `countries_demo`
   profile present, `pg` output selected.
2. **Adapter loaded** — `dbt-postgres` 1.11.0 importable.
3. **Connection OK** — host/port reachable, credentials accepted.
   Auth failure here = environment finding (see README auth gate).
4. **Database accessible** — the `dbname` from env exists and the user
   can connect to it.
5. **Schema usable** — the target schema exists or is creatable by
   this user; models will land here.
6. **BOM check** — no project file carries a UTF-8 BOM (Postgres
   `?SELECT` trap, pattern 01). Re-save BOM-less if this check is
   ever added as a scripted gate.

After all six: `dbt run` then `dbt test` (see README expected output).
