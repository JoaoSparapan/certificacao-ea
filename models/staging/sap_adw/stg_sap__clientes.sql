with
    fonte_clientes as (
        select
            cast(customerid as int) as id_cliente
            , cast(personid as int) as id_pessoa
            , cast(storeid as int) as id_loja_cliente
            , cast(territoryid as int) as id_territorio_cliente
        from {{ source('sap_adw', 'customer') }}
    )

select * from fonte_clientes