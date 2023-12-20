with
    fonte_categorias_produtos as (
        select
            cast(productcategoryid as int) as id_categoria_produto
            , cast(name as string) as nome_categoria_produto
        from {{ source('sap_adw', 'productcategory') }}
    )

select * from fonte_categorias_produtos