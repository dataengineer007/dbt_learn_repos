{% macro check_null_conditions(column_list) %}
    {% set conditions = [] %}
    {% for col in column_list %}
        {% do conditions.append(col ~ ' IS NULL') %}
    {% endfor %}
    ({{ conditions | join(' OR ') }})
{% endmacro %}