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
            {{ dbt_utils.generate_surrogate_key(['pedidos_motivos.id_motivo']) }} as sk_motivo_venda
            , pedidos_motivos.id_pedido
            , motivos_vendas.nome_motivo
        from stg_pedidos_motivos pedidos_motivos
        left join stg_motivos_vendas motivos_vendas on pedidos_motivos.id_motivo = motivos_vendas.id_motivo
    )

    , transformation as (
        select
            id_pedido        
            , string_agg(nome_motivo, ', ') as nome_motivo_temp
        from joined_tabelas
        group by id_pedido
    )
    
    , add_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['transformation.id_pedido']) }} as sk_motivo_venda
            , transformation.id_pedido
            , ifnull(transformation.nome_motivo_temp,'Desconhecido') as nome_motivo
        from transformation
    )

select * from add_sk