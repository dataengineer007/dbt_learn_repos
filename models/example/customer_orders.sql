{{ config(
  materialized='table'
  ) }}

select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.total_amount,
  c.name as customer_name,
  c.email as customer_email
from
  {{ source('ecommerce', 'raw_orders') }} o
 
join
  {{ source('ecommerce', 'raw_customers') }} c
on
  o.customer_id = c.customer_id