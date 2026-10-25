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

**Status:** Active, public — seeding. Pattern passes land in follow-up work from fleet-verified setups; the tables below list what is planned, not what is already written.

**What this repository is:** dbt patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Analytics engineers who transform warehouse tables with versioned SQL.

## Prerequisites

- dbt Core 1.12.6 + dbt-postgres 1.11.0
- Postgres with a demo schema
- Bash or PowerShell

## Patterns (planned)

| # | Example | What it will demonstrate |
|---|---------|--------------------------|
| 01 | `01-project-setup` | Initializing a dbt project and a Postgres profile |
| 02 | `02-models` | Staging, intermediate, and mart models |
| 03 | `03-tests` | Generic and singular tests, run in CI shape |
| 04 | `04-postgres-profile` | The fleet's Postgres profile pattern, including the demo models |

## Repository layout

```text
dbt-cookbook/
├── examples/          # pattern passes, landing in follow-up work
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: the first two table rows
- Second pass: the remaining rows, from fleet-verified setups

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [dlt-cookbook](https://github.com/ZQM-Computing/dlt-cookbook) — ELT pipelines from Python into Postgres and DuckDB
- [prefect-cookbook](https://github.com/ZQM-Computing/prefect-cookbook) — Workflow orchestration, schedules, and deployments
- [postgis-cookbook](https://github.com/ZQM-Computing/postgis-cookbook) — Spatial indexing, joins & KNN, SRID management, vector tiles
