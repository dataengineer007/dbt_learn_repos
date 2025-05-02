WITH ranked_claims AS (
    SELECT
        claim_id,
        employee_id,
        claim_date,
        expense_type,
        claimed_amount,
        currency,
        approval_status,
        approver_id,
        ROW_NUMBER() OVER (PARTITION BY claim_id ORDER BY claim_date DESC) AS rn
    FROM RAW.PUBLIC.EXPENSE_CLAIMS
)

SELECT
    claim_id,
    employee_id,
    claim_date,
    UPPER(expense_type) AS expense_type,
    claimed_amount,
    currency,
    LOWER(approval_status) AS approval_status,
    approver_id
FROM ranked_claims
WHERE rn = 1