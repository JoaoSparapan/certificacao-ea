with 
    stg_calendario as (
    select *
    from {{ ref('stg_sap__calendario') }}
    )

select *
from stg_calendario