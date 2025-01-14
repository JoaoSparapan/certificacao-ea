with
    fonte_ordens as (
        select 
            cast(salesorderid as int) as id_pedido
            , cast(customerid as int) as  id_cliente
            , cast(salespersonid as int) as  id_vendedor
            , cast(territoryid as int) as  id_territorio 
            , cast(billtoaddressid as int) as id_endereco_cobranca
            , cast(shiptoaddressid as int) as id_endereco
            , cast(shipmethodid as int) as id_metodo_envio
            , cast(creditcardid as int) as id_cartao_credito
            , cast(currencyrateid as int) as id_cambio
            , cast(orderdate as timestamp) as data_pedido
            , cast(duedate as timestamp) as data_faturamento
            , cast(shipdate as timestamp) as data_envio
            , cast(subtotal as numeric) as valor_pedido 
            , cast(taxamt as numeric) as valor_impostos
            , cast(freight as numeric) as valor_frete
            , cast(totaldue as numeric) as valor_pedido_total
            , case
                WHEN status = 1 then 'Em Andamento'
                WHEN status = 2 then 'Aprovado'
                WHEN status = 3 then 'Em espera'
                WHEN status = 4 then 'Rejeitado'
                WHEN status = 5 then 'Entregue'
                WHEN status = 6 then 'Cancelado'
            end status
            , cast(onlineorderflag as string) as venda_online
            , cast(accountnumber as string) as codigo_conta 

        from  {{ source('sap_adw', 'salesorderheader') }}
    )

select * from fonte_ordens