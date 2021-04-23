
# Problem Statement:
/*
Consider you are tracking all Policy Payment data in below format. Write an sql query to generate Delinquency Counter; 
set to 0 for payments before due date 
and incremented by 1 when payment is delayed 
and reset to 0 on next timely payment.


Table_name = policy_transactions
Table columns
transaction_id, Customer_id, Policy_id, Amount, Due_Date, Paid_date, Finance_Charges, Payment_mode, Discounts
*/

DROP TABLE policy_transactions;

CREATE TABLE policy_transactions (
    id serial NOT NULL,
    policy_id integer,
    due_date date,
    paid_date date,
    customer_id integer
);

truncate table policy_transactions;
INSERT INTO policy_transactions (policy_id, due_date, paid_date, customer_id) 
VALUES
(1, '2016-01-01', '2016-01-01', 1),
(1, '2016-02-01', '2016-02-05', 1),
(2, '2016-03-02', '2016-03-01', 1),
(2, '2016-04-03', '2016-04-06', 1),
(2, '2016-05-03', '2016-05-07', 1),
(2, '2016-06-03', '2016-06-08', 1),

(3, '2016-01-01', '2016-01-01', 2),
(3, '2016-02-01', '2016-02-01', 2),
(3, '2016-03-02', '2016-03-01', 2),
(3, '2016-04-03', '2016-04-01', 2),
(3, '2016-05-03', '2016-05-06', 2),
(3, '2016-06-03', '2016-06-10', 2),
(3, '2016-07-03', '2016-07-10', 2),

(3, '2016-05-03', '2016-05-06', 3),
(3, '2016-06-03', '2016-06-10', 3),
(3, '2016-07-03', '2016-07-10', 3),
(3, '2016-07-03', '2016-08-10', 3);

# solution:
 
WITH temp AS (
	SELECT *, paid_date> due_date AS missed_due_date
	FROM policy_transactions
	), temp2 as( select *, lag(missed_due_date) over() as previous_due_status,
			case when missed_due_date then 1 else 0 end as missing_rank
		from temp
		)select *, sum(missing_rank) over(partition by customer_id,policy_id, missing_rank order by paid_date) from temp2;
