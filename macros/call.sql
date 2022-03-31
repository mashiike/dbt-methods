{%- macro call() %}
    {%- if (varargs | length) == 3 %}
        {%- set package_name = varargs[0] %}
        {%- set model_name = varargs[1] %}
        {%- set method_name = varargs[2] %}
    {%- else %}
        {%- set package_name = model['package_name'] %}
        {%- set model_name = varargs[0] %}
        {%- set method_name = varargs[1] %}
    {%- endif %}
    {%- set arguments = kwargs %}
    {% if execute %}
        {%- set method_config = dbt_methods.get_method(pacakge_name, model_name, method_name) %}
        {%- if method_config is none %}
            {%- set message =  "Model '"~model['unique_id'] ~ "' ("~ model['original_file_path']~") call on a method named '" ~ model_name ~"'.'" ~ method_name ~"'" %}
            {% if package_name != model['package_name'] %}
                {%- set message = message ~ " in package '" ~ package_name ~ "'" %}
            {% endif %}
            {{ exceptions.raise_compiler_error(message)}}
        {%- endif %}
        {%- set unrendered_sql %}
            {%- for argument_name, value in arguments.items() %}
            {{ "{%- set " ~ argument_name ~ " = '" ~ value ~ "' -%}" }}
            {%- endfor %}
            {{ method_config['sql'] }}
        {%- endset %}
        {{ return(render(unrendered_sql)) }}
    {% else %}
        select * from {{ ref(package_name, model_name) }}
    {% endif %}
{%- endmacro %}

{%- macro get_method(package_name, model_name, method_name) %}
    {%- set node = graph.nodes.values()
        | selectattr("pacakge_name", "equalto", pacakge_name)
        | selectattr("name", "equalto", model_name)
        | first %}
    {%- if node is none %}
        {{ return(none) }}
    {%- endif %}
    {%- if node['config'] is none %}
        {{ return(none) }}
    {%- endif %}
    {%- set methods = node['config']['methods'] %}
    {%- if methods is none %}
        {{ return(none) }}
    {%- endif %}
    {{ return(methods[method_name]) }}
{%- endmacro %}
