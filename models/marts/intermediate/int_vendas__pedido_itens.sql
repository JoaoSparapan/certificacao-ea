with 
    stg_ordens as (
    select * 
    from {{ ref('stg_sap__ordens') }}
    )

    , stg_ordem_detalhes as (
        select * 
        from {{ ref('stg_sap__ordem_detalhes') }}
    )

    , joined_tables as (
        select
            cast(ordens.id_pedido|| '-' || ordem_detalhes.id_produto as string) as pk_vendas 
            , ordens.id_pedido 
            , ordens.id_cliente
            , ordens.id_vendedor
            , ordens.id_territorio 
            , ordens.id_endereco
            , ordens.id_metodo_envio
            , ordens.id_cartao_credito
            , ordens.id_cambio
            , ordem_detalhes.id_detalhe_pedido
            , ordem_detalhes.id_produto
            , ordem_detalhes.id_oferta
            , ordem_detalhes.quantidade_ordem_detalhe
            , ordem_detalhes.preco_unitario_ordem
            , ordem_detalhes.desconto_percentual_por_unidade
            , ordens.data_pedido
            , ordens.data_faturamento
            , ordens.data_envio
            , ordens.status
            , ordens.venda_online
            , ordens.valor_pedido 
            , ordens.valor_impostos
            , ordens.valor_frete
            , ordens.valor_pedido_total
        from stg_ordem_detalhes ordem_detalhes
        left join stg_ordens ordens on ordem_detalhes.id_pedido = ordens.id_pedido
    )

select * from joined_tables