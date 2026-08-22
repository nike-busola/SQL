# NexaSat Customer Analytics | SQL

## Project Overview

**NexaSat Customer Analytics** is a SQL-based customer analytics project designed to transform telecommunications customer data into actionable insights for **customer retention, revenue growth, customer segmentation, cross-selling, and upselling**.

The project uses SQL to analyze customer demographics, subscription plans, billing amounts, tenure, data usage, call duration, technical support, additional lines, and churn behavior.

Rather than focusing solely on descriptive reporting, the analysis goes further by developing **Customer Lifetime Value (CLV)** calculations and customer-value segments. These segments are then used to identify specific customers for targeted marketing campaigns, including:

* Retention offers
* Premium-plan upgrades
* Multiple-line offers
* Technical-support offers
* Discounts for customers at risk of churn

The project demonstrates how SQL can be used not only for querying and reporting but also for **customer intelligence and data-driven marketing strategy**.

---

# Business Objective

The primary business objective is to use customer data to answer four key business questions:

1. **Who are NexaSat's most valuable customers?**
2. **Which existing customers are at risk of churn?**
3. **Which customers are suitable targets for cross-selling and upselling?**
4. **How can customer-level insights be converted into actionable marketing campaigns?**

The analysis is designed to help NexaSat:

* Improve customer retention
* Increase customer lifetime value
* Reduce churn risk
* Increase average revenue per user
* Identify high-value customers
* Improve customer loyalty
* Generate additional revenue through cross-selling
* Generate additional revenue through upselling
* Develop targeted rather than broad marketing campaigns

---

# Dataset Overview

The dataset contains customer-level telecommunications information.

Each row represents an individual customer, identified by a unique `Customer_id`.

## Main Variables

| Column                | Description                                      |
| --------------------- | ------------------------------------------------ |
| `Customer_id`         | Unique customer identifier                       |
| `gender`              | Customer gender                                  |
| `Partner`             | Whether the customer has a partner               |
| `Dependents`          | Whether the customer has dependents              |
| `Senior_Citizen`      | Senior-citizen indicator                         |
| `Call_Duration`       | Customer call usage                              |
| `Data_Usage`          | Customer data usage                              |
| `Plan_Type`           | Type of subscription plan                        |
| `Plan_Level`          | Subscription level                               |
| `Monthly_Bill_Amount` | Customer's monthly billing amount                |
| `Tenure_Months`       | Number of months with NexaSat                    |
| `Multiple_Lines`      | Whether customer has multiple lines              |
| `Tech_Support`        | Whether customer subscribes to technical support |
| `Churn`               | Customer churn indicator                         |

---

# Project Workflow

The analysis follows a structured SQL analytics workflow:

```text
Raw Customer Data
        ↓
Database & Table Creation
        ↓
Data Quality Checks
        ↓
Exploratory Data Analysis
        ↓
Existing Customer Identification
        ↓
ARPU Calculation
        ↓
Customer Lifetime Value Calculation
        ↓
CLV Scoring
        ↓
Customer Segmentation
        ↓
Segment Analysis
        ↓
Churn-Risk Identification
        ↓
Cross-Selling Analysis
        ↓
Upselling Analysis
        ↓
Target Customer Views
        ↓
Business Recommendations
```

---

# 1. Database Setup

The project begins by creating the NexaSat database and defining the customer table.

```sql
CREATE DATABASE nexa_sat;

USE Nexa_Sat;
```

The customer table contains demographic, behavioral, subscription, financial, and churn-related variables.

This establishes the foundation for the subsequent analysis.

---

# 2. Data Exploration

The first step is to inspect the available customer records.

```sql
SELECT *
FROM NexaSat_data;
```

This allows the analyst to understand:

* Available fields
* Data structure
* Customer attributes
* Subscription information
* Billing information
* Behavioral variables
* Churn indicators

---

# 3. Data Cleaning & Quality Checks

Data quality is an important part of the project because inaccurate customer records can lead to incorrect segmentation and marketing decisions.

## Duplicate Check

The project checks for duplicate customer records using a `GROUP BY` across the customer attributes.

