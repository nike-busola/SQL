--create table in the schema
CREATE TABLE "Nexa_Sat".nexa_sat(
         Customer_id VARCHAR(50),
	     gender VARCHAR(10),
	     Partner VARCHAR(3),
	     Dependents VARCHAR(3),
	     Senior_Citizen INT,
	     Call_Duration FLOAT,
	     Data_Usage FLOAT,
	     Plan_Type VARCHAR (20),
	     Plan_Level VARCHAR(20),
	     Monthly_Bill_Amount FLOAT,
	     Tenure_Months INT,
	     Multiple_Lines VARCHAR(3),
	     Tech_Support VARCHAR(3),
	     Churn INT);

--confirm current schema
SELECT current_schema();

--set search path for queries
SET search_path TO "Nexa_Sat";

--view data
SELECT *
FROM nexa_sat;




--DATA CLEANING
--check for duplicates
SELECT Customer_id, gender, Partner, Dependents,
	Senior_Citizen, Call_Duration, Data_Usage,
	Plan_Type, Plan_Level, Monthly_Bill_Amount,
	Tenure_Months, Multiple_Lines, Tech_Support,
	Churn
FROM nexa_sat
GROUP BY Customer_id, gender, Partner, Dependents,
	Senior_Citizen, Call_Duration, Data_Usage,
	Plan_Type, Plan_Level, Monthly_Bill_Amount,
	Tenure_Months, Multiple_Lines, Tech_Support,
	Churn
HAVING COUNT(*) >1;-- this is to filter out rows that are duplicates


--check for null values
SELECT * 
FROM nexa_sat
WHERE customer_id IS NULL
OR gender IS NULL
OR Partner IS NULL 
OR Dependents IS NULL
OR Senior_Citizen IS NULL
OR Call_Duration IS NULL
OR Data_Usage IS NULL
OR Plan_Type IS NULL
OR Plan_Level IS NULL
OR Monthly_Bill_Amount IS NULL
OR Tenure_Months IS NULL
OR Multiple_Lines IS NULL
OR Tech_Support IS NULL
OR Churn IS NULL;




--EDA (Exploratory Data Analysis)
--total users
SELECT COUNT(customer_id) AS current_users
FROM nexa_sat
WHERE Churn = 0;


--total number of users by plan level
SELECT Plan_Level, COUNT(customer_id) AS total_users
FROM nexa_sat
WHERE Churn = 0
GROUP BY 1;


--total revenue
SELECT ROUND(SUM(Monthly_Bill_Amount::numeric),2) AS revenue
FROM nexa_sat;


--revenue by plan level
SELECT Plan_Level, ROUND(SUM(Monthly_Bill_Amount::numeric),2) AS revenue
FROM nexa_sat
GROUP BY 1
ORDER BY 2;


--Churn count by plan type and plan level
SELECT Plan_Level,
       Plan_Type,
       COUNT(*) AS total_customers,
       SUM(Churn) AS Churn_count
FROM nexa_sat
GROUP BY 1,2
ORDER BY 1;


--average tenure by level
SELECT Plan_Level, ROUND(AVG(Tenure_Months),2)
FROM nexa_sat
GROUP BY 1;




--MARKETING SEGMENTS
--Create table of only existing users
CREATE TABLE existing_users AS
SELECT *
FROM nexa_sat
WHERE churn = 0;


--view new table
SELECT * 
from existing_users;


--calculate ARPU (average revenue per user) for existing users
SELECT ROUND(AVG(Monthly_Bill_Amount::INT), 2) AS ARPU
FROM existing_users;


--calculate CLV (customer lifetime value) and add column
ALTER TABLE existing_users
ADD COLUMN clv FLOAT;

UPDATE existing_users
SET clv = Monthly_Bill_Amount * tenure_months;


--view new clv column
SELECT customer_id, clv
FROM existing_users;


--create clv score column
ALTER TABLE existing_users
ADD COLUMN clv_score NUMERIC(10,2);

--assign weights and calculate clv score
--monthly_bill = 40%, tenure = 30%, call_duration = 10%, data_usage = 10%, premium = 10%
UPDATE existing_users
SET clv_score =
	        (0.4 * Monthly_Bill_Amount) +
	        (0.3 * Tenure_Months) +
	        (0.1 * Call_Duration) +
	        (0.1 * Data_Usage) +
	        (0.1 * CASE WHEN Plan_Level = 'Premium'
	               THEN 1 ELSE 0
	               END);


--view new clv_score column
SELECT customer_id, clv_score
FROM existing_users;


--group users into segments based on clv_scores
ALTER TABLE existing_users
ADD COLUMN clv_segments VARCHAR;

UPDATE existing_users
SET clv_segments = 
    CASE WHEN clv_score > (SELECT percentile_cont(0.85) 
	                      WITHIN GROUP (ORDER BY clv_score) 
	                      FROM existing_users) THEN 'High Value'
        WHEN clv_score >= (SELECT percentile_cont(0.50) 
	                      WITHIN GROUP (ORDER BY clv_score) 
	                      FROM existing_users) THEN 'Moderate Value'
        WHEN clv_score >= (SELECT percentile_cont(0.25) 
	                      WITHIN GROUP (ORDER BY clv_score) 
	                      FROM existing_users) THEN 'Low Value'
        ELSE 'Churn Risk'
        END;
	
	
-- view segments
SELECT customer_id, clv, clv_score, clv_segments
FROM existing_users;




