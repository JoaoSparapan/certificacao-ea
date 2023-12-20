with
    stg_cartoes as (
    select *
    from {{ ref('stg_sap__cartoes') }}
)

SELECT *
FROM stg_cartoes