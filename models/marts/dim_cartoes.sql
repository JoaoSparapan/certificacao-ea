with
    cartoes as (
    select *
    from {{ ref('stg_sap__cartoes') }}
)

SELECT *
FROM cartoes