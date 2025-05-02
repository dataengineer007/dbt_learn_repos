{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT'
    , target_lag = '3 MINUTES'
    , schema='Transform_DT'
)}}

With Cust_Accessory_DT as 
(
select c.cust_id,c.cust_name,c.crid,c.location,c.cust_created,a.acc_id,a.acc_category,a.acc_status,a.price,a.acc_count,a.price / a.acc_count Price_Per_Accessory
from {{ ref('Customer_DT') }} c,{{ ref('Accessory_DT') }} a where c.cust_id = a.cust_id

)
select * from Cust_Accessory_DT