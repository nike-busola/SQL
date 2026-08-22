-- SQL CASE Expression--
/* The CASE expression goes through conditions and returns a 
value when the first condition is met 
(like an if-then-else statement). So, once a condition is true, 
it will stop reading and return the result. If no conditions are
 true, it returns the value in the ELSE clause.

If there is no ELSE part and no conditions are true, it returns NULL.

CASE Syntax
CASE
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  WHEN conditionN THEN resultN
  ELSE result
END;*




select * from emp;
/* above 3000 - high salary
btw 2000 and 3000 - avg
otherwise low salary*/

Select *,
case
when salary > 3000 then "High Salary"
when salary between 2000 AND 3000 then "Average Salary"
else "Low Salary"
end as REMARKS
from emp;