# 03 — Tests: Generic and Singular, Run in CI Shape

**Evidence level: design-only, gate 1 target.** This pattern has not been
runtime-validated on the fleet. It is written from the dbt 1.12.6
documentation and the fleet's dbt installs (see Versions). Do not describe
it as fleet-verified until a gate-3 run exists.

## What it demonstrates

Two test shapes: generic tests declared in `schema.yml` (uniqueness,
non-null) and one singular test as a SQL file (no negative areas).
Plus the CI shape: `dbt build` runs seed + models + tests in one
command, so a broken model cannot slip past its tests.

## Files

- `models/schema.yml` — generic tests on `stg_countries`.
- `tests/no_negative_area.sql` — singular test: returns rows only
  when a violation exists.
- `ci.sh` — the CI-shaped command sequence (BOM-less, like all files
  here; see pattern 01 for the BOM trap).

## Run

```bash
dbt seed --profiles-dir ../01-project-setup --project-dir .
dbt build --profiles-dir ../01-project-setup --project-dir .
```

Or run the script, which executes the same two commands and stops on
the first failure:

```bash
bash ci.sh
```

## Synthetic inputs

The same 5-row `countries.csv` fixture as pattern 02 (all areas
positive, all names unique and non-null).

## Expected output

- `dbt build`: seed 5 rows, 3 models built, all tests **pass**.
- Generic tests: `unique` on `country_name` (5 distinct values),
  `not_null` on `country_name`, `area_sqkm`, and `population`.
- Singular test: **0 rows returned** (pass). A singular test passes
  by returning nothing.
- The fleet's real shape evidence is Node-1's demo run (tests 3/3) —
  this example's test count differs (4 generic + 1 singular) and is
  its own fixture.

## Versions

- dbt Core **1.12.6** (fleet-verified on Node-1 and Node-3).
- DuckDB target by default (pattern 01); the same tests run against
  the Postgres target where auth works.
- To confirm at validation: the exact `dbt build` output lines and
  test-summary format for 1.12.6.

## Failure behavior

- Planted violation (change one seed area to −50 and re-seed): the
  singular test **fails and returns the offending row** (country name
  and area). That is the test working, not the pattern breaking —
  restore the fixture and re-run.
- Duplicate country name in the seed: the `unique` test fails and
  names the duplicated value. Fix the seed; do not drop the test.
- `dbt build` stops at the first failing step by design. A model
  failure means its tests never ran — read the model error first,
  not the test report.

## To confirm at validation

- Exact failure output for the singular test (row format).
- Whether `dbt build`'s test summary counts the 4 generic tests and
  the singular test separately (assumed: 5 tests total).
