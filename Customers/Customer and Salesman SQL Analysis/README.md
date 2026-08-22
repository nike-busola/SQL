# Customer & Salesman SQL Joins

## Project Overview

This project demonstrates how SQL JOIN operations can be used to combine related information from customer and salesperson tables.

The analysis uses two relational tables:

customerj — contains customer information such as customer name, city, grade, and assigned salesperson.

salesman — contains salesperson information such as salesperson ID, name, and city.

The project focuses on understanding relationships between tables and retrieving meaningful information by matching records through related columns.

## Objectives

The main objectives of this project are to:

Retrieve and inspect customer and salesperson data.

Understand how SQL joins connect related tables.

Use INNER JOIN to return records with matching relationships.

Use LEFT JOIN to preserve all records from the left table.

Use RIGHT JOIN to preserve all records from the right table.

Join tables using salesperson IDs.

Join tables using city values.

Filter joined results using WHERE.

Sort results using ORDER BY.

Use table aliases to make queries shorter and easier to read.

Understand how unmatched records are represented in join results.

## Tables Used

customerj

The customer table contains customer-related information.

Fields referenced in the queries include:

| Column          | Description                           |
| --------------- | ------------------------------------- |
| `customer_id`   | Unique customer identifier            |
| `cust_name`     | Customer's name                       |
| `city`          | Customer's city                       |
| `grade`         | Customer grade/rating                 |
| `salesman_id`   | Salesperson associated with customer  |


salesman

The salesperson table contains information about sales representatives.

Fields referenced include:

| Column          | Description                           |
| --------------- | ------------------------------------- |
| `salesman_id`   | Unique salesperson identifier         |
| `name`          | Salesperson's name                    |
| `city`          | Salesperson's city                    |


## Relationship Between the Tables

The primary relationship used in this project is:

customerj.salesman_id
        │
        │ matches
        ▼
salesman.salesman_id

This relationship allows customer records to be connected with the salesperson responsible for them.

The project also demonstrates a city-based relationship:

customerj.city
        │
        │ matches
        ▼
salesman.city

This allows the analysis to identify customers and salespeople who are located in the same city.

## SQL JOIN Concepts Demonstrated

## Understanding INNER JOIN

An INNER JOIN returns only records where a matching value exists in both tables.

The project uses it to identify customers and the salespeople assigned to them:

SELECT customerj.cust_name, salesman.name
FROM customerj
INNER JOIN salesman
ON customerj.salesman_id = salesman.salesman_id;

The result provides:

Customer name

Salesperson name

Only customers with a matching salesperson are returned.

## Using Table Aliases

The same query is rewritten using aliases:

SELECT a.cust_name, b.name
FROM customerj a
INNER JOIN salesman b
ON a.salesman_id = b.salesman_id;

Aliases such as a and b make queries more concise, particularly when working with multiple tables.

## Joining Tables Using City

The project identifies customers and salespeople who live in the same city:

SELECT customerj.cust_name, salesman.name, salesman.city
FROM customerj
INNER JOIN salesman
ON customerj.city = salesman.city;

This demonstrates that SQL joins do not necessarily have to use an ID column. Tables can also be joined using another related attribute when appropriate.

The output includes:

Customer name

Salesperson name

Salesperson city

## Filtering Joined Data

The project identifies customers with a grade below 300 while also displaying their salesperson information:

SELECT customerj.cust_name,
       customerj.city,
       customerj.grade,
       salesman.name,
       salesman.city
FROM customerj
LEFT JOIN salesman
ON customerj.salesman_id = salesman.salesman_id
WHERE customerj.grade < 300
ORDER BY customerj.grade;

This combines several SQL concepts:

LEFT JOIN

WHERE

Comparison operators

ORDER BY

The results are sorted by customer grade in ascending order.

## Using LEFT JOIN

A LEFT JOIN returns all records from the left table and matching records from the right table.

In this project:

FROM customerj
LEFT JOIN salesman

means every qualifying customer remains in the result, even if there is no matching salesperson.

If a customer does not have a matching salesperson, the salesperson columns will typically contain NULL.

This is useful when the goal is to ensure that records from the primary table are not lost.

## Using RIGHT JOIN

The project also demonstrates the equivalent relationship using a RIGHT JOIN:

FROM salesman
RIGHT JOIN customerj
ON customerj.salesman_id = salesman.salesman_id

A RIGHT JOIN preserves all records from the table on the right side of the join.

In this example, customerj is on the right, so customer records are preserved.

Understanding both LEFT JOIN and RIGHT JOIN helps demonstrate that the direction of a join affects which table's unmatched records are retained.

## Identifying Salespeople With or Without Customers

The project also generates a list of salespeople and their associated customers:

SELECT customerj.cust_name,
       customerj.city,
       customerj.grade,
       salesman.name,
       salesman.city
FROM salesman
LEFT JOIN customerj
ON customerj.salesman_id = salesman.salesman_id
ORDER BY salesman.name;

Because salesman is the left table, all salespeople are included.

This means the query can reveal:

Salespeople who work with one or more customers.

Salespeople who currently have no matching customers.

Where no customer exists, the customer-related columns will be NULL.

## Sorting Results

The project uses:

ORDER BY salesman.name;

to arrange salespeople alphabetically.

It also uses:

ORDER BY customerj.grade;

to sort customers by grade in ascending order.

Sorting makes query results easier to review and interpret.

Query Summary

| Query                    | Purpose                                      |  Main Concepts           |
| -------------------------| -------------------------------------        | -------------------------|
| Customer + salesperson   | Find customers and their assigned salespeople| `INNER JOIN`             |
| Same-city analysis       | Find customers and salespeople in same city  | `INNER JOIN`             |
| Grade below 300          | Lower-grade customers, salesperson details   | `LEFT JOIN,WHERE,ORDER BY`| 
| Salespeople and customers| List salespeople with or without customers   | `LEFT JOIN`               |
| Alternative join syntax  | Demonstrate equivalent join approaches       | `RIGHT JOIN`              |


## Key Learning Outcomes

This project demonstrates practical understanding of:

Relational database relationships.

INNER JOIN.

LEFT JOIN.

RIGHT JOIN.

Join conditions using ON.

Table aliases.

Joining tables through ID relationships.

Joining tables through shared attributes such as city.

Filtering joined datasets.

Sorting query results.

Understanding unmatched records and NULL values.

## Business Applications

The SQL techniques demonstrated in this project can be applied to many real-world business analysis scenarios.

## Sales Management

A company can connect customers to their assigned sales representatives to understand account ownership.

## Salesperson Performance

Customer and salesperson data can be combined to analyse the number and characteristics of customers managed by each salesperson.

## Customer Segmentation

Customer grades can be used to identify different customer groups and connect them with their responsible salespeople.

## Territory Analysis

Joining customer and salesperson information by city can help identify sales territories and potential geographic overlaps.

## Account Coverage

A LEFT JOIN from the salesperson table can help identify salespeople who currently have no assigned customers.

## Important SQL Concepts

ON vs WHERE

The ON clause defines how records from the two tables are related:

ON customerj.salesman_id = salesman.salesman_id

The WHERE clause filters the results after the relationship has been established:

WHERE customerj.grade < 300

Understanding this distinction is essential when working with SQL joins.

## Values

When using an outer join such as LEFT JOIN, unmatched records from the other table can produce NULL values.

For example, a salesperson without a customer may appear as:

Salesperson | Customer
------------|----------
John        | NULL

This does not necessarily mean the data is incorrect; it can indicate that no matching customer exists.

## Potential Enhancements

Future versions of this project could expand the analysis by:

Counting customers assigned to each salesperson.

Identifying salespeople with zero customers.

Calculating average customer grade by salesperson.

Comparing customer counts by city.

Ranking salespeople by number of customers.

Identifying cities with the highest number of customers.

Combining customer, salesperson, and order data for deeper sales analysis.

Using GROUP BY and aggregate functions such as COUNT() and AVG().

For example, customer counts by salesperson could be explored with:

SELECT salesman.name, COUNT(customerj.customer_id) AS customer_count
FROM salesman
LEFT JOIN customerj
ON salesman.salesman_id = customerj.salesman_id
GROUP BY salesman.name;

## Tools

SQL

Relational database


This project is part of my SQL and data analysis portfolio and demonstrates my ability to combine relational datasets, apply SQL joins, filter results, and extract business-relevant insights from structured data.
