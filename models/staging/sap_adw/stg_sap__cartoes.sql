with
    fonte_cartoes as (
        select
            cast(creditcardid as int) as id_cartao
            , cast(cardtype as string) as tipo_cartao
        from {{ source('sap-adw', 'creditcard') }}
    )

select * from fonte_cartoes