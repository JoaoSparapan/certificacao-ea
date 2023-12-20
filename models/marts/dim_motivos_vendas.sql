with
    stg_pedidos_motivos as (
        select
            *
        from {{ ref('stg_sap__pedidos_e_motivos') }}
    )

    , stg_motivos_vendas as (
        select
            *
        from {{ ref('stg_sap__motivos_vendas') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by pedidos_motivos.id_motivo) as sk_motivo_venda
            , pedidos_motivos.id_pedido
            , pedidos_motivos.id_motivo
            , motivos_vendas.nome_motivo
            , motivos_vendas.tipo_motivo
        from stg_pedidos_motivos as pedidos_motivos
        left join stg_motivos_vendas as motivos_vendas on pedidos_motivos.id_motivo = motivos_vendas.id_motivo
    )


select * from joined_tabelas