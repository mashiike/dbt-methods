{%- macro build_method_config(method_name, method_sql, arguments) %}
    {%- if arguments is not defined or arguments is none %}
        {% set argumetns = [] %}
    {%- endif %}
    {{ return({
        'name': method_name,
        'sql': method_sql,
        'arguments': arguments,
    })}}
{%- endmacro %}
