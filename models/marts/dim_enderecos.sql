with
    stg_cidades as (
        select
            *
        from {{ ref('stg_sap__cidades') }}
    )

    , stg_estados as (
        select
            *
        from {{ ref('stg_sap__estados') }}
    )

    , stg_paises as (
        select
            *
        from {{ ref('stg_sap__paises') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by cidades.id_cidade) as sk_endereco
            , cidades.id_cidade
            , cidades.nome_cidade
            , cidades.codigo_postal_cidade
            , cidades.endereco_cidade
            , estados.codigo_estado
            , paises.codigo_pais
            , estados.nome_estado
            , paises.nome_pais

        from stg_cidades as cidades
        left join stg_estados as estados on estados.id_estado = cidades.id_estado
        left join stg_paises as paises on paises.codigo_pais = estados.codigo_pais
    )

select * 
from joined_tabelas