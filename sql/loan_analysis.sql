-- Bank Loan Portfolio Analysis
-- Dataset: synthetic educational dataset (not real customer/bank data)

-- 1. Overall portfolio KPIs
SELECT
    COUNT(*) AS total_applications,
    SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(100.0 * SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS approval_rate_pct,
    SUM(CASE WHEN Loan_Status = 'Approved' THEN Loan_Amount_INR ELSE 0 END) AS approved_loan_value
FROM loan_data;

-- 2. Approval rate by employment type
SELECT
    Employment_Type,
    COUNT(*) AS applications,
    SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) AS approvals,
    ROUND(100.0 * SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS approval_rate_pct
FROM loan_data
GROUP BY Employment_Type
ORDER BY approval_rate_pct DESC;

-- 3. Approval rate by loan purpose
SELECT
    Loan_Purpose,
    COUNT(*) AS applications,
    ROUND(AVG(CASE WHEN Loan_Status = 'Approved' THEN 1.0 ELSE 0.0 END) * 100, 2) AS approval_rate_pct,
    ROUND(AVG(Loan_Amount_INR), 0) AS avg_loan_amount
FROM loan_data
GROUP BY Loan_Purpose
ORDER BY approval_rate_pct DESC;

-- 4. Credit-score segments
SELECT
    CASE
        WHEN Credit_Score < 600 THEN 'Below 600'
        WHEN Credit_Score < 700 THEN '600-699'
        WHEN Credit_Score < 750 THEN '700-749'
        ELSE '750+'
    END AS credit_band,
    COUNT(*) AS applications,
    ROUND(AVG(CASE WHEN Loan_Status = 'Approved' THEN 1.0 ELSE 0.0 END) * 100, 2) AS approval_rate_pct,
    ROUND(AVG(CASE WHEN Default_Flag = 'Yes' THEN 1.0 ELSE 0.0 END) * 100, 2) AS default_rate_pct
FROM loan_data
GROUP BY credit_band
ORDER BY credit_band;

-- 5. Default rate among approved loans
SELECT
    Loan_Purpose,
    COUNT(*) AS approved_loans,
    SUM(CASE WHEN Default_Flag = 'Yes' THEN 1 ELSE 0 END) AS defaults,
    ROUND(100.0 * SUM(CASE WHEN Default_Flag = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
WHERE Loan_Status = 'Approved'
GROUP BY Loan_Purpose
ORDER BY default_rate_pct DESC;
