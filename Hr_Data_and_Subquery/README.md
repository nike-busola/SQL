# HR Data Analysis & SQL Subqueries

## Project Overview

This project is a SQL-based **Human Resources Data Analysis** exercise focused on extracting, transforming, filtering, aggregating, and analyzing employee information.

The project uses an HR dataset containing employee details such as:

* Employee ID
* First name
* Last name
* Salary
* Department ID
* Job ID
* Manager ID
* Hire date
* Email

The analysis demonstrates practical SQL techniques for working with employee data, including **textual functions, filtering, sorting, aggregation, salary analysis, conditional logic, and subqueries**.

The project progresses from fundamental SQL operations to more advanced queries that use nested queries to compare employees against other employees or groups within the organization.

---

## Business Objective

The objective of this project is to demonstrate how SQL can be used to answer common HR and workforce-management questions.

The analysis aims to help HR teams and management:

* Identify employees based on salary thresholds.
* Analyze salary distributions across job roles.
* Compare employee compensation.
* Identify employees earning above organizational averages.
* Analyze departmental workforce structures.
* Examine employee reporting relationships.
* Identify employees sharing similar job designations.
* Support compensation benchmarking.
* Extract employee groups based on specific business criteria.

---

## Dataset Overview

The HR dataset contains employee-level information.

### Key Fields

| Field           | Description                           |
| --------------- | ------------------------------------- |
| `employee_id`   | Unique employee identifier            |
| `first_name`    | Employee first name                   |
| `last_name`     | Employee surname                      |
| `email`         | Employee email address                |
| `hire_date`     | Employee hiring date                  |
| `job_id`        | Employee's job/designation identifier |
| `salary`        | Employee salary                       |
| `manager_id`    | Employee's reporting manager          |
| `department_id` | Employee's department                 |

---

# SQL Techniques Demonstrated

## 1. Textual Functions

The project demonstrates several SQL text functions.

### CONCAT

Used to combine first and last names into a complete employee name.

```sql
SELECT CONCAT(first_name, " ", last_name) AS FULL_NAME
FROM hr_data;
```

### UPPER

Converts text to uppercase.

```sql
SELECT UPPER(first_name) AS FIRST_NAME
FROM hr_data;
```

### LOWER

Converts text to lowercase.

```sql
SELECT LOWER(last_name) AS LAST_NAME
FROM hr_data;
```

### TRIM

Removes unnecessary spaces.

```sql
SELECT TRIM(email)
FROM hr_data;
```

### LEFT

Extracts characters from the beginning of a value.

```sql
SELECT LEFT(hire_date, 2) AS DAY
FROM hr_data;
```

### RIGHT

Extracts characters from the end of a value.

```sql
SELECT RIGHT(hire_date, 4) AS YEAR
FROM hr_data;
```

### MID

Extracts a specified portion of a string.

```sql
SELECT MID(hire_date, 4, 2) AS MONTH
FROM hr_data;
```

These functions demonstrate the ability to manipulate and standardize employee information directly within SQL.

---

# Salary Analysis

## Employees Earning Less Than 6,000

The project identifies employees whose salary falls below 6,000.

```sql
SELECT CONCAT(first_name, " ", last_name) AS FULL_NAME,
       salary
FROM hr_data
WHERE salary < 6000;
```

### Business Application

This analysis can help HR identify:

* Lower-paid employee groups
* Compensation gaps
* Potential salary-review candidates
* Entry-level salary patterns

---

## Employees Earning More Than 8,000

```sql
SELECT CONCAT(first_name, " ", last_name) AS FULL_NAME,
       department_id,
       salary
FROM hr_data
WHERE salary > 8000;
```

This allows HR to identify higher-paid employees and examine their departmental distribution.

---

# Employee Name Filtering

The project identifies employees whose first name does not contain the letter **M**.

```sql
SELECT CONCAT(first_name, " ", last_name) AS FULL_NAME,
       hire_date,
       salary,
       department_id
FROM hr_data
WHERE NOT first_name LIKE "%M%"
ORDER BY department_id;
```

This demonstrates:

* `NOT`
* `LIKE`
* Wildcards
* Sorting
* String concatenation

---

# Salary Analysis by Job

The project calculates:

* Number of employees
* Total salary
* Salary range

for each job ID.

```sql
SELECT job_id,
       COUNT(employee_id) AS employee_counts,
       SUM(salary) AS total_salary,
       MAX(salary) - MIN(salary) AS salary_difference
FROM hr_data
GROUP BY job_id;
```

### Business Value

This analysis can help HR understand:

* Workforce size by job
* Total payroll by job
* Compensation variation
* Salary ranges within job categories

---

# Salary Range Filtering

The project identifies employees whose salaries fall outside the 7,000–15,000 range.

```sql
SELECT *
FROM hr_data
WHERE NOT salary BETWEEN 7000 AND 15000;
```

This can be used to identify employees whose compensation is unusually low or high relative to a defined salary range.

---

# Salary Increase Simulation

A 15% salary increase is simulated using:

```sql
SELECT CONCAT(first_name, " ", last_name) AS full_name,
       salary * 1.15 AS increased_salary
FROM hr_data;
```

This demonstrates how SQL can be used for **what-if compensation analysis**.

HR could use similar calculations to estimate:

* Salary review costs
* Promotion increases
* Annual compensation adjustments
* Payroll impact

---

# Average Salary Analysis

