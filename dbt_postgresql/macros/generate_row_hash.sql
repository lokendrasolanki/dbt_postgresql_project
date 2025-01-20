{% macro generate_row_hash(columns) %}
    {% if not columns %}
        {{ exceptions.raise_compiler_error("No columns provided for hashing") }}
    {% endif %}

    {% set columns_list = columns if columns is iterable and columns is not string else [columns] %}
    
    CAST(MD5(CONCAT(
        {% for column in columns_list %}
            COALESCE(CAST({{ column }} AS VARCHAR), '')
            {% if not loop.last %} || '|' || {% endif %}
        {% endfor %}
    )) AS VARCHAR(32))
{% endmacro %}