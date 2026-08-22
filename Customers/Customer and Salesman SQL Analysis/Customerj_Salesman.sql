select * from customerj;
select * from salesman;

-- SQL JOINS-- 
/*  A JOIN clause is used to combine rows from two or more tables, based
 on a related column between them.
 
Different Types of SQL JOINs
Here are the different types of the JOINs in SQL:

INNER JOIN: Returns records that have matching values in both tables
LEFT JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT JOIN: Returns all records from the right table, and the matched records from the left table*/

/* 1. write a SQL query to locate all the customers and the salesperson who works for them. Return customer name, and salesperson name.*/
select customerj.cust_name,salesman.name
from customerj
inner join salesman
on customerj.salesman_id = salesman.salesman_id;

select a.cust_name,b.name
from customerj a
inner join salesman b
on a.salesman_id = b.salesman_id;


/*2. write a SQL query to find the salespeople and customers who live in the same city. 
Return customer name, salesperson name and salesperson city.*/
select customerj.cust_name,salesman.name,salesman.city
from customerj
inner join salesman
on customerj.city = salesman.city;

select a.cust_name,b.name,b.city
from customerj a
inner join salesman b
on a.city = b.city;


/*3.write a SQL query to find those customers with a grade less than 300. 
Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending grade.*/
select customerj.cust_name,customerj.city,customerj.grade,salesman.name,salesman.city
from customerj
left join salesman
on customerj.salesman_id = salesman.salesman_id
where grade < 300
order by customerj.grade;

select customerj.cust_name,customerj.city,customerj.grade,salesman.name,salesman.city
from salesman
right join customerj
on customerj.salesman_id = salesman.salesman_id
where grade < 300
order by customerj.grade;


select a.cust_name,a.city,a.grade,b.name,b.city
from customerj a
left join salesman b
on a.salesman_id = b.salesman_id
where grade < 300
order by a.grade;

select a.cust_name,a.city,a.grade,b.name,b.city
from salesman b
right join customerj a
on a.salesman_id = b.salesman_id
where grade < 300
order by a.grade;



/*4. Write a SQL statement to generate a list in ascending order of salespersons who work either for one
OR more customers
OR have not yet joined any of the customers. 
Return cust_name,customer city, grade, Salesman, salesmancity*/
select customerj.cust_name,customerj.city,customerj.grade,salesman.name,salesman.city
from salesman
left join customerj
on customerj.salesman_id = salesman.salesman_id
order by salesman.name;

select customerj.cust_name,customerj.city,customerj.grade,salesman.name,salesman.city
from customerj
right join salesman
on customerj.salesman_id = salesman.salesman_id
order by salesman.name;


select a.cust_name,a.city,a.grade,b.name,b.city
from salesman b
left join customerj a
on a.salesman_id = b.salesman_id
order by b.name;

select a.cust_name,a.city,a.grade,b.name,b.city
from customerj a
right join salesman b 
on a.salesman_id = b.salesman_id
order by b.name;