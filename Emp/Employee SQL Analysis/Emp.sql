/*SELECT STATEMENTS (SELECT,SELECT DISTINCT,SELECT WHERE)
SELECT statement is used to select data from a database
SELECT DISTINCT is used to return only distinct values
SELECT WHERE is used to filter records that meets a given condition*/

select * from emp;
-- write a sql query to find the emp name, job name and hire date of the employees --
select emp_name,job_name,hire_date from emp;

-- write a sql query to find the jobs of the employees --
select distinct job_name from emp;

-- write a sql query to bring out all the employees that belongs to the analyst department --
select * from emp where job_name = "analyst";

/* write a sql query to bring out all the employees that belongs to 
the managers department.return emp_name,salary,hire_date*/
select emp_name,salary,hire_date from emp where job_name = "manager";

-- SQL COMPARISON OPERATORS()
/*write a sql query to return all employees
receiving above 2000 as their salary*/
select * from emp where salary > 2000;


-- LOGICAL OPERATIONS AND, OR, NOT OPERATOR --
/*AND operator is used to filter records based on more 
than one condition.

OR operator is used to filter records that matches either one 
or both of the condition.

NOT operator returns records that do not match the condition.

LIKE operator is used to search for data that matches a 
specific patterns.

in operator allows you to specify multiple values in a where 
clause*/

/*write a sql query to return all the employees that
belongs to the analyst department and receiving 
above 2000 as salary*/
select * from emp where job_name = "analyst" and salary > 2000;

/*write a sql query to return employees in either
department 1001 or 3001*/
select * from emp where dep_id = 1001 or dep_id = 3001;

/*write a sql query to return employees who do not
belong to the salesman department*/
select * from emp where job_name <> "salesman";
select * from emp where job_name != "salesman";
select * from emp where not job_name = "salesman";

-- write a sql query to return all employees that starts with "A" --
select * from emp where emp_name like "a%";
select * from emp where emp_name like "%e";
select * from emp where emp_name like "a_e%";
select * from emp where emp_name like "%kayling%";

-- write a sql query to return employees with ID NUM 67832,68319,66564 --
select * from emp where emp_id = 67832 or emp_id = 68319 or emp_id = 66564;
select * from emp where emp_id in (67832,68319,66564);




-- write a SQL query to find the salaries of all employees. Return salary --
select salary from emp;

-- write a SQL query to find the unique designations of the employees. Return job name --
select distinct job_name from emp;

-- write a SQL query to find the employee ID, salary, and commission of all the employees --
select emp_ID,salary,commission from emp;

-- write a SQL query to find those employees who do not belong to the department 2001 --
select * from emp where dep_id <> "2001";

-- write a SQL query to find the details of the employee ‘BLAZE’ --
select * from emp where emp_name = "BLAZE";

-- write a SQL query to identify employees whose commissions exceed their salaries. Return complete information about the employees --
select * from emp where commission > salary;

-- write a SQL query to find those employees whose designation is ‘SALESMAN’. Return complete information about the employees --
select * from emp where job_name = "salesman";