```sql
SELECT Customer_id, gender, Partner, Dependents,
       Senior_Citizen, Call_Duration, Data_Usage,
       Plan_Type, Plan_Level, Monthly_Bill_Amount,
       Tenure_Months, Multiple_Lines, Tech_Support,
       Churn
FROM NexaSat_data
GROUP BY Customer_id, gender, Partner, Dependents,
         Senior_Citizen, Call_Duration, Data_Usage,
         Plan_Type, Plan_Level, Monthly_Bill_Amount,
         Tenure_Months, Multiple_Lines, Tech_Support,
         Churn;
```

The commented `HAVING COUNT(*) > 1` condition can be activated to return only duplicated records.

This provides a practical approach to checking the uniqueness and consistency of customer records.

---

# 4. Null-Value Check

The project also checks for missing values across all important fields.

```sql
SELECT *
FROM NexaSat_data
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
```

This ensures that downstream calculations such as:

* Revenue
* ARPU
* CLV
* Tenure
* Customer segmentation

are not unintentionally affected by missing values.

---

# 5. Exploratory Data Analysis

The exploratory analysis establishes the core customer and revenue metrics.

## Current Customer Base

The project calculates the number of customers who have not churned.

```sql
SELECT COUNT(customer_id) AS current_users
FROM NexaSat_data
WHERE Churn = 0;
```

This creates a distinction between:

* Existing customers
* Churned customers

This distinction becomes particularly important later when creating the marketing segmentation table.

---

# 6. Customers by Plan Level

The project analyzes the current customer base by subscription level.

```sql
SELECT Plan_Level,
       COUNT(customer_id) AS total_users
FROM NexaSat_data
WHERE Churn = 0
GROUP BY 1;
```

This helps identify the size of each active customer segment and provides insight into the composition of NexaSat's current subscriber base.

The output can support decisions around:

* Plan optimization
* Upgrade campaigns
* Pricing
* Customer targeting
* Product strategy

---

# 7. Revenue Analysis

Total monthly billing revenue is calculated using:

```sql
SELECT ROUND(SUM(Monthly_Bill_Amount), 0) AS revenue
FROM NexaSat_data;
```

Revenue is then broken down by subscription level:

```sql
SELECT Plan_Level,
       ROUND(SUM(Monthly_Bill_Amount), 0) AS revenue
FROM NexaSat_data
GROUP BY 1
ORDER BY 2;
```

This makes it possible to determine which plan levels contribute most to overall billing revenue.

---

# 8. Churn Analysis by Plan

The project examines churn across plan types and plan levels.

```sql
SELECT Plan_Level,
       Plan_Type,
       COUNT(*) AS total_customers,
       SUM(Churn) AS Churn_count
FROM NexaSat_data
GROUP BY 1,2
ORDER BY 1;
```

This is important because aggregate churn figures can hide differences between customer groups.

For example, a plan may have:

* A large customer base but relatively low churn
* A smaller customer base but disproportionately high churn

Analyzing churn by plan level and plan type provides a more actionable view of retention performance.

---

# 9. Average Customer Tenure

Average tenure is calculated for each plan level.

```sql
SELECT Plan_Level,
       ROUND(AVG(Tenure_Months),2) AS average_tenure
FROM NexaSat_data
GROUP BY 1;
```

Tenure is a critical customer-lifecycle metric because longer-serving customers can potentially generate greater lifetime revenue and may also demonstrate stronger loyalty.

---

# 10. Existing Customer Dataset

A dedicated table is created containing only customers who have not churned.

```sql
CREATE TABLE existing_users AS
SELECT *
FROM NexaSat_data
WHERE churn = 0;
```

This is a particularly important analytical decision.

The subsequent marketing analysis focuses on **existing customers**, because the objective is to identify customers who can currently be:

* Retained
* Upsold
* Cross-sold
* Supported
* Re-engaged

This prevents churned customers from being included in active-customer marketing campaigns.

---

# 11. ARPU Analysis

The project calculates **Average Revenue Per User (ARPU)** for existing customers.

```sql
SELECT ROUND(AVG(Monthly_Bill_Amount), 2) AS ARPU
FROM existing_users;
```

### Why ARPU matters

ARPU measures the average amount of revenue generated by an active customer.

It is useful for:

* Revenue forecasting
* Customer-value analysis
* Plan comparison
* Upselling
* Pricing analysis

An increase in ARPU can indicate successful upgrades, cross-selling, increased usage, or movement toward higher-value plans.

