with
    fonte_estados as (
        select
            cast(stateprovinceid as int) as id_estado
            , cast(stateprovincecode as string) as codigo_estado
            , cast(countryregioncode as string) as codigo_pais
            , cast(name as string) as nome_estado
        from {{ source('sap-adw', 'stateprovince') }}
    )

select * from fonte_estados