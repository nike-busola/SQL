 -- TEXTUAL FUNCTIONS --
 -- (CONCATENATE,TRIM,UPPER,LOWER,LEFT,RIGHT,MID) --
select * from hr_data;
select concat(first_name," ",last_name) as FULL_NAME from hr_data;
select upper(first_name) as FIRST_NAME from hr_data;
select lower(last_name) as LAST_NAME from hr_data;
select trim(email) from hr_data;
select left(hire_date,2) as DAY from hr_data;
select right(hire_date,4) as YEAR from hr_data;
select mid(hire_date,4,2) as MONTH from hr_data;


-- write a SQL query to find those employees whose salaries are less than 6000. Return full name (first and last name), and salary. --
select concat(first_name," ",last_name) as FULL_NAME, salary
from hr_data
where salary < 6000;

-- write a SQL query to find those employees whose salary is higher than 8000. Return first name, last name and department number and salary --
select concat(first_name," ",last_name) as FULL_NAME, department_id, salary
from hr_data
where salary > 8000;

-- write a SQL query to find those employees whose first name does not contain the letter ‘M’. Sort the result-set in ascending order by department ID. Return full name (first and last name together), hire_date, salary and department_id --
select concat(first_name," ",last_name)
as FULL_NAME,hire_date,salary,department_ID
from hr_data
where not first_name like "%M%"
order by department_ID;

-- write a SQL query to count the number of employees, the sum of all salary and difference between the highest salary and lowest salaries by each job id. Return job_id, count, sum, salary_difference --
select job_ID,count(employee_ID) as emoloyee_counts,
sum(salary) as total_salary,
max(salary)-min(salary) as salary_difference
from hr_data
group by job_ID;

-- write a SQL query to find those employees whose salaries are not between 7000 and 15000 --
select * from hr_data
where not salary between 7000 and 15000;

-- write a SQL query to list the employees’ name and increased their salary by 15% --
select concat(first_name," ",last_name) 
as full_name,salary * 1.15 
as increased_salary from hr_data;

-- write a SQL query to compute the average salary of each job ID. Exclude those records where average salary is on or lower than 8000. Return job ID, average salary --
select job_id, avg(salary) as average_salary
from hr_data
where salary <= 6000
group by job_id;


-- SQL SUBQUERY--
-- A subquery is a Select query that is enclosed inside another query.--
/* 1. write a SQL query to find those employees who receive a higher salary than the employee with ID 163. Return first name, last name.*/
select first_name,last_name from hr_data 
where salary >
(select salary from hr_data where employee_id = 163);

/*2. write a SQL query to find out which employees have the same designation as the employee whose ID is 169. Return first name, last name, department ID and job ID.*/
select first_name,last_name,department_id,job_id from hr_data 
where job_id = 
(select job_id from hr_data where employee_id = 169);
 
 /*3. write a SQL query to find those employees who earn more than the average salary. Return first name, last name, employee ID.*/
select first_name,last_name,employee_id from hr_data
where salary >
(select avg(salary) as average_salary from hr_data);

/*4.write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.*/
select first_name,last_name,employee_ID from hr_data
where manager_ID =
(select employee_ID from hr_data where first_name = "payam");

/*5. write a SQL query to find those employees who do not work in the departments where managers’IDs are between 100 and 200. Return all the fields of the employees.*/
select * from hr_data where employee_ID not in
(select department_ID from hr_data where manager_ID
between 100 and 200);

/*6.write a SQL query to find those employees who work in the same department as ‘Clara’. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.*/
select first_name,last_name,hire_date,department_ID,job_ID from hr_data
where job_ID = (select job_ID from hr_data
where first_name = "clara") and first_name != "clara";
 
/*7.write a SQL query to find those employees who work in a department where the employee’s first name contains the letter 'T'. Return employee ID, first name and last name. */
select employee_ID,first_name,last_name from hr_data
where department_ID in (select department_ID from hr_data
where first_name like "%t%");