---

# 12. Customer Lifetime Value

The project calculates a simplified Customer Lifetime Value metric.

```sql
ALTER TABLE existing_users
ADD COLUMN clv FLOAT;

UPDATE existing_users
SET clv = Monthly_Bill_Amount * tenure_months;
```

The formula is:

```text
CLV = Monthly Bill Amount × Tenure in Months
```

This provides an estimate of the cumulative revenue associated with each customer based on their current monthly billing and tenure.

### Example

A customer paying:

```text
₦100 per month
```

with:

```text
24 months of tenure
```

would have:

```text
CLV = 100 × 24
    = 2,400
```

The actual currency depends on the dataset's billing-unit convention.

---

# 13. CLV Scoring

The project goes beyond basic CLV by creating a weighted customer-value score.

The scoring formula is:

```text
CLV Score =
40% Monthly Bill
+ 30% Tenure
+ 10% Call Duration
+ 10% Data Usage
+ 10% Premium Plan Indicator
```

Implemented in SQL as:

```sql
UPDATE existing_users
SET clv_score =
        (0.4 * Monthly_Bill_Amount) +
        (0.3 * Tenure_Months) +
        (0.1 * Call_Duration) +
        (0.1 * Data_Usage) +
        (0.1 * CASE
                WHEN Plan_Level = 'Premium'
                THEN 1
                ELSE 0
                END);
```

This scoring model combines financial value, loyalty, usage behavior, and subscription level.

---

# 14. Customer Segmentation

Customers are classified into four value segments:

### High Value

Customers with the strongest CLV scores.

### Moderate Value

Customers demonstrating relatively strong customer value but with room for further growth.

### Low Value

Customers with lower customer-value scores.

### Churn Risk

Customers falling into the lowest-value segment and therefore requiring greater retention attention.

The segmentation is based on percentile-style ranking using the SQL `NTILE()` window function.

```sql
NTILE(100) OVER (
    ORDER BY clv_score DESC
)
```

This is a strong example of using SQL window functions for customer segmentation.

---

# 15. Customer Segment Analysis

After segmentation, the project calculates customer counts per segment.

```sql
SELECT clv_segments,
       COUNT(*) AS segments_count
FROM existing_users
GROUP BY clv_segments;
```

This allows the business to understand the size of each customer-value group.

---

# 16. Segment-Level Billing & Tenure

Average monthly charges and average tenure are calculated for each customer segment.

```sql
SELECT clv_segments,
       ROUND(AVG(monthly_bill_amount),2) AS avg_monthly_charges,
       ROUND(AVG(avg_tenure),2) AS avg_tenure
FROM existing_users
GROUP BY 1;
```

This type of analysis allows management to compare customer segments according to:

* Revenue contribution
* Customer longevity
* Value potential

---

# 17. Technical Support & Multiple-Line Penetration

The project evaluates product adoption across customer-value segments.

```sql
SELECT clv_segments,
       ROUND(AVG(
           CASE WHEN tech_support = 'Yes'
                THEN 1 ELSE 0 END
       ),2) AS tech_support_pct,

       ROUND(AVG(
           CASE WHEN multiple_lines = 'Yes'
                THEN 1 ELSE 0 END
       ),2) AS additional_line_pct
FROM existing_users
GROUP BY 1;
```

This provides insight into potential product-adoption opportunities.

Customers without technical support may represent cross-selling opportunities.

Customers without multiple lines may represent opportunities for family or household plan expansion.

---

# 18. Revenue by Customer Segment

The project estimates cumulative customer revenue by segment.

```sql
SELECT
    clv_segments,
    COUNT(customer_id) AS customer_count,
    CAST(
        SUM(
            COALESCE(Monthly_Bill_Amount, 0) *
            COALESCE(Tenure_Months, 0)
        ) AS DECIMAL(10,2)
    ) AS total_revenue
FROM existing_users
GROUP BY clv_segments;
```

This connects customer segmentation directly to financial value.

Instead of simply asking:

> "How many customers are in each segment?"

the analysis asks:

> "How much customer value does each segment represent?"

This is much more useful for marketing prioritization.

---

# 19. Cross-Selling Strategy

The project identifies specific existing customers who may be suitable for additional products or services.

---

## Cross-Sell Opportunity 1: Technical Support

