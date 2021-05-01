
#problem statement: how to get the Net Balance derived from Amount depending upon Debit and Credit.


# Table and Insert Script

Create Table Account_Table(
TranDate timestamp,
TranID Varchar(20),
TranType Varchar(10),
Amount Float);

INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-12T05:29:44.120', 'A10001','Credit', 50000);
INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-13T10:30:20.100', 'B10001','Debit', 10000);
INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-13T11:27:50.130', 'B10002','Credit', 20000);
INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-14T08:35:30.123', 'C10001','Debit', 5000);
INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-14T09:43:51.100', 'C10002','Debit', 5000);
INSERT into Account_Table (TranDate, TranID, TranType, Amount) VALUES ('2020-05-15T05:51:11.117', 'D10001','Credit', 30000);


# Solution 1:
select sum(case when trantype ='Credit' then amount else 0-amount end) 
	over (order by trandate)
from Account_Table 
order by trandate;


# Solution 2:
select sum(case when trantype ='Credit' then amount else -1*amount end) 
	over (order by trandate)
from Account_Table 
order by trandate;