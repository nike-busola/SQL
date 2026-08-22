-- GROUP BY,ORDER BY AND HAVING--
/*The GROUP BY statement groups rows that have the 
same values into summary rows.The GROUP BY statement
 is often used with aggregate functions (COUNT(), 
 MAX(), MIN(), SUM(), AVG()) to group the result-set 
 by one or more columns.
 
 GROUP BY Syntax
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);

 SQL HAVING Clause
The HAVING clause was added to SQL because the 
WHERE keyword cannot be used with aggregate functions.*/

select * from pivot;
/* 1. get the different types of outlets and their counts */
select outlet_type, count(item_outlet_sales)
as TOTAL_COUNTS
from pivot
group by outlet_type
order by TOTAL_COUNTS desc;

/* 2. get the total sales for different outlets */
select outlet_identifier,round(sum(item_outlet_sales),0)
as TOTAL_SALES
from pivot
group by outlet_identifier
order by TOTAL_SALES desc;
 
/* 3. find out the total sales of different item types in different outlet types */
select item_type,outlet_type,round(sum(item_outlet_sales),0)
as TOTAL_SALES
from pivot
group by item_type,outlet_type
order by TOTAL_SALES desc;

/* 4. In the third Pivot table, filter out (remove) low fat products */
select item_type,outlet_type,round(sum(item_outlet_sales),0)
as TOTAL_SALES
from pivot
where not item_fat_content = "Low Fat"
group by item_type,outlet_type
