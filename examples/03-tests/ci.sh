#!/bin/bash
# dbt 03-tests — CI-shaped command sequence.
# Assumes pattern 01's dbt_project.yml/profiles.yml and pattern 02's
# models/seeds are in the project directory. Stops on first failure.
set -euo pipefail
PROFILE_DIR="${PROFILE_DIR:-../01-project-setup}"
PROJECT_DIR="${PROJECT_DIR:-.}"
dbt seed --profiles-dir "$PROFILE_DIR" --project-dir "$PROJECT_DIR"
dbt build --profiles-dir "$PROFILE_DIR" --project-dir "$PROJECT_DIR"
echo "CI SHAPE OK: seed + models + tests passed"
