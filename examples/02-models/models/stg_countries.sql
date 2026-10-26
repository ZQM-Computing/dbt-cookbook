-- dbt 02-models — staging: rename and type the seed, nothing else.
select
    country_name,
    area_sqkm::integer as area_sqkm,
    population::integer as population
from {{ ref('countries') }}
