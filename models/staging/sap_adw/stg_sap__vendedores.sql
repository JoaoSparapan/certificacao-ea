with
    fonte_vendedores as (
        select
            cast(businessentityid as int) as id_vendedor
            , cast(salesquota as numeric) as meta_anual
        from {{ source('sap_adw', 'salesperson') }}
    )

    select * from fonte_vendedores