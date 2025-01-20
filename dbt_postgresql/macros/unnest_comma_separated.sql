{% macro unnest_comma_separated(column_name) %}
  unnest(string_to_array({{ column_name }}, ', '))
{% endmacro %}