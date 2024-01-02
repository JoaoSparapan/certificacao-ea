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

    , vendedores as (
        select * from {{ ref('dim_vendedores') }}
    )

    , joined_tables as (
        select
            {{ dbt_utils.generate_surrogate_key(['pedido_itens.id_pedido', 'produtos.id_produto']) }} as sk_venda
            , pedido_itens.id_pedido
            , pedido_itens.id_cliente
            , pedido_itens.id_cartao_credito
            , pedido_itens.id_endereco
            , motivos_vendas.sk_motivo_venda
            , produtos.id_produto
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
            , cartoes.tipo_cartao
            , motivos_vendas.nome_motivo
            , vendedores.nome_vendedor
            , vendedores.cargo_vendedor
            , vendedores.genero_vendedor
            , vendedores.data_contratacao_vendedor
            , vendedores.meta_anual
        from pedido_itens
        left join produtos on pedido_itens.id_produto = produtos.id_produto
        left join clientes on pedido_itens.id_cliente = clientes.id_cliente
        left join enderecos on pedido_itens.id_endereco = enderecos.sk_endereco
        left join cartoes on pedido_itens.id_cartao_credito = cartoes.id_cartao
        left join motivos_vendas on pedido_itens.id_pedido = motivos_vendas.id_pedido
        left join vendedores on pedido_itens.id_vendedor = vendedores.id_vendedor
    )

    , refined_table as (
        select 
            *
            , count(*) over(partition by sk_venda) as vezes_que_aparece
            , quantidade_ordem_detalhe/count(*) over(partition by sk_venda) as quantidade_por_linha
            , (preco_unitario_ordem * quantidade_ordem_detalhe)/count(*) over(partition by sk_venda) as valor_total_negociado
            , ((preco_unitario_ordem * quantidade_ordem_detalhe) - (1 - desconto_percentual_por_unidade))/count(*) over(partition by sk_venda) as valor_total_negociado_liquido
            , valor_frete / count(*) over(partition by id_pedido) as frete_por_item
            , valor_impostos / count(*) over(partition by id_pedido) as imposto_por_item
        from joined_tables
    )

    , add_atp as (
        select
            *
            , (valor_total_negociado_liquido / vezes_que_aparece) as ticket_medio_por_linha
        from refined_table
    )

    select * from add_atp
