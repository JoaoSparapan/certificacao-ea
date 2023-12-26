with
    vendas_em_2011 as (
        select sum(valor_total_negociado) as valor_total_bruto
        from {{ ref('fct_vendas') }}
        where date(data_pedido) between '2011-01-01' and '2011-12-31'
    )

select 
    valor_total_bruto
from vendas_em_2011
where valor_total_bruto not between 12646112.15 and 12646112.17