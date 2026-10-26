# 01 — Project Setup: DuckDB Profile First, Postgres as a Variant

**Evidence level: design-only, gate 1 target.** This pattern has not been
runtime-validated on the fleet. It is written from the dbt 1.12.6
documentation and the fleet's dbt installs (see Versions). Do not describe
it as fleet-verified until a gate-3 run exists.

## What it demonstrates

Initializing a dbt project with a profile that runs anywhere: DuckDB
first, because it needs no server and no credentials. The Postgres
profile is shown as a documented variant, gated on working Postgres
auth — it is not the default, because Node-4's Postgres auth is blocked
and this pattern must not assume it away.

## Files

- `dbt_project.yml` — minimal project definition.
- `profiles.yml` — `dev` target on DuckDB, `pg` target on Postgres
  (env-var credentials, flagged variant).

## Run

```bash
pip install "dbt-core==1.12.6" "dbt-duckdb"
dbt debug --profiles-dir . --project-dir . --target dev
```

Use the `dbt` executable (`Scripts\dbt.exe` on Windows). `python -m dbt`
is invalid — that trap is recorded from the fleet's Node-3 dbt install.
Write all project files **BOM-less**: PowerShell 5.1's UTF-8 BOM breaks
Postgres with a `?SELECT` error, a trap recorded from the fleet's
Node-1 dbt install.

## Synthetic inputs

None — this pattern creates scaffolding only. The models and seeds
arrive in pattern 02.

## Expected output

- `dbt debug` against `dev` reports all checks OK and the DuckDB
  connection usable.
- `dbt debug --target pg` reports the Postgres connection status for
  your own instance: OK where auth works, a clear connection error
  where it does not. An auth error is an environment finding, not a
  pattern failure — but it blocks every Postgres-target pattern until
  auth is fixed, and this pattern never edits pg_hba to fix it.

## Versions

- dbt Core **1.12.6** + dbt-postgres **1.11.0** (fleet-verified on
  Node-1 and Node-3).
- To confirm at validation: the dbt-duckdb adapter version (the fleet
  records dbt-postgres only; the DuckDB adapter version is not on
  record) and the exact `dbt debug` output lines for both targets.

## Failure behavior

- `dbt` not found: the venv's Scripts directory is not on PATH.
  Invoke the executable by full path; do not reinstall dbt globally
  to fix a PATH problem.
- BOM in a `.sql` or `.yml` file: Postgres targets fail with a
  `?SELECT`-style parse error. Rewrite the file BOM-less (UTF-8
  without BOM) and re-run.
- `pg` target auth failure: see Expected output. Fall back to `dev`
  (DuckDB) for all modeling work; the Postgres profile waits for auth.

## To confirm at validation

- Exact `dbt debug` output for dbt Core 1.12.6, both targets.
- The dbt-duckdb adapter version that pairs with Core 1.12.6.
- Whether `profiles.yml` in the project directory is picked up without
  `--profiles-dir` on a clean install (this pattern passes the flag
  explicitly so it does not matter).
