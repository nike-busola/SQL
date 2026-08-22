# Employee Salary Classification with SQL CASE

## Project Overview

This project demonstrates how SQL's CASE expression can be used to transform numerical salary data into meaningful business categories.

Instead of displaying salary values alone, the query classifies employees into three salary bands:

High Salary — salary above 3,000

Average Salary — salary between 2,000 and 3,000

Low Salary — salary below 2,000

This project highlights how SQL can be used not only to retrieve data but also to create calculated and business-friendly fields.

## Objective

The primary objective is to classify employees according to salary ranges and generate a new column called REMARKS.

The project demonstrates how conditional logic can be applied directly within a SQL query.

## Table Used

emp

The employee table is used as the source of the salary information.

The main field used in the analysis is:

Column

Description

salary

Employee salary

Other employee fields are also returned because the query uses SELECT *.

## SQL Concept Demonstrated

CASE Expression

A SQL CASE expression works similarly to an IF/ELSE structure in programming.

The query evaluates each condition in order and returns the result associated with the first condition that is true.

SELECT *,
CASE
    WHEN salary > 3000 THEN 'High Salary'
    WHEN salary BETWEEN 2000 AND 3000 THEN 'Average Salary'
    ELSE 'Low Salary'
END AS REMARKS
FROM emp;

## Salary Classification Logic

Salary Condition

Classification

Greater than 3,000

High Salary

2,000 to 3,000

Average Salary

Below 2,000

Low Salary

The BETWEEN operator includes both boundary values. Therefore, salaries of exactly 2,000 and exactly 3,000 are classified as Average Salary.

## Why This Matters

Salary values are numerical, but business users often need categories that are easier to understand.

For example:

Employee     Salary     Remarks
Employee A   3500       High Salary
Employee B   2500       Average Salary
Employee C   1500       Low Salary

Creating the REMARKS field makes the dataset easier to interpret and can support reporting or dashboard development.

## Key Learning Outcomes

This project demonstrates how to:

Use the SQL CASE expression.

Create calculated columns.

Apply conditional business logic.

Categorize numerical data.

Use BETWEEN for range-based conditions.

Assign aliases to calculated fields using AS.

Transform raw database values into business-friendly classifications.

## Potential Business Applications

The same approach can be used for:

Salary banding.

Employee performance categories.

Customer segmentation.

Sales performance classification.

Order value categories.

Risk classification.

Age-group segmentation.

Inventory status classification.

For example, a sales dataset could classify transactions as:

High Value
Medium Value
Low Value

using the same CASE technique.

## Tools

SQL

Relational database

## Possible Enhancements

Future improvements could include:

Counting employees in each salary category.

Calculating the percentage of employees in each category.

Grouping results by department.

Comparing salary categories across job roles.

Adding salary classifications to an HR dashboard.

Combining salary classification with other employee attributes.
