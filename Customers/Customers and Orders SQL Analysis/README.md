# Customer and Orders SQL Analysis

## Project Overview

This project demonstrates practical SQL querying skills using customer and order data. The analysis focuses on filtering records, applying logical conditions, selecting specific columns, and retrieving business-relevant customer and order information.

The project is designed as a hands-on SQL practice exercise and demonstrates how SQL can be used to answer common business questions from relational data.

## Objectives

The main objectives of this project are to:

Retrieve customer and order records from database tables.

Filter customers based on grade and location.

Combine multiple conditions using AND, OR, and NOT.

Retrieve only the columns required for analysis.

Filter order records using date, salesperson, and purchase-amount conditions.

Practice writing readable and targeted SQL queries.

Demonstrate the difference between retrieving all columns and selecting specific fields.

## Tables Used

customerj


The customer table is used for customer-level analysis.

Key fields referenced in the queries include:

Column           Description

customer_id      Unique customer identifier

cust_name        Customer name

city             Customer's city

grade            Customer grade/rating

salesman_id      Salesperson associated with the customer

orders

The orders table is used for transaction-level analysis.

Key fields referenced include:

Column           Description

ord_no           Order number

purch_amt        Purchase amount

ord_date         Order date

customer_id      Customer associated with the order

salesman_id      Salesperson associated with the order

## SQL Concepts Demonstrated

## Selecting Records

The project begins with basic SELECT statements to inspect the available data.

SELECT * FROM customerj;

Specific columns can also be selected when only relevant fields are required.

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customerj;

## Filtering with WHERE

Customer records can be filtered based on grade:

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customerj
WHERE grade > 100;

This demonstrates the use of comparison operators to isolate records that satisfy a business condition.

## Combining Conditions with AND

The project identifies customers who are both located in New York and have a grade above 100:

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customerj
WHERE city = 'New York'
AND grade > 100;

AND requires all specified conditions to be satisfied.

## Combining Conditions with OR

The project also retrieves customers who either live in New York or have a grade above 100:

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customerj
WHERE city = 'New York'
OR grade > 100;

## Using NOT

The project demonstrates negative filtering by identifying customers who are either from New York or whose grade is not greater than 100.

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customerj
WHERE city = 'New York'
OR NOT grade > 100;

## Order Filtering

Order records are filtered using multiple conditions involving the order date, salesperson, and purchase amount.

SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM orders
WHERE NOT ord_date = '2012/09/10'
AND salesman_id > 5005
OR purch_amt > 1000;

This demonstrates how multiple business rules can be incorporated into a query.

Note: When combining AND and OR, parentheses are recommended when the intended business logic needs to be made explicit. Date formatting should also match the SQL database's expected date format.

## Key Learning Outcomes

Through this project, I practiced:

Basic SQL data retrieval.

Column selection.

Conditional filtering.

Comparison operators such as >.

Logical operators such as AND, OR, and NOT.

Working with customer and transaction data.

Translating business questions into SQL queries.

Writing queries that return only the required fields.

## Potential Business Applications

The techniques demonstrated here can be applied to:

Customer segmentation.

Identifying high-value or highly rated customers.

Location-based customer analysis.

Salesperson performance analysis.

Order monitoring.

Identifying transactions above a specific purchase threshold.

Building datasets for dashboards and reports.

## Tools

SQL

Relational database tables
