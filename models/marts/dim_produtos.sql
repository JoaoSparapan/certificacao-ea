with
    stg_categorias_produtos as (
        select * from {{ ref('stg_sap__categorias_produtos') }}
    )

    , stg_subcategorias_produtos as (
        select * from {{ ref('stg_sap__subcategorias_produtos') }}
    )

    , stg_produtos as (
        select * from {{ ref('stg_sap__produtos') }}
    )

    , joined_tabelas as (
        select
            produtos.id_produto
            , produtos.nome_produto
            , categorias_produtos.nome_categoria_produto
            , subcategorias_produtos.nome_subcategoria_produto
            , produtos.quantidade_minima_produto
            , produtos.nivel_reabastecimento_produto
            , produtos.custo_produto
            , produtos.preco_listado_produto
        from stg_produtos produtos
        LEFT JOIN stg_subcategorias_produtos subcategorias_produtos ON produtos.id_subcategoria_produto = subcategorias_produtos.id_subcategoria_produto
        LEFT JOIN stg_categorias_produtos categorias_produtos ON subcategorias_produtos.id_categoria_produto = categorias_produtos.id_categoria_produto
    )

select * from joined_tabelas