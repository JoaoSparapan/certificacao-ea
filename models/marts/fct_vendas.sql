with
    enderecos as (
        select * from {{ ref('dim_enderecos') }}
    )

    , produtos as (
        select * from {{ ref('dim_produtos') }}
    )

    , clientes as (
        select * from {{ ref('dim_clientes') }}
    )

    , cartoes as (
        select * from {{ ref('dim_cartoes') }}
    )

    , motivos_vendas as (
        select * from {{ ref('dim_motivos_vendas') }}
    )

    , pedido_itens as (
        select * from {{ ref('int_vendas__pedido_itens') }}
    )

    , joined_tables as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedido_itens.id_pedido', 'produtos.id_produto', 'motivos_vendas.sk_motivo_venda']) }} as sk_venda
            , pedido_itens.id_pedido
            , produtos.id_produto
            , motivos_vendas.sk_motivo_venda
            , pedido_itens.quantidade_ordem_detalhe
            , pedido_itens.preco_unitario_ordem
            , pedido_itens.desconto_percentual_por_unidade
            , pedido_itens.data_pedido
            , pedido_itens.data_faturamento
            , pedido_itens.data_envio
            , pedido_itens.status
            , pedido_itens.venda_online
            , pedido_itens.valor_pedido
            , pedido_itens.valor_impostos
            , pedido_itens.valor_frete
            , pedido_itens.valor_pedido_total
            , produtos.nome_produto
            , produtos.nome_categoria_produto
            , produtos.nome_subcategoria_produto
            , produtos.quantidade_minima_produto
            , produtos.nivel_reabastecimento_produto
            , produtos.custo_produto
            , produtos.preco_listado_produto
            , clientes.nome_cliente
            , clientes.nome_loja
            , enderecos.nome_cidade
            , enderecos.codigo_postal_cidade
            , enderecos.nome_estado
            , enderecos.nome_pais
            , enderecos.nome_territorio
            , enderecos.grupo_territorio
            , motivos_vendas.nome_motivo
            , motivos_vendas.tipo_motivo
            , cartoes.tipo_cartao
        from pedido_itens
        left join produtos on pedido_itens.id_produto = produtos.id_produto
        left join motivos_vendas on pedido_itens.id_pedido = motivos_vendas.id_pedido
        left join clientes on pedido_itens.id_cliente = clientes.id_cliente
        left join enderecos on pedido_itens.id_endereco = enderecos.sk_endereco
        left join cartoes on pedido_itens.id_cartao_credito = cartoes.id_cartao
    )

    , refined_table as (
        select *
        , (preco_unitario_ordem * quantidade_ordem_detalhe) as valor_total_negociado
        , (preco_unitario_ordem * quantidade_ordem_detalhe) * (1 - desconto_percentual_por_unidade) as valor_total_negociado_liquido
        , valor_frete / count(*) over(partition by id_pedido) as frete_por_item
        , valor_impostos / count(*) over(partition by id_pedido) as imposto_por_item
        from joined_tables
    )

select * from refined_table