--ANALYZING THE SEGMENTS
--customer count per segments
SELECT clv_segments, COUNT(*) AS segments_count
FROM existing_users
GROUP BY clv_segments;


--average bill and tenure per segment 
SELECT clv_segments, 
       ROUND(AVG(monthly_bill_amount::INT),2) AS avg_monthly_charges,
       ROUND(AVG(tenure_months::INT),2) AS avg_tenure
FROM existing_users
GROUP BY 1;


--tech support and multiple/additional line count
SELECT clv_segments, 
       ROUND(AVG(CASE WHEN tech_support = 'Yes' THEN 1 ELSE 0 END),2) AS tech_support_pct,
       ROUND(AVG(CASE WHEN multiple_lines = 'Yes' THEN 1 ELSE 0 END),2) AS additional_line_pct
FROM existing_users
GROUP BY 1;


--revenue per segment
SELECT 
    clv_segments, COUNT(customer_id),
    CAST(SUM(Monthly_Bill_Amount * Tenure_Months) AS NUMERIC(10,2)) AS total_revenue
FROM existing_users
GROUP BY 1;




--CROSS-SELLING AND UP-SELLING
--cross selling: senior citizens who could use tech support
SELECT customer_id
FROM existing_users
WHERE Senior_Citizen = 1 --senior citizens
AND dependents = 'No' --no children or tech savvy helpers
AND tech_support = 'No' --no tech support
AND (clv_segments = 'Churn Risk' OR clv_segments = 'Low Value');
---Offering tech support to senior citizens without dependents leads to higher satisfaction, 
-- increased loyalty, reduced frustration and enhanced brand image, ultimately resulting 
-- in lower churn rates and potential for additional revenue through cross-selling.

--cross selling: multiple lines for dependents and partners on basic plan
SELECT customer_id
FROM existing_users
WHERE multiple_lines = 'No'
AND (dependents = 'Yes' OR partner = 'Yes')
AND plan_level = 'Basic';


--up-selling: premium discount for basic users with churn risk
SELECT customer_id
FROM existing_users
WHERE clv_segments = 'Churn Risk'
AND Plan_Level = 'Basic';


--up selling: basic to premium to longer lock in period and higher ARPU--
SELECT Plan_level, ROUND(AVG(Monthly_Bill_Amount::INT),2) AS average_bill, ROUND(AVG(Tenure_Months::INT),2) AS average_tenure
FROM existing_users
WHERE clv_segments = 'High Value'
OR clv_segments = 'Moderate Value'
GROUP BY 1;


--select higher paying customer ids for the upgrade offer
SELECT customer_id, Monthly_Bill_Amount
FROM existing_users
WHERE Plan_Level = 'Basic'
AND (clv_segmentS = 'High Value' OR clv_segments = 'Moderate Value')
AND Monthly_Bill_Amount > 150;
--Offering higher-paying customers cheaper plans with lock-in periods can 
--increase customer retention and lifetime value by reducing churn.
--This also creates customer's loyalty to the brand, not just due to the lock in
--but because customers appreciate discounts, especially when it appears like the brand is looking out for them.




 
--CREATE STORED PROCEDURES
--senior citizens who will be offered tech support
CREATE FUNCTION tech_support_snr_citizens() 
RETURNS TABLE (customer_id VARCHAR(50)) 
AS $$
BEGIN
    RETURN QUERY 
    SELECT eu.customer_id
    FROM existing_users eu
    WHERE eu.senior_citizen = 1 --senior citizens--
        AND eu.dependents = 'No' --no chidren or tech savvy helpers--
        AND eu.tech_support = 'No' --do not already have this service--
        AND (eu.clv_segments = 'Churn Risk' OR eu.clv_segments = 'Low Value');
END;
$$ LANGUAGE plpgsql;


--at risk customers who will be offered premium discount--
CREATE FUNCTION churn_risk_discount() 
RETURNS TABLE (customer_id VARCHAR(50)) 
AS $$
BEGIN
    RETURN QUERY 
	SELECT eu.customer_id
	FROM existing_users eu
	WHERE eu.clv_segments = 'Churn Risk'
	AND eu.Plan_Level = 'Basic';
END;
$$ LANGUAGE plpgsql;


--customers for multiple lines offer
CREATE FUNCTION multiple_lines_offer() 
RETURNS TABLE (customer_id VARCHAR(50)) 
AS $$
BEGIN
    RETURN QUERY 
	SELECT eu.customer_id
	FROM existing_users eu
	WHERE eu.multiple_lines = 'No'
	AND (eu.dependents = 'Yes' OR eU.partner = 'Yes')
	AND eu.Plan_Level = 'Basic';
	END;
$$ LANGUAGE plpgsql

	
--high usage customers who will be offered a premium upgrade
CREATE FUNCTION high_usage_basic() 
RETURNS TABLE (customer_id VARCHAR(50)) 
AS $$
BEGIN
    RETURN QUERY 
	SELECT eu.customer_id
	FROM existing_users eu
	WHERE eu.plan_level = 'Basic'
	AND (eu.clv_segments = 'High Value' OR eu.clv_segments = 'Moderate Value')
	AND eu.Monthly_Bill_Amount > 150;
END;
$$ LANGUAGE plpgsql;




-- USE PROCEDURES
SELECT * FROM tech_support_snr_citizens();

SELECT * FROM churn_risk_discount();

SELECT * FROM multiple_lines_offer();

SELECT * FROM high_usage_basic();


select *
from existing_users