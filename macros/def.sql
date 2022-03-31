{%- macro def(method_name) %}
    {%- set method_config = dbt_methods.build_method_config(
        method_name,
        caller(),
        kwargs['arguments'],
    ) %}
    {% do dbt_methods.add_method(method_config) %}
{%- endmacro %}

{%- macro argument(name) %}
    {{ return ('{{ ' ~ name ~ ' }}') }}
{%- endmacro -%}

{%- macro add_method(method_config) %}
    {%- if not execute %}
        {%- set methods = config.get('methods', '') %}
        {%- if methods == '' %}
            {%- set methods = {} %}
        {%- endif %}
        {%- do methods.update({ method_config['name']: method_config }) %}
        {{ config.set("methods", methods) }}
    {%- endif %}
{%- endmacro %}