The project also attempts to calculate average salary by job ID.

```sql
SELECT job_id,
       AVG(salary) AS average_salary
FROM hr_data
WHERE salary <= 6000
GROUP BY job_id;
```

This demonstrates the use of:

* `AVG()`
* `GROUP BY`
* Filtering

### Analytical Note

For a business requirement specifically asking to exclude jobs whose **average salary is 8,000 or lower**, the appropriate approach would be to use `HAVING AVG(salary) > 8000` rather than filtering individual salary records with `WHERE salary <= 6000`.

This distinction demonstrates an important SQL concept: **WHERE filters rows before aggregation, while HAVING filters aggregated results.**

---

# SQL Subqueries

A major component of this project is the use of subqueries.

A subquery is a query nested inside another SQL query.

Subqueries allow analysis to be performed relative to another employee, group, or calculated value.

---

## 1. Employees Earning More Than Employee 163

```sql
SELECT first_name,
       last_name
FROM hr_data
WHERE salary >
(
    SELECT salary
    FROM hr_data
    WHERE employee_id = 163
);
```

### Business Question

> Which employees earn more than employee 163?

This is an example of a **scalar subquery**.

---

# 2. Employees With the Same Job as Employee 169

```sql
SELECT first_name,
       last_name,
       department_id,
       job_id
FROM hr_data
WHERE job_id =
(
    SELECT job_id
    FROM hr_data
    WHERE employee_id = 169
);
```

### Business Question

> Which employees have the same job designation as employee 169?

This can help HR identify employees within the same role or job classification.

---

# 3. Employees Earning Above Average Salary

```sql
SELECT first_name,
       last_name,
       employee_id
FROM hr_data
WHERE salary >
(
    SELECT AVG(salary)
    FROM hr_data
);
```

This is a particularly useful HR query because it compares each employee against the **overall organizational average salary**.

### Business Application

It can support:

* Compensation analysis
* Salary benchmarking
* Workforce segmentation
* Pay-equity analysis

---

# 4. Employees Reporting to Payam

```sql
SELECT first_name,
       last_name,
       employee_id
FROM hr_data
WHERE manager_id =
(
    SELECT employee_id
    FROM hr_data
    WHERE first_name = "payam"
);
```

This identifies employees who report directly to a manager named Payam.

### Business Application

The same concept can be used to analyze:

* Reporting structures
* Team composition
* Manager span of control
* Organizational hierarchy

---

# 5. Department Filtering Based on Manager IDs

```sql
SELECT *
FROM hr_data
WHERE employee_id NOT IN
(
    SELECT department_id
    FROM hr_data
    WHERE manager_id BETWEEN 100 AND 200
);
```

This demonstrates the use of:

* `NOT IN`
* Subqueries
* `BETWEEN`

---

# 6. Employees in Clara's Department

The query identifies employees associated with Clara's job classification while excluding Clara.

```sql
SELECT first_name,
       last_name,
       hire_date,
       department_id,
       job_id
FROM hr_data
WHERE job_id =
(
    SELECT job_id
    FROM hr_data
    WHERE first_name = "clara"
)
AND first_name != "clara";
```

This demonstrates how subqueries can dynamically identify a comparison value.

---

# 7. Employees in Departments Containing Employees Whose Name Contains "T"

```sql
SELECT employee_id,
       first_name,
       last_name
FROM hr_data
WHERE department_id IN
(
    SELECT department_id
    FROM hr_data
    WHERE first_name LIKE "%t%"
);
```

This demonstrates the use of `IN` with a subquery.

---

# Key Insights

### 1. Salary varies significantly across job categories

Analyzing minimum, maximum, average, and total salary by job provides a clearer understanding of compensation structures.

### 2. Salary benchmarking can identify unusual compensation levels

Employees above or below defined thresholds can be identified for further review.

### 3. Organizational averages provide useful compensation benchmarks

Employees earning above the average salary can be identified using a subquery.

### 4. SQL can analyze organizational relationships

Manager and department queries demonstrate how SQL can be used to investigate reporting structures.

### 5. Text functions are valuable for data preparation

Functions such as `CONCAT`, `TRIM`, `UPPER`, `LOWER`, `LEFT`, `RIGHT`, and `MID` can help prepare data for analysis and reporting.

---

# Skills Demonstrated

* SQL querying
* Data filtering
* Text manipulation
* String functions
* Aggregate functions
* Grouping
* Sorting
* Salary analysis
* HR analytics
* Subqueries
* Nested queries
* Conditional filtering
* Organizational analysis
* Compensation analysis
* Data transformation
* Business-question translation

---

# Tools & Technologies

* SQL
* MySQL
* Relational databases
* SQL aggregate functions
* SQL string functions
* SQL subqueries

---

# Project Outcome

This project demonstrates the ability to use SQL to transform employee data into meaningful HR information.

The analysis covers both fundamental and intermediate SQL concepts and provides a strong foundation for more advanced HR analytics involving:

* Employee attrition
* Compensation
* Promotion
* Performance
* Workforce planning
* Employee segmentation

---

# Conclusion

The HR Data Analysis project demonstrates how SQL can support practical HR decision-making.

By combining filtering, aggregation, textual functions, salary calculations, and subqueries, the project shows how raw employee information can be transformed into useful workforce insights.

The project is particularly valuable as a portfolio piece because it demonstrates both **technical SQL proficiency and the ability to connect SQL queries to real-world HR business questions**.
