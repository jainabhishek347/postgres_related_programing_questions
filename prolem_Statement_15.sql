
#Problem statement: How to Print Fibonacci Series in SQL


WITH Recursive temp1 AS (
  SELECT 0 as first_num ,  1 as second_num
  union all
  select second_num as first_num, second_num + first_num as second_num from temp1
  where second_num< 100
 )select first_num from temp1;


-- print Fibonacci Series till first 100 elements. Using bigint as index out of range error can occur with integer.


WITH Recursive temp1 AS (
  SELECT 0::bigint as first_num ,
    	1::bigint as second_num, 1 as step
  union all
  select second_num::bigint as first_num, 
  	second_num + first_num as second_num , 
  	step+1 as step
  	from temp1
  where step< 80
 )select first_num from temp1;
