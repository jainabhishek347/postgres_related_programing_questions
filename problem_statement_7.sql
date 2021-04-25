
# Problem statement:
/* Write a SQL  to find all Employees who earn more than the 
average salary in their corresponding department.
*/


#INPUT :-  Employee Table has four columns namely EmpID , EmpName, Salary and DeptID

drop table emp;

create table emp (EmpID int, EmpName varchar(25), Salary int, DeptID int);

INSERT INTO emp (EmpID, EmpName, Salary, DeptID)
VALUES
	(1001, 'Mark', 60000, 2),	
	(1002, 'Antony', 40000, 2),	
	(1003, 'Andrew', 15000, 1),	
	(1004, 'Peter', 35000, 1),	
	(1005, 'John', 55000, 1),	
	(1006, 'Albert', 25000, 3),	
	(1007, 'Donald', 35000, 3);

#solution:

with selected_emp as( 
select *,
avg(Salary) over( partition by DeptID )  as avg_salary
from emp
)select *from selected_emp where Salary>avg_salary;