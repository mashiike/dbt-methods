{{
    config(
        materialized='view',
    )
}}

{%- call dbt_methods.def("prefix_added", arguments=["prefix"]) %}
    select '{{ dbt_methods.argument("prefix") }}' || name as name
    from {{ this }}
{%- endcall %}

{%- call dbt_methods.def("suffix_added", arguments=["suffix"]) %}
    select name || '{{ dbt_methods.argument("suffix") }}'as name
    from {{ this }}
{%- endcall %}

select 'hoge' as name
union all
select 'fuga'
union all
select 'piyo'
