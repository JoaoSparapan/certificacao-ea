with
    fonte_produtos as (
        select
            cast(productid as int) as id_produto
            , cast(productsubcategoryid as int) as id_subcategoria_produto
            , cast(name as string) as nome_produto
            , cast(safetystocklevel as string) as quantidade_minima_produto
            , cast(reorderpoint as string) as nivel_reabastecimento_produto
            , cast(standardcost as numeric) as custo_produto
            , cast(listprice as numeric) as preco_listado_produto
        from {{ source('sap_adw', 'product') }}
        -- where productsubcategoryid is not null
    )

select * from fonte_produtos