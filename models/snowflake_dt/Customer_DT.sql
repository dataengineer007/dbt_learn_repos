{{ config(
    materialized='dynamic_table'
    , snowflake_warehouse = 'COMPUTE_WH'
    , database='SNOWFLAKE_DT_NEW'
    , schema='Transform_DT'
    , target_lag = 'DOWNSTREAM'
    
)}}

With Customers_DT as 
(
select cust_id,cust_name,total_outstanding_amt,CRID,location,CUST_CREATED from 
SNOWFLAKE_DT.public.customer qualify row_number() 
over (partition by cust_id  order by cust_created desc) = 1
)
select * from Customers_DT