
WITH base AS (
    SELECT * FROM {{ ref('stg_ranked_claims') }}
),

dq_check AS (
    SELECT *,
        CASE 
            WHEN ({{ check_null_conditions(['claim_id', 'employee_id', 'claimed_amount']) }}) THEN 'FAIL'
            ELSE 'PASS'
        END AS dq_status,
        CASE
            WHEN claimed_amount > 10000 AND expense_type IN ('TRAVEL', 'HOTEL') THEN 'VIOLATION'
            ELSE 'OK'
        END AS policy_violation_flag
    FROM base
)

SELECT
    claim_id,
    employee_id,
    claim_date,
    expense_type,
    claimed_amount,
    currency,
    approval_status,
    approver_id,
    dq_status,
    policy_violation_flag
FROM dq_check
WHERE dq_status = 'PASS'
