with
    fonte_pessoas as (
        select
            cast(businessentityid as int) as id_pessoa
            , cast(persontype as string) as tipo_pessoa
            , cast(title as string) as prefixo_pessoa
            , cast(firstname as string) as primeiro_nome_pessoa
            , cast(middlename as string) as nome_meio_pessoa
            , cast(lastname as string) as sobrenome_pessoa
            , cast(suffix as string) as sufixo_pessoa
        from {{ source('sap_adw', 'person') }}
    )

    , agg_name as (
        select
            *
            , TRIM(CONCAT(COALESCE(prefixo_pessoa,' '),' ',primeiro_nome_pessoa,' ',COALESCE(nome_meio_pessoa,' '), ' ', sobrenome_pessoa, ' ', COALESCE(sufixo_pessoa,' '))) AS nome_pessoa
        from fonte_pessoas
    )

select * from agg_name