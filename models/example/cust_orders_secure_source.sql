{{ config(
  materialized='view',
  secure = true,
  database='snowflake_dt',
  schema='public'
) }}

select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.total_amount,
  c.name as customer_name,
  c.email as customer_email
from
  SNOWFLAKE_DT.PUBLIC.RAW_ORDERS o
join
  SNOWFLAKE_DT.PUBLIC.RAW_CUSTOMERS c
on
  o.customer_id = c.customer_id 