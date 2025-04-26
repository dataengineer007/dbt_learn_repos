
    

{% macro check_nulls(table_name, column_list) %}
{% set null_conditions = [] %}
{% for col in column_list %}
{% do null_conditions.append(col ~ ' IS NULL') %}
{% endfor %}


SELECT
*,
CASE
WHEN {{ null_conditions | join(' OR ') }} THEN 'FAIL'
ELSE 'PASS'
END AS null_check_status
FROM {{ table_name }}
{% endmacro %}