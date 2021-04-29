/*
Input :- Transaction_Table has four columns  namely  AccountNumber, TransactionTime, TransactionID and Balance

*/

#Problem Statements :- Write SQL to get the most recent / latest balance, and TransactionID for each AccountNumber


create table transaction_table 
(
AccountNumber int,
Transaction_Time timestamp,
Transaction_ID int,
Balance Int 
);
insert into transaction_table values (550,'2020-05-12 05:29:44.120',1001,2000);
insert into transaction_table values (550,'2020-05-15 10:29:25.630',1002,8000);
insert into transaction_table values (460,'2020-03-15 11:29:23.620',1003,9000);
insert into transaction_table values (460,'2020-04-30 11:29:57.320',1004,7000);
insert into transaction_table values (460,'2020-04-30 12:32:44.233',1005,5000);
insert into transaction_table values (640,'2020-02-18 06:29:34.420',1006,5000);
insert into transaction_table values (640,'2020-02-18 06:29:37.120',1007,9000);

# Solution 1:

with temp1 as (
	select AccountNumber,
		Transaction_Time,
		Transaction_ID,
		Balance,
		row_number() over (partition by AccountNumber order by Transaction_Time desc ) as rank
	from transaction_table
	)select * from temp1 
	where rank =1;

# Solution 2:

select * from transaction_table a 
join (select max(Transaction_Time) as Transaction_Time,AccountNumber 
	from transaction_table 
	group by AccountNumber
	)b 
on b.AccountNumber=a.AccountNumber 
and a.Transaction_Time = b.Transaction_Time;

