with
    fonte_funcionarios as (
        select
            cast(businessentityid as int) as id_funcionario
            , cast(jobtitle as string) as cargo_funcionario
            , cast(gender as string) as genero_funcionario
            , cast(hiredate as date) as data_contratacao_funcionario
        from {{ source('sap_adw', 'employee') }}
    )

    select * from fonte_funcionarios