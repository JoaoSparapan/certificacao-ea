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
            {{ dbt_utils.generate_surrogate_key(['pedidos_motivos.id_motivo','pedidos_motivos.id_pedido','motivos_vendas.nome_motivo']) }} as sk_motivo_venda
            , pedidos_motivos.id_pedido
            , motivos_vendas.nome_motivo
        from stg_pedidos_motivos pedidos_motivos
        left join stg_motivos_vendas motivos_vendas on pedidos_motivos.id_motivo = motivos_vendas.id_motivo
    )

select * from joined_tabelas