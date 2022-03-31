

with base as (
    {{ dbt_methods.call('sample', 'prefix_added', prefix='hoge') }}
)

select * from base
