with
    fonte_cidades as (
        select
           cast(addressid as int) as id_cidade
           , cast(addressline1 as string) as endereco_cidade
           , cast(city as string) as nome_cidade
           , cast(stateprovinceid as int) as id_estado
           , cast(postalcode as string) as codigo_postal_cidade
        from {{ source('sap-adw', 'address') }}
    )

select * from fonte_cidades