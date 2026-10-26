# 04 — Postgres Profile: The Fleet's Profile Pattern

**Evidence level: design-only, gate 1 target.** This pattern has not been
runtime-validated on the fleet. It is written from the dbt 1.12.6
documentation and the fleet's dbt installs (see Versions). Do not describe
it as fleet-verified until a gate-3 run exists.

## What it demonstrates

The fleet's Postgres profile pattern: one `profiles.yml` target with
env-var credentials, a `dbt debug` checklist, and the demo models it
runs. This is the profile the fleet's Node-1 and Node-3 dbt installs
won with — and the profile that cannot run where Postgres auth is
blocked, which is stated, not hidden.

## Files

- `profiles_postgres.yml` — the Postgres target (env-var credentials,
  placeholders only). Copy the `pg` output into your own
  `profiles.yml`; do not commit a filled-in copy.
- `debug_checklist.md` — what `dbt debug` must report, in order.

## Run

```bash
export DBT_PG_HOST=localhost
export DBT_PG_USER=your_user
export DBT_PG_PASSWORD=your_password
export DBT_PG_DBNAME=your_db
export DBT_PG_SCHEMA=dbt_demo
dbt debug --profiles-dir . --project-dir . --target pg
dbt run --profiles-dir . --project-dir . --target pg
dbt test --profiles-dir . --project-dir . --target pg
```

All credential values are placeholders. Never put a real password in
the profile file. The fleet's Node-1 demo ran under trust auth with an
explicitly-present empty password — that setup is NOT copied here.

## Auth gate (read before running)

This pattern requires **working Postgres auth**. Node-4's Postgres auth
is blocked (scram-sha-256, passwords file unusable from SSH) — do not
run this pattern against Node-4 until that unblocker lands. Where auth
fails, use pattern 01's DuckDB target for all modeling work. This
pattern never edits pg_hba, creates roles, or resets passwords.

## Synthetic inputs

The same 5-row `countries.csv` fixture as pattern 02, loaded with
`dbt seed`. The fleet's real shape evidence: Node-1's project
(`C:\dbt\zqm_demo`, model `dbt_demo.seed_summary`, run 1/1, tests 3/3,
view returning 177/243) and Node-3's project (run 2/2: `stg_countries`
177 rows, `countries_summary` 177 rows at 832,558 avg sqkm). This
example's 5 rows are its own fixture.

## Expected output

- `dbt debug --target pg`: connection OK, and every check green. Any
  red check names the failing piece (host, credentials, database,
  schema) — fix that piece; do not re-run hoping it clears.
- `dbt run --target pg`: the pattern 02 models build in the target
  schema (5-row staging, summary row: count 5, avg area 240, total
  population 440,000).
- `dbt test --target pg`: pattern 03's tests pass (4 generic + 1
  singular, 0 violation rows).

## Versions

- dbt Core **1.12.6** + dbt-postgres **1.11.0** (fleet-verified on
  Node-1 and Node-3).
- Postgres 17 (fleet Postgres).
- To confirm at validation: the exact `dbt debug` output lines for
  1.12.6 + dbt-postgres 1.11.0, and whether `threads: 4` is honored
  identically on DuckDB and Postgres targets.

## Failure behavior

- Auth failure (`fe_sendauth`-class error, or password authentication
  failed): the debug output names the credential or pg_hba side.
  Check your env vars first, then your instance's pg_hba — on your
  own instance, never on a shared fleet node from this pattern.
- BOM in any project file: Postgres targets fail with a `?SELECT`
  parse error (fleet trap, pattern 01). Rewrite BOM-less.
- `dbt` not found: use the venv's `Scripts\dbt.exe` by full path;
  `python -m dbt` is invalid (fleet trap, pattern 01).

## To confirm at validation

- Exact `dbt debug` output for the `pg` target.
- The demo-model names the fleet actually ran under the `pg` target
  on each node (Node-1's `seed_summary` vs Node-3's `stg_countries` /
  `countries_summary` split) — this pattern's models are the pattern
  02 set, and any rename at validation must be recorded, not silently
  swapped.
