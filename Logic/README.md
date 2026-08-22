# Student Performance Analysis | SQL CASE Logic

## Project Overview

This project uses SQL **CASE expressions** to transform raw student examination results into meaningful academic classifications.

The analysis evaluates student performance across:

* Mathematics
* Reading
* Writing
* Test preparation

The project creates calculated fields that classify students according to:

* Pass/fail status
* Academic grade
* Course-repeat status
* Promotion status

The project demonstrates how SQL conditional logic can be used to transform numerical data into business or operational categories.

---

# Business Objective

The objective is to create a structured student-performance classification system that can help educators and administrators:

* Identify students who fail one or more subjects.
* Assign performance grades.
* Identify students requiring additional support.
* Determine whether students should repeat a preparation course.
* Support targeted academic interventions.

The project demonstrates how raw examination scores can be converted into **actionable student-performance information**.

---

# Dataset Overview

The dataset contains student examination information.

### Key Fields

| Field                     | Description                                               |
| ------------------------- | --------------------------------------------------------- |
| `math_score`              | Student mathematics score                                 |
| `reading_score`           | Student reading score                                     |
| `writing_score`           | Student writing score                                     |
| `test_preparation_course` | Whether the student completed the test preparation course |

---

# Performance Rules

The project applies the following classification logic.

## Fail Rule

A student is classified as **Failed** if their score is below 35 in at least one subject.

```text
Math < 35
OR
Reading < 35
OR
Writing < 35
```

Otherwise, the student is classified as:

```text
Passed
```

---

# Grade Rules

Students are assigned grades based on their subject performance.

### Grade A

The student scores above 75 in **all three subjects**.

```text
Math > 75
AND
Reading > 75
AND
Writing > 75
```

### Grade C

The student has failed at least one subject.

### Grade B

All other students fall into the B category.

---

# Status Rules

Students who:

* Failed at least one subject
* Did not complete the test preparation course

are assigned:

```text
Repeat course
```

All other students are classified as:

```text
Promoted
```

---

# SQL Implementation

## Step 1 — Create Pass/Fail View

```sql
CREATE VIEW log AS
SELECT *,
CASE
    WHEN math_score < 35
      OR reading_score < 35
      OR writing_score < 35
    THEN "Failed"
    ELSE "Passed"
END AS "FAIL"
FROM logic;
```

This creates a reusable analytical view containing a new `FAIL` field.

---

# Step 2 — Create Grade View

```sql
CREATE VIEW logg AS
SELECT *,
CASE
    WHEN math_score > 75
     AND reading_score > 75
     AND writing_score > 75
    THEN "A"

    WHEN FAIL = "failed"
    THEN "C"

    ELSE "B"
END AS "GRADE"
FROM log;
```

This builds the grade classification on top of the previous view.

---

# Step 3 — Create Final Result View

```sql
CREATE VIEW final_result AS
SELECT *,
CASE
    WHEN fail = "failed"
     AND test_preparation_course = "none"
    THEN "Repeat course"
    ELSE "Promoted"
END AS Status
FROM logg;
```

This creates the final student-performance dataset.

---

# Analytical Workflow

```text
Raw Student Data
       ↓
Subject Scores
       ↓
Pass/Fail Classification
       ↓
Grade Classification
       ↓
Test Preparation Evaluation
       ↓
Final Academic Status
```

This demonstrates how multiple SQL views can be layered to create a structured analytical workflow.

---

# Why CASE Logic Is Important

The SQL `CASE` expression is one of the most useful tools for transforming data.

It is similar to an:

```text
IF → THEN → ELSE
```

logic structure.

For example:

```sql
CASE
    WHEN condition THEN result
    ELSE result
END
```

This allows numerical or categorical data to be converted into business-friendly classifications.

---

# Business Applications

Although this project uses student data, the same SQL logic can be applied to many business scenarios.

### HR

Classify employees as:

* High performer
* Average performer
* Performance improvement required

### Banking

Classify customers as:

* Low risk
* Medium risk
* High risk

### Marketing

Classify customers as:

* High value
* Medium value
* Low value

### Sales

Classify sales representatives as:

* Above target
* On target
* Below target

### Customer Service

Classify customers according to satisfaction or complaint severity.

---

# Key Insights

The project demonstrates that raw numerical scores alone may not be sufficient for decision-making.

By applying conditional logic, the data becomes easier to interpret.

For example:

```text
Raw Score → Performance Category → Intervention
```

This creates a clear path from data to action.

---

# Skills Demonstrated

* SQL CASE expressions
* Conditional logic
* Boolean operators
* `AND`
* `OR`
* SQL views
* Data transformation
* Rule-based classification
* Student performance analysis
* Data interpretation
* Business logic implementation

---

# Tools & Technologies

* SQL
* MySQL
* SQL Views
* CASE expressions

---

# Project Outcome

The project creates three analytical stages:

1. **FAIL** — identifies students who fail at least one subject.
2. **GRADE** — assigns students to A, B, or C categories.
3. **STATUS** — identifies students who require a repeat course or are promoted.

This demonstrates how SQL can transform raw examination data into an operational decision-support system.

---

# Conclusion

The Student Performance Analysis project demonstrates the power of SQL conditional logic for classification and decision-making.

Using `CASE` expressions and SQL views, raw student scores are transformed into meaningful performance categories and recommended academic actions.

The project demonstrates a transferable analytical skill: **turning business rules into SQL logic that produces actionable classifications**.
