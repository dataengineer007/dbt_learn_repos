{{ config(materialized='table',
database='RAW',
alias='DQ_NULL_CHECK_EXPENSE_CLAIMS'
) }}



WITH dq_check AS (
{{ check_nulls(ref('stg_expense_claims'), ['claim_id', 'employee_id', 'claimed_amount']) }}
)


SELECT *
FROM dq_check
WHERE null_check_status = 'FAIL'