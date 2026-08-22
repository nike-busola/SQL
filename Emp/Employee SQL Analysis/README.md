# Employee SQL Analysis

## Project Overview

This project demonstrates foundational SQL querying techniques using an employee dataset. The queries explore employee information, job roles, salaries, departments, commissions, and hiring dates.

The project was created to strengthen practical SQL skills, particularly data retrieval, filtering, logical operators, pattern matching, and working with unique values.

## Objectives

The objectives of this project are to:

Retrieve employee information from a database.

Select specific columns from an employee table.

Identify unique employee job roles.

Filter employees by job designation.

Filter employees using salary conditions.

Combine multiple conditions using logical operators.

Search for employee names using pattern matching.

Filter records using IN.

Identify employees based on commission and salary relationships.

Practice different ways of expressing negative conditions.

## Table Used

emp

The project uses an employee table containing employee and employment-related information.

Fields referenced include:

Column

Description

emp_id

Unique employee identifier

emp_name

Employee name

job_name

Employee job/designation

hire_date

Employee hiring date

salary

Employee salary

commission

Employee commission

dep_id

Department identifier

## SQL Concepts Demonstrated

## Basic SELECT

The project starts by retrieving all employee records:

SELECT * FROM emp;

Specific columns can also be returned:

SELECT emp_name, job_name, hire_date
FROM emp;

## SELECT DISTINCT

DISTINCT is used to identify unique job designations:

SELECT DISTINCT job_name
FROM emp;

This prevents duplicate job titles from appearing in the result.

## Filtering with WHERE

Employees belonging to a particular role can be retrieved with:

SELECT *
FROM emp
WHERE job_name = 'analyst';

The project also identifies managers while returning selected fields:

SELECT emp_name, salary, hire_date
FROM emp
WHERE job_name = 'manager';

## Comparison Operators

Employees earning more than 2,000 are identified using the greater-than operator:

SELECT *
FROM emp
WHERE salary > 2000;

This demonstrates how numeric conditions can be used for salary analysis.

## Using AND

Multiple conditions can be applied at the same time:

SELECT *
FROM emp
WHERE job_name = 'analyst'
AND salary > 2000;

The query returns analysts whose salary is above 2,000.

## Using OR

The project identifies employees belonging to either department 1001 or 3001:

SELECT *
FROM emp
WHERE dep_id = 1001
OR dep_id = 3001;

## Using NOT and Not-Equal Operators

The project demonstrates several equivalent approaches to exclude salespeople:

SELECT *
FROM emp
WHERE job_name <> 'salesman';

SELECT *
FROM emp
WHERE job_name != 'salesman';

SELECT *
FROM emp
WHERE NOT job_name = 'salesman';

These examples demonstrate different ways to express exclusion conditions.

## Pattern Matching with LIKE

The project uses LIKE to search for employee names based on patterns.

Names beginning with A:

SELECT *
FROM emp
WHERE emp_name LIKE 'a%';

Names ending with e:

SELECT *
FROM emp
WHERE emp_name LIKE '%e';

Names matching a specific character pattern:

SELECT *
FROM emp
WHERE emp_name LIKE 'a_e%';

Names containing a particular sequence:

SELECT *
FROM emp
WHERE emp_name LIKE '%kayling%';

## Using IN

Multiple employee IDs can be searched more efficiently with IN:

SELECT *
FROM emp
WHERE emp_id IN (67832, 68319, 66564);

This is an alternative to writing multiple OR conditions.

## Salary and Commission Analysis

The project identifies employees whose commission exceeds their salary:

SELECT *
FROM emp
WHERE commission > salary;

This demonstrates comparison between two columns within the same record.

## Filtering by Department

Employees outside department 2001 can be identified using:

SELECT *
FROM emp
WHERE dep_id <> '2001';

## Searching for a Specific Employee

A specific employee can be located using:

SELECT *
FROM emp
WHERE emp_name = 'BLAZE';

## Key Learning Outcomes

This project demonstrates practical understanding of:

SELECT

SELECT DISTINCT

WHERE

Comparison operators

AND

OR

NOT

LIKE

IN

Not-equal operators

Filtering by numeric values

Filtering by text values

Comparing values across columns

## Business Applications

These SQL techniques can support common business analysis tasks such as:

Employee directory reporting.

Salary analysis.

Department-level employee filtering.

Identifying employees by job role.

Compensation analysis.

Searching employee records.

Preparing datasets for HR dashboards.

Identifying employees that meet specific business criteria.

## Tools

SQL
Relational database
