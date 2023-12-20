with 
    fonte_calendario as (

    select
     cast(format_date('%F', d) as date) as id_data
    ,cast(d as date) as data
    ,cast(extract(year from d) as int) as ano
    ,cast(extract(week from d) as int) as semana_ano
    ,cast(extract(day from d) as int) as dia_ano
    ,cast(extract(month from d) as int) as mes_ano
    ,cast(format_date('%B', d) as string) as nome_mes
    ,cast(format_date('%W', d) as int) as dia_da_semana
    ,cast(format_date('%A', d) as string) as nome_dia_da_semana
    ,cast((case when format_date('%A', d) in ('sunday', 'saturday') then true else false end) as bool) as dia_util,
    from ( 
        select *
        from unnest(generate_date_array('1990-01-01', '2045-01-01', interval 1 day)) as d 
    )
)
select * from fonte_calendario
