USE banking_analysis;

-- 1. Verify total records
SELECT COUNT(*) AS Total_Rows
FROM banking_transactions;

-- 2. Overall transaction summary
SELECT
    COUNT(*) AS Total_Transactions,
    SUM(Transaction_Amount) AS Total_Amount,
    AVG(Transaction_Amount) AS Average_Amount,
    MIN(Transaction_Amount) AS Minimum_Amount,
    MAX(Transaction_Amount) AS Maximum_Amount
FROM banking_transactions;

-- 3. Date range
SELECT
    MIN(Transaction_Date) AS Start_Date,
    MAX(Transaction_Date) AS End_Date
FROM banking_transactions;

-- 4. Transaction mode analysis
SELECT
    Transaction_Mode,
    COUNT(*) AS Transaction_Count,
    SUM(Transaction_Amount) AS Total_Amount,
    AVG(Transaction_Amount) AS Average_Amount
FROM banking_transactions
GROUP BY Transaction_Mode
ORDER BY Transaction_Count DESC;

-- 5. Transaction type analysis
SELECT
    Transaction_Type,
    COUNT(*) AS Transaction_Count,
    SUM(Transaction_Amount) AS Total_Amount,
    AVG(Transaction_Amount) AS Average_Amount
FROM banking_transactions
GROUP BY Transaction_Type
ORDER BY Transaction_Count DESC;

-- 6. Monthly transaction analysis
SELECT
    Year,
    Month,
    Month_Name,
    COUNT(*) AS Transaction_Count,
    SUM(Transaction_Amount) AS Total_Amount,
    AVG(Transaction_Amount) AS Average_Amount
FROM banking_transactions
GROUP BY Year, Month, Month_Name
ORDER BY Year, Month;

-- 7. High-value transaction analysis
SELECT
    COUNT(*) AS High_Value_Transactions,
    SUM(Transaction_Amount) AS High_Value_Total_Amount,
    AVG(Transaction_Amount) AS High_Value_Average_Amount
FROM banking_transactions
WHERE High_Value_Flag = 1;

-- 8. High-value transactions by mode
SELECT
    Transaction_Mode,
    COUNT(*) AS High_Value_Count,
    SUM(Transaction_Amount) AS High_Value_Total,
    AVG(Transaction_Amount) AS High_Value_Average
FROM banking_transactions
WHERE High_Value_Flag = 1
GROUP BY Transaction_Mode
ORDER BY High_Value_Count DESC;

-- 9. High-value transactions by mode and type
SELECT
    Transaction_Mode,
    Transaction_Type,
    COUNT(*) AS High_Value_Count,
    SUM(Transaction_Amount) AS High_Value_Total,
    AVG(Transaction_Amount) AS High_Value_Average
FROM banking_transactions
WHERE High_Value_Flag = 1
GROUP BY Transaction_Mode, Transaction_Type
ORDER BY High_Value_Count DESC;

-- 10. High-value transactions by year
SELECT
    Year,
    COUNT(*) AS High_Value_Count,
    SUM(Transaction_Amount) AS High_Value_Total
FROM banking_transactions
WHERE High_Value_Flag = 1
GROUP BY Year
ORDER BY Year;

-- 11. Risk-level analysis
SELECT
    Risk_Level,
    COUNT(*) AS Transaction_Count,
    SUM(Transaction_Amount) AS Total_Amount
FROM banking_transactions
GROUP BY Risk_Level
ORDER BY Transaction_Count DESC;

-- 12. Account-level analysis using HAVING
SELECT
    Account_Number,
    COUNT(*) AS Transaction_Count,
    SUM(Transaction_Amount) AS Total_Amount,
    AVG(Transaction_Amount) AS Average_Amount
FROM banking_transactions
GROUP BY Account_Number
HAVING SUM(Transaction_Amount) > 49085225.89
ORDER BY Total_Amount DESC
LIMIT 20;

-- 13. High-value transactions by transaction type
SELECT
    Transaction_Type,
    COUNT(*) AS High_Value_Count,
    SUM(Transaction_Amount) AS High_Value_Total
FROM banking_transactions
WHERE High_Value_Flag = 1
GROUP BY Transaction_Type
ORDER BY High_Value_Count DESC;

-- 14. CASE statement for transaction categorization
SELECT
    Transaction_ID,
    Account_Number,
    Transaction_Amount,
    CASE
        WHEN High_Value_Flag = 1 THEN 'High Value'
        ELSE 'Normal'
    END AS Transaction_Category
FROM banking_transactions
LIMIT 20;