The first target group consists of:

* Senior citizens
* No dependents
* No technical support
* Low-value or churn-risk customers

```sql
SELECT customer_id
FROM existing_users
WHERE Senior_Citizen = 1
  AND dependents = 'No'
  AND tech_support = 'No'
  AND (
      clv_segments = 'Churn Risk'
      OR clv_segments = 'Low Value'
  );
```

### Business Rationale

These customers may benefit from additional technical assistance.

A targeted support offer could potentially:

* Improve customer experience
* Reduce frustration
* Increase service adoption
* Improve loyalty
* Reduce potential churn

This is a good example of using customer characteristics to create a targeted rather than mass-market campaign.

---

# 20. Cross-Sell Opportunity 2: Multiple Lines

The second cross-selling strategy targets Basic-plan customers who:

* Have no multiple lines
* Have a partner or dependents

```sql
SELECT customer_id
FROM existing_users
WHERE multiple_lines = 'No'
  AND (
      dependents = 'Yes'
      OR partner = 'Yes'
  )
  AND plan_level = 'Basic';
```

### Business Rationale

Customers with partners or dependents may have a natural need for additional mobile lines.

NexaSat could therefore offer:

* Family plans
* Additional-line discounts
* Multi-line bundles
* Household packages

This could increase both customer value and product penetration.

---

# 21. Upselling Strategy 1: Churn-Risk Basic Customers

The project identifies Basic-plan customers classified as churn risk.

```sql
SELECT customer_id
FROM existing_users
WHERE clv_segments = 'Churn Risk'
  AND Plan_Level = 'Basic';
```

### Business Rationale

These customers should not necessarily receive a direct premium upgrade immediately.

A more appropriate strategy may be:

* Retention discount
* Improved service bundle
* Promotional pricing
* Enhanced support
* Loyalty incentives

The objective is to reduce churn risk before attempting to maximize revenue.

---

# 22. Upselling Strategy 2: High-Value Customers

The project also analyzes average bill and tenure among high-value and moderate-value customers.

```sql
SELECT Plan_level,
       ROUND(AVG(Monthly_Bill_Amount),2) AS average_bill,
       ROUND(AVG(Tenure_Months),2) AS average_tenure
FROM existing_users
WHERE clv_segments = 'High Value'
   OR clv_segments = 'Moderate Value'
GROUP BY 1;
```

This allows NexaSat to determine whether high-value customers are concentrated within particular subscription levels.

---

# 23. Premium Upgrade Targeting

The final upselling query identifies Basic-plan customers who:

* Are High Value or Moderate Value
* Pay more than 150 in monthly billing

```sql
SELECT customer_id,
       Monthly_Bill_Amount
FROM existing_users
WHERE Plan_Level = 'Basic'
  AND (
      clv_segments = 'High Value'
      OR clv_segments = 'Moderate Value'
  )
  AND Monthly_Bill_Amount > 150;
```

### Business Rationale

These customers represent strong potential upgrade candidates because they already generate relatively high monthly billing while remaining on the Basic plan.

A carefully designed premium upgrade could increase:

* ARPU
* CLV
* Product adoption
* Customer stickiness

---

# 24. Operational Marketing Views

The project converts analytical logic into reusable SQL views.

This is an important step because it moves the analysis from a one-time query toward a more operational marketing workflow.

---

## Technical Support Target List

```sql
CREATE VIEW tech_support_snr_citizens AS
SELECT eu.customer_id
FROM existing_users eu
WHERE eu.senior_citizen = 1
  AND eu.dependents = 'No'
  AND eu.tech_support = 'No'
  AND eu.clv_segments = 'Low Value';
```

This view creates a reusable list of customers who may be suitable for a technical-support campaign.

---

## Churn-Risk Discount List

```sql
CREATE VIEW churn_risk_discount_customers AS
SELECT customer_id
FROM existing_users
WHERE clv_segments = 'Churn Risk'
  AND Plan_Level = 'Basic';
```

This view can support a targeted retention campaign.

---

## Multiple-Line Offer List

```sql
CREATE VIEW multiple_lines_offer_customers AS
SELECT customer_id
FROM existing_users
WHERE multiple_lines = 'No'
  AND (
      dependents = 'Yes'
      OR partner = 'Yes'
  )
  AND Plan_Level = 'Basic';
```

