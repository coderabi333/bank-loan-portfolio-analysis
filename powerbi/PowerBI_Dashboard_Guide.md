# Power BI Dashboard Guide

## Import
1. Open Power BI Desktop.
2. Select **Get Data → Text/CSV**.
3. Import `data/loan_data.csv`.
4. Confirm numeric data types:
   - Annual_Income_INR: Whole number
   - Loan_Amount_INR: Whole number
   - Credit_Score: Whole number
   - Debt_to_Income_Ratio: Decimal number
   - Interest_Rate_Pct: Decimal number

## Suggested KPI cards
- Total Applications
- Approval Rate
- Approved Loan Value
- Average Approved Loan
- Default Rate

## Suggested visuals
1. **Column chart:** Approval Rate by Employment Type
2. **Column chart:** Approved Loan Value by Loan Purpose
3. **Line/column chart:** Application count by Credit Band
4. **Donut chart:** Loan Status
5. **Bar chart:** Approved Loan Value by Region
6. **Scatter chart:** Credit Score vs Loan Amount, with Loan Status as legend
7. **Slicers:** Region, Employment Type, Loan Purpose, Loan Status

## Useful DAX measures
```DAX
Total Applications = COUNTROWS(loan_data)

Approved Applications =
CALCULATE(
    COUNTROWS(loan_data),
    loan_data[Loan_Status] = "Approved"
)

Approval Rate =
DIVIDE([Approved Applications], [Total Applications], 0)

Approved Loan Value =
CALCULATE(
    SUM(loan_data[Loan_Amount_INR]),
    loan_data[Loan_Status] = "Approved"
)

Average Approved Loan =
DIVIDE([Approved Loan Value], [Approved Applications], 0)

Defaulted Loans =
CALCULATE(
    COUNTROWS(loan_data),
    loan_data[Loan_Status] = "Approved",
    loan_data[Default_Flag] = "Yes"
)

Default Rate =
DIVIDE([Defaulted Loans], [Approved Applications], 0)
```

## Dashboard layout
Top row: KPI cards

Middle row:
- Approval Rate by Employment Type
- Loan Status distribution
- Approved Loan Value by Purpose

Bottom row:
- Credit Score vs Loan Amount
- Region-wise Loan Exposure
- Slicers
