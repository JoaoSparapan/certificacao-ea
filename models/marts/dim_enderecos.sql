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

    , stg_territorios as (
        select * from {{ ref('stg_sap__territorios') }}
    )

    , joined_tabelas as (
        select
            row_number() over (order by cidades.id_cidade) as sk_endereco
            , cidades.id_cidade
            , territorios.id_territorio
            , cidades.nome_cidade
            , cidades.codigo_postal_cidade
            , cidades.endereco_cidade
            , estados.codigo_estado
            , paises.codigo_pais
            , estados.nome_estado
            , paises.nome_pais
            , territorios.nome_territorio
            , territorios.grupo_territorio

        from stg_cidades cidades
        left join stg_estados estados on estados.id_estado = cidades.id_estado
        left join stg_paises paises on paises.codigo_pais = estados.codigo_pais
        left join stg_territorios territorios on paises.codigo_pais = territorios.codigo_pais_territorio
    )

select * 
from joined_tabelas