This produces a reusable audience for a multi-line/family-plan campaign.

---

## Premium Upgrade List

```sql
CREATE VIEW high_usage_basic_customers AS
SELECT customer_id
FROM existing_users
WHERE plan_level = 'Basic'
  AND (
      clv_segments = 'High Value'
      OR clv_segments = 'Moderate Value'
  )
  AND Monthly_Bill_Amount > 150;
```

This creates a targeted premium-upgrade audience.

---

# 25. Business Insights

## Insight 1 — Customer value should drive marketing strategy

Not every customer should receive the same marketing treatment.

The CLV segmentation framework creates four distinct customer groups that can receive different strategies.

| Segment        | Recommended Strategy                 |
| -------------- | ------------------------------------ |
| High Value     | Loyalty, premium services, retention |
| Moderate Value | Upselling and engagement             |
| Low Value      | Cross-selling and value development  |
| Churn Risk     | Retention and churn prevention       |

This creates a more efficient customer-marketing strategy than mass communication.

---

## Insight 2 — Existing customers are the primary growth opportunity

The creation of the `existing_users` table demonstrates that the project is primarily focused on customers who are still active.

This is strategically important because existing customers already have an established relationship with NexaSat.

The company can potentially generate incremental revenue through:

* Upgrades
* Additional lines
* Technical support
* Loyalty offers
* Premium services

without relying entirely on acquiring new customers.

---

## Insight 3 — CLV combines financial and behavioral information

The project does not rely exclusively on monthly billing to define customer value.

The CLV score incorporates:

* Monthly billing
* Tenure
* Call duration
* Data usage
* Premium-plan status

This creates a broader representation of customer value.

---

## Insight 4 — High-value customers are potential upgrade targets

High-value and moderate-value Basic-plan customers with monthly bills above 150 represent a particularly interesting upselling audience.

They demonstrate relatively strong economic value while remaining on a lower subscription tier.

---

## Insight 5 — Customers with household relationships may be strong multi-line prospects

Basic customers with a partner or dependents but no additional lines have a logical need for multi-line services.

This makes the segment suitable for targeted household or family-plan campaigns.

---

## Insight 6 — Churn-risk customers require retention before aggressive upselling

Customers classified as churn risk should generally be approached differently from high-value customers.

The primary objective should be to stabilize the relationship through:

* Discounts
* Customer support
* Service improvements
* Loyalty incentives

Once retention improves, further upselling can be considered.

---

# 26. Recommended Marketing Strategy

## High Value Customers

### Objective

Protect revenue and maximize lifetime value.

### Actions

* Premium loyalty benefits
* Exclusive offers
* Priority support
* Premium upgrades
* Retention incentives

---

## Moderate Value Customers

### Objective

Move customers toward high-value status.

### Actions

* Premium upgrades
* Add-on services
* Multi-line packages
* Usage-based offers
* Loyalty rewards

---

## Low Value Customers

### Objective

Increase customer engagement and value.

### Actions

* Technical support
* Additional-line offers
* Affordable bundles
* Usage-based packages
* Engagement campaigns

---

## Churn Risk Customers

### Objective

Reduce customer attrition.

### Actions

* Retention discounts
* Service recovery
* Personalized support
* Contract incentives
* Churn-prevention campaigns

---

# 27. SQL Techniques Demonstrated

This project demonstrates a broad range of practical SQL techniques.

### Database Management

* `CREATE DATABASE`
* `USE`
* `CREATE TABLE`

### Data Retrieval

* `SELECT`
* `SELECT *`

### Filtering

