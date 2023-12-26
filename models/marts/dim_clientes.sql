with
    stg_pessoas as (
        select 
            TRIM(CONCAT(COALESCE(prefixo_pessoa,' '),' ',primeiro_nome_pessoa,' ',COALESCE(nome_meio_pessoa,' '), ' ', sobrenome_pessoa, ' ', COALESCE(sufixo_pessoa,' '))) AS nome_cliente
            , * 
        from {{ ref('stg_sap__pessoas') }}
    )
    , stg_clientes as (
        select * from {{ ref('stg_sap__clientes') }}
    )

    , stg_lojas as (
        select * from {{ ref('stg_sap__lojas') }}
    )

    , joined_tables as (
        select
            clientes.id_cliente
            , lojas.id_loja
            , pessoas.nome_cliente
            , lojas.nome_loja
        from stg_clientes clientes
        left join stg_pessoas pessoas on clientes.id_pessoa = pessoas.id_pessoa
        left join stg_lojas lojas on clientes.id_loja_cliente = lojas.id_loja
        where pessoas.id_pessoa is not null and lojas.id_loja is not null
    )

select * from joined_tables