with
    fonte_subcategorias_produtos as (
        select
            cast(productsubcategoryid as int) as id_subcategoria_produto
            , cast(productcategoryid as int) as id_categoria_produto
            , cast(name as string) as nome_subcategoria_produto
        from {{ source('sap_adw', 'productsubcategory') }}
    )

select * from fonte_subcategorias_produtos