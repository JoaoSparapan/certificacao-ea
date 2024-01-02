with
     stg_vendedores as (
        select
            *
        from {{ ref('stg_sap__vendedores') }}
    )

    , stg_funcionarios as (
        select
            *
        from {{ ref('stg_sap__funcionarios') }}
    )

    , stg_pessoas as (
        select
            *
        from {{ ref('stg_sap__pessoas') }}
    )

    , first_join as (
        select
            vendedores.*
            , funcionarios.*
        from stg_vendedores vendedores
        left join stg_funcionarios funcionarios  
            on vendedores.id_vendedor = funcionarios.id_funcionario
    )

    , final_join as (
        select 
            first_join.id_vendedor
            , pessoas.nome_pessoa as nome_vendedor
            , first_join.cargo_funcionario as cargo_vendedor
            , first_join.genero_funcionario as genero_vendedor
            , first_join.data_contratacao_funcionario as data_contratacao_vendedor
            , first_join.meta_anual
        from first_join
        left join stg_pessoas pessoas
            on first_join.id_funcionario = pessoas.id_pessoa
        order by id_vendedor
    )

    select * from final_join