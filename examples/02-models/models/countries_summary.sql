-- dbt 02-models — mart: one summary row.
-- Expected: country_count 5, avg_area_sqkm 240, total_population 440000.
select
    count(*) as country_count,
    avg(area_sqkm) as avg_area_sqkm,
    sum(population) as total_population
from {{ ref('int_countries') }}