* `WHERE`
* Multiple conditional filters
* `AND`
* `OR`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`

### Data Grouping

* `GROUP BY`

### Sorting

* `ORDER BY`

### Conditional Logic

* `CASE WHEN`

### Data Cleaning

* Duplicate checking
* Null-value checking

### Data Transformation

* `ALTER TABLE`
* `ADD COLUMN`
* `UPDATE`

### Window Functions

* `NTILE()`
* Percentile-style segmentation

### Data Quality Handling

* `COALESCE()`

### Data Type Conversion

* `CAST()`
* `DECIMAL`

### Rounding

* `ROUND()`

### Views

* `CREATE VIEW`

### Analytical Modeling

* CLV calculation
* CLV scoring
* Customer segmentation
* Churn-risk identification

---

# 28. Skills Demonstrated

## SQL

* Advanced querying
* Data aggregation
* Conditional filtering
* Window functions
* Views
* Data transformation
* Data validation

## Data Cleaning

* Duplicate detection
* Missing-value detection
* Data-quality validation
* Null handling

## Customer Analytics

* Customer segmentation
* Customer Lifetime Value
* ARPU analysis
* Customer tenure analysis
* Churn analysis
* Customer behavior analysis

## Marketing Analytics

* Cross-selling
* Upselling
* Customer targeting
* Retention strategy
* Campaign audience creation

## Business Intelligence

* KPI development
* Revenue analysis
* Customer-value analysis
* Business problem solving
* Data-driven decision-making

## Analytical Thinking

* Translating business objectives into SQL queries
* Converting raw data into customer segments
* Identifying revenue opportunities
* Identifying retention opportunities
* Connecting customer behavior with marketing actions

---

# 29. Key Performance Indicators

The project focuses on several important telecommunications and customer analytics KPIs.

### Customer Metrics

* Total customers
* Existing customers
* Churned customers
* Customer tenure

### Revenue Metrics

* Total revenue
* Monthly billing
* ARPU
* Customer Lifetime Value

### Customer Value Metrics

* CLV Score
* Customer-value segment
* High-value customer count
* Moderate-value customer count
* Low-value customer count
* Churn-risk customer count

### Product Metrics

* Plan-level distribution
* Multiple-line adoption
* Technical-support adoption
* Premium-plan adoption

### Retention Metrics

* Churn count
* Churn by plan
* Churn-risk customer population
* Average tenure by plan

---

# 30. Project Architecture

The analytical architecture can be summarized as:

```text
                    NEXASAT CUSTOMER DATA
                             │
                             ▼
                     DATA QUALITY CHECKS
                       ┌─────┴─────┐
                       │           │
                   Duplicates     Nulls
                       │           │
                       └─────┬─────┘
                             ▼
                       EDA & KPI ANALYSIS
                             │
             ┌───────────────┼────────────────┐
             ▼               ▼                ▼
          Revenue          Churn           Tenure
             │               │                │
             └───────────────┼────────────────┘
                             ▼
                     EXISTING CUSTOMERS
                             │
                             ▼
                            ARPU
                             │
                             ▼
                            CLV
                             │
                             ▼
                        CLV SCORE
                             │
                             ▼
                   CUSTOMER SEGMENTATION
                             │
          ┌──────────────────┼──────────────────┐
          ▼                  ▼                  ▼
       Retention        Cross-Selling       Upselling
          │                  │                  │
          ▼                  ▼                  ▼
      Churn-Risk       Tech Support       Premium Upgrade
                       Multiple Lines
                             │
                             ▼
                      MARKETING VIEWS
```

---

# 31. Project Outcomes

The project demonstrates how SQL can be used to move from raw customer records to actionable business decisions.

The analysis produces:

* A cleaned analytical dataset
* Existing-customer population
* ARPU metric
* Customer Lifetime Value
* Weighted CLV score
* Customer-value segments
* Segment-level revenue analysis
* Churn-risk audience
* Technical-support audience
* Multiple-line audience
* Premium-upgrade audience
* Reusable SQL views

The project therefore demonstrates the full journey from **data preparation to customer intelligence and marketing activation**.

---

# 32. Business Recommendations

### 1. Implement CLV-Based Customer Management

NexaSat should use customer-value segments to prioritize marketing resources.

High-value customers should receive retention-focused treatment, while moderate and low-value customers can be developed through targeted cross-selling and upselling.

### 2. Establish a Churn-Prevention Program

Customers classified as churn risk should receive proactive retention interventions.

These could include:

* Discounts
* Customer support
* Service upgrades
* Loyalty benefits

### 3. Expand Multiple-Line Adoption

Basic-plan customers with partners or dependents are logical candidates for additional-line offers.

### 4. Promote Technical Support

Customers without technical support can be targeted with affordable support packages, particularly customers who may benefit from additional assistance.

### 5. Target Premium Upgrades

Basic-plan customers with high or moderate CLV scores and relatively high monthly billing should be prioritized for premium-plan upgrade campaigns.

### 6. Monitor ARPU

NexaSat should track ARPU by:

* Plan level
* Customer segment
* Tenure
* Usage
* Product adoption

This will help determine which products and customer groups are generating the greatest revenue opportunity.

### 7. Continuously Recalculate Customer Segments

Customer value is not static.

A customer may move from:

```text
Churn Risk
     ↓
