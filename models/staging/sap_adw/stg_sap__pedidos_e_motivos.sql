with
    fonte_pedidos_e_motivos as (
        select
            cast(salesorderid as int) as id_pedido
            , cast(salesreasonid as int) as id_motivo
        from {{ source('sap_adw', 'salesorderheadersalesreason') }}
    )

select * from fonte_pedidos_e_motivos