select * from customerj;

-- write a SQL query to locate the details of customers with grade values above 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select * from customerj
where grade > 100;

-- write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select * from customerj
where city = "New York" and grade > 100;

-- write a SQL query to find customers who are from the city of New York or have a grade of over 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select * from customerj
where city = "New York" or grade > 100;

-- write a SQL query to find customers who are either from the city 'New York' or who do not have a grade greater than 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select * from customerj
where city = "New York" or not grade > 100;

-- write a SQL query to find details of all orders excluding those with ord_date equal to '2012-09-10' and salesman_id higher than 5005 or purch_amt greater than 1000. --
-- Return ord_no, purch_amt, ord_date, customer_id and salesman_id.  =orders --
select * from orders
where not ord_date = "2012/09/10"
and salesman_id > 5005 or purch_amt > 1000;



-- write a SQL query to locate the details of customers with grade values above 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select customer_id,cust_name,city,grade,salesman_id
from customerj
where grade > 100;

-- write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select customer_id,cust_name,city,grade,salesman_id
from customerj
where city = "New York" and grade > 100;

-- write a SQL query to find customers who are from the city of New York or have a grade of over 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select customer_id,cust_name,city,grade,salesman_id
from customerj
where city = "New York" or grade > 100;

-- write a SQL query to find customers who are either from the city 'New York' or who do not have a grade greater than 100. Return customer_id, cust_name, city, grade, and salesman_id. --
select customer_id,cust_name,city,grade,salesman_id
from customerj
where city = "New York" or not grade > 100;

-- write a SQL query to find details of all orders excluding those with ord_date equal to '2012-09-10' and salesman_id higher than 5005 or purch_amt greater than 1000. --
-- Return ord_no, purch_amt, ord_date, customer_id and salesman_id.  =orders --
select ord_no,purch_amt,ord_date,customer_id,salesman_id
from orders
where not ord_date = "2012/09/10"
and salesman_id > 5005 or purch_amt > 1000;