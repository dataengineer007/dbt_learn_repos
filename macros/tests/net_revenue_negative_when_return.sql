{% test net_revenue_negative_when_returned(model, column_name) %}


SELECT *
FROM {{ model }}
WHERE 
    {{ column_name }} > 50000
    AND RETURN_REASON != 'RETURNED'


 -- {{ column_name }} < 0  -- Previous condition (deprecated)


{% endtest %}
