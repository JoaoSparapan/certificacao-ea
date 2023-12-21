with
    fonte_territorios as (
        select
            cast(territoryid as int) as id_territorio
            , cast(name as string) as nome_territorio
            , cast(countryregioncode as string) as codigo_pais_territorio
            , cast(`group` as string) as grupo_territorio
        from {{ source('sap_adw', 'salesterritory') }}
    )

select * from fonte_territorios