with
    fonte_ordem_detalhes as (
        select
            cast(salesorderid as int) as id_pedido
            , cast(salesorderdetailid as int) as id_detalhe_pedido
            , cast(productid as int) as id_produto
            , cast(specialofferid as int) as id_oferta
            , cast(orderqty as int) as quantidade_ordem_detalhe
            , cast(unitprice as numeric) as preco_unitario_ordem
            , cast(unitpricediscount as numeric) as desconto_percentual_por_unidade
        from {{ source('sap_adw', 'salesorderdetail') }}
    )

select * from fonte_ordem_detalhes