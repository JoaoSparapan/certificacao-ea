with 
    calendario as (
    select *
    from {{ ref('stg_sap__calendario') }}
    )

select *
from calendario