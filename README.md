# dbt Cookbook

<!-- ZQM-START -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <strong>ZQM Computing — Geospatial Engineering & Scientific Computing</strong><br>
  <a href="https://github.com/ZQM-Computing">ZQM Computing</a>
</p>
<!-- markdownlint-enable MD033 -->
<!-- ZQM-END -->

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A **dbt cookbook** for SQL transformations, models, and tests on Postgres. Patterns are drawn from the ZQM fleet's dbt Core 1.12.6 + dbt-postgres 1.11.0 installs, where the Postgres profile won and demo models passed 3/3 tests. It is intended for Analytics engineers who transform warehouse tables with versioned SQL. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — first pattern pass written (design-only, gate 1 target; runtime validation pending). The table below lists what is written; no pattern has been runtime-validated yet.

**What this repository is:** dbt patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Analytics engineers who transform warehouse tables with versioned SQL.

## Prerequisites

- dbt Core 1.12.6 + dbt-postgres 1.11.0
- Postgres with a demo schema, or DuckDB for the default target (see pattern 01)
- Bash or PowerShell

## Patterns

| # | Example | Status | What it demonstrates |
|---|---------|--------|----------------------|
| 01 | [01-project-setup](examples/01-project-setup/README.md) | Written (design-only) | Initializing a dbt project and a Postgres profile |
| 02 | [02-models](examples/02-models/README.md) | Written (design-only) | Staging, intermediate, and mart models |
| 03 | [03-tests](examples/03-tests/README.md) | Written (design-only) | Generic and singular tests, run in CI shape |
| 04 | [04-postgres-profile](examples/04-postgres-profile/README.md) | Written (design-only) | The fleet's Postgres profile pattern, including the demo models |

## Repository layout

```text
dbt-cookbook/
├── examples/01-project-setup/    # DuckDB-first profiles
├── examples/02-models/           # staging, intermediate, mart
├── examples/03-tests/            # generic + singular tests, CI shape
├── examples/04-postgres-profile/ # fleet Postgres profile + checklist
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: complete (all 4 patterns, design-only).
- Next: gate-3 runtime validation against the fleet's dbt installs.

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [dlt-cookbook](https://github.com/ZQM-Computing/dlt-cookbook) — ELT pipelines from Python into Postgres and DuckDB
- [prefect-cookbook](https://github.com/ZQM-Computing/prefect-cookbook) — Workflow orchestration, schedules, and deployments
- [postgis-cookbook](https://github.com/ZQM-Computing/postgis-cookbook) — Spatial indexing, joins & KNN, SRID management, vector tiles
