-- dbt 02-models — intermediate: derive population density.
-- Expected densities: Alandia 500, Boria 400, Caldia 200,
-- Doria 600, Eldia 400 (people per sqkm).
select
    country_name,
    area_sqkm,
    population,
    population / area_sqkm as density_per_sqkm
from {{ ref('stg_countries') }}
