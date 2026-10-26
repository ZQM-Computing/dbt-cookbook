-- dbt 03-tests — singular test: no negative areas.
-- Passes by returning 0 rows. Plant a negative area in the seed to
-- see it fail with the offending row.
select
    country_name,
    area_sqkm
from {{ ref('stg_countries') }}
where area_sqkm < 0
