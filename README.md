# dbt-methods
It is an experimental and proof-of-concept package that does OOP-like things with DBT

## Installation

Add to your packages.yml
```yaml
packages:
  - git: "https://github.com/mashiike/dbt-methods"
    revision: v0.0.0
```

## QuickStart 

models/sample.sql
```sql
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

```

models/depends_on.sql
```sql
{{
    config(
        materialized='view',
    )
}}

with base as (
    {{ dbt_methods.call('sample', 'prefix_added', prefix='hoge') }}
)

select * from base
```

The model of depends_on drawn is as follows:
```sql
with base as (
    select 'hoge' || name as name
    from "postgres".public.sample
)

select * from base
```

## LICENSE

MIT 