Low Value
     ↓
Moderate Value
     ↓
High Value
```

or move in the opposite direction.

Therefore, CLV scoring should ideally be refreshed periodically.

---

# 33. Limitations & Considerations

This project provides a strong analytical framework, but several considerations should be kept in mind.

### CLV Model

The CLV calculation:

```text
Monthly Bill × Tenure
```

is a simplified revenue-based CLV estimate.

It does not account for:

* Acquisition cost
* Customer service costs
* Discounts
* Profit margin
* Future expected revenue
* Probability of churn
* Cost of serving customers

A production CLV model could incorporate these factors.

### CLV Score

The weighted CLV score uses manually assigned weights:

```text
Monthly Bill = 40%
Tenure = 30%
Call Duration = 10%
Data Usage = 10%
Premium = 10%
```

These weights are analytical assumptions and could be refined using historical customer behavior, predictive modeling, or business stakeholder input.

### Churn Risk

The `Churn Risk` segment is based on the CLV score segmentation rather than a predictive churn model.

A future version could use machine learning or statistical modeling to predict the probability that an individual customer will churn.

### Marketing Recommendations

Customer targeting should be validated through campaign testing.

For example:

* A/B testing
* Conversion tracking
* Offer-response analysis
* Incremental revenue measurement
* Retention-rate comparison

---

# 34. Future Improvements

Future versions of the project could include:

* Automated customer segmentation
* Predictive churn modeling
* Predictive CLV
* Customer profitability analysis
* Campaign response tracking
* Cohort analysis
* Monthly revenue trends
* Retention-rate analysis
* Customer acquisition cost
* Profit-based segmentation
* Dashboard integration with Power BI or Tableau
* Automated marketing audience exports

---

# 35. Repository Structure

A recommended GitHub repository structure is:

```text
NexaSat-SQL-Customer-Analytics/
│
├── README.md
│
├── NexaSat_Data.sql
│
├── Dashboard/
│   └── NexaSat_Customer_Analytics_Dashboard.pbix
│
└── Screenshots/
    ├── customer_overview.png
    ├── customer_segmentation.png
    └── marketing_opportunities.png
```

If the project is SQL-only, the repository can simply contain:

```text
NexaSat-SQL-Customer-Analytics/
│
├── README.md
└── NexaSat_Data.sql
```

---

# 36. Suggested GitHub Repository Description

**SQL-based telecom customer analytics project using CLV segmentation, churn analysis, ARPU, customer profiling, cross-selling, and upselling strategies to identify actionable revenue and retention opportunities.**

---

# 37. Suggested GitHub Topics

```text
sql
sql-project
customer-analytics
data-analytics
telecom-analytics
customer-segmentation
clv
customer-lifetime-value
churn-analysis
arpu
marketing-analytics
business-intelligence
data-analysis
mysql
```

---

# Conclusion

The **NexaSat Customer Analytics** project demonstrates how SQL can be applied to a real-world telecommunications business problem.

Beginning with customer-level data, the analysis performs data-quality checks, explores customer and revenue patterns, isolates active customers, calculates ARPU and Customer Lifetime Value, creates a weighted CLV score, segments customers according to value, and translates those segments into specific marketing opportunities.

The most important strength of the project is its progression from **descriptive analytics to prescriptive business action**.

Instead of simply reporting how many customers NexaSat has, the analysis answers more commercially valuable questions:

* Which customers are most valuable?
* Which customers require retention attention?
* Which customers are potential cross-sell prospects?
* Which customers are suitable for premium upgrades?
* Which customers may benefit from technical support?
* How can customer data be converted into targeted marketing campaigns?

Through SQL, the project demonstrates practical capabilities in **data cleaning, exploratory analysis, aggregation, conditional logic, window functions, customer segmentation, CLV modeling, churn analysis, marketing analytics, and business intelligence**.

Ultimately, the project shows how structured customer data can be transformed into a practical decision-making framework for **retention, revenue growth, customer loyalty, and targeted marketing**.
