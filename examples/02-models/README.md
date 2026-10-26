# 02 — Models: Staging, Intermediate, and Mart

**Evidence level: design-only, gate 1 target.** This pattern has not been
runtime-validated on the fleet. It is written from the dbt 1.12.6
documentation and the fleet's dbt installs (see Versions). Do not describe
it as fleet-verified until a gate-3 run exists.

## What it demonstrates

The three-layer model shape: a staging model that cleans a seed, an
intermediate model that derives a metric, and a mart model that
aggregates. Each layer references the one below it with `ref()`, never
with a hardcoded table name.

## Files

- `seeds/countries.csv` — 5 synthetic country rows.
- `models/stg_countries.sql` — staging: rename and type the seed.
- `models/int_countries.sql` — intermediate: population density.
- `models/countries_summary.sql` — mart: counts and averages.
- `models/schema.yml` — model documentation (tests live in pattern 03).

## Run

```bash
dbt seed --profiles-dir ../01-project-setup --project-dir .
dbt run --profiles-dir ../01-project-setup --project-dir .
```

(Paths assume the pattern 01 files sit alongside this directory's
project files; copy `dbt_project.yml` and `profiles.yml` from pattern
01 into this directory first, or point `--project-dir` at a project
that includes these models. All files BOM-less — see pattern 01.)

## Synthetic inputs

`countries.csv`: Alandia (100 sqkm, 50,000 people), Boria (250, 100,000),
Caldia (400, 80,000), Doria (150, 90,000), Eldia (300, 120,000). The
fleet's real shape evidence is Node-3's run (stg_countries 177 rows,
countries_summary 177 rows at 832,558 avg sqkm) and Node-1's demo view
(177/243) — this example's 5 rows are its own fixture.

## Expected output

- `dbt seed`: 5 rows loaded.
- `stg_countries`: **5 rows** (one per seed row, columns renamed to
  `country_name`, `area_sqkm`, `population`).
- `int_countries`: 5 rows with `density_per_sqkm`: Alandia **500**,
  Boria **400**, Caldia **200**, Doria **600**, Eldia **400**.
- `countries_summary`: one row — `country_count` **5**,
  `avg_area_sqkm` **240** (1200 / 5), `total_population` **440,000**.

## Versions

- dbt Core **1.12.6** (fleet-verified on Node-1 and Node-3).
- DuckDB target by default (pattern 01); the same SQL runs against
  the Postgres target where auth works.
- To confirm at validation: the exact `ref()` resolution output and
  the materialization each model gets under this project's
  `+materialized: view` default.

## Failure behavior

- Seed not loaded: models fail with a missing-relation error naming
  the seed. Run `dbt seed` first; models never create their own inputs.
- A `ref()` to a misspelled model name: dbt fails at parse time with
  the bad name. Fix the name; do not hardcode the table to work
  around it.
- Density division by zero: a zero-area row makes `int_countries`
  fail (or return NULL, by database). The fixture has no zero-area
  rows; a real feed needs a `NULLIF(area_sqkm, 0)` guard — left as a
  validation exercise, not silently added.

## To confirm at validation

- Exact `dbt run` output (model counts, timing lines) for 1.12.6.
- Whether DuckDB and Postgres agree on the density division's
  numeric type (integer vs decimal) for these values.
