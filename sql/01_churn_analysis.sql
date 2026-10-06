-- Telecom Churn Analytics: Business Queries
USE telecom_churn;
GO

-- 1. Overall churn
SELECT Churn, COUNT(*) AS customers
FROM telco_customers
GROUP BY Churn;

-- 2. Churn rate by contract type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- 3. Monthly revenue lost to churn
SELECT
    SUM(MonthlyCharges) AS total_monthly_revenue,
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS monthly_revenue_lost,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 100 / SUM(MonthlyCharges), 2) AS revenue_lost_pct
FROM telco_customers;

-- 4. Churn rate by internet service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- 5. Average monthly bill by internet service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_bill
FROM telco_customers
GROUP BY InternetService
ORDER BY avg_monthly_bill DESC;

-- 6. Churn rate by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

-- 7. Churn rate by tenure group
SELECT
    CASE
        WHEN tenure <= 12 THEN '1) 0-12 months'
        WHEN tenure <= 24 THEN '2) 13-24 months'
        WHEN tenure <= 48 THEN '3) 25-48 months'
        ELSE '4) 49-72 months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 / COUNT(*), 2) AS churn_rate_pct
FROM telco_customers
GROUP BY
    CASE
        WHEN tenure <= 12 THEN '1) 0-12 months'
        WHEN tenure <= 24 THEN '2) 13-24 months'
        WHEN tenure <= 48 THEN '3) 25-48 months'
        ELSE '4) 49-72 months'
    END
ORDER BY tenure_group;