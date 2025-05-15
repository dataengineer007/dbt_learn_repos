{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT_NEW'
    , target_lag = 'DOWNSTREAM'
    , schema='Transform_DT'
)}}


With Accessory_DT as 
(
select a.cust_id,a.acc_id,acc_category,acc_status,price,acc_count from 
SNOWFLAKE_DT.public.accessory_item a,
 (select cust_id,acc_id,max(acc_price)price from SNOWFLAKE_DT.public.Accessory_item group by cust_id,acc_id) max_price
 where a.cust_id = max_price.cust_id 
 and a.acc_id = max_price.acc_id and a.acc_price = max_price.price
)
select * from Accessory_DT
