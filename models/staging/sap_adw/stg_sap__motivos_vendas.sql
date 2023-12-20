with
    fonte_motivos_vendas as (
        select
            cast(salesreasonid as int) as id_motivo
            , cast(name as string) as nome_motivo
            , cast(reasontype as string) as tipo_motivo
        from {{ source('sap_adw', 'salesreason') }}
    )

select * from fonte_motivos_vendas