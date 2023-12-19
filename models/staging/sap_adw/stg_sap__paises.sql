with
    fonte_paises as (
        select
            cast(countryregioncode as string) as codigo_pais
            , cast(name as string) as nome_pais
        from {{ source('sap-adw', 'countryregion') }}
    )

select * from fonte_paises