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


/*Create a column 'Fail?' to identify students who have scored 
 less than 35 marks in atleast one of the subjects*/
 
  /*Create a column 'Grade' and assign it 'A' for all the students
 who have score more than 75 in all the subjects, 'C'  to Failing
 students and 'B' to all other students*/
 
  /*Identify the students who have Failed and have not completed 
 the 'test preperation course'. Assign 'Repeat course' value 
 in 'Status' column */

create view log as
select *,
case when math_score < 35 or reading_score <35 or writing_score <35
then "Failed"
else "Passed"
end as "FAIL"
from logic;

select * from log;

create view logg as
 select *,
case when math_score > 75 and reading_score >75 and writing_score > 75
then "A"
when FAIL = "failed" then "C"
else "B"
end as "GRADE"
from log;

select * from logg;
create view final_result as
select *,
case
when fail ="failed" and test_preparation_course ="none" then "Repeat course"
else "Promoted"
end as Status
from logg;

select * from final_result;