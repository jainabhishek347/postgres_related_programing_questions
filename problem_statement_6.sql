
# Problem statement:

/*
Write SQL query to get list of unique combinations played between 2020-01-01 and 2020-02-01

Game_Number, Team_A, Team_B, Date, Team_A_score, Team_B_score
1, ('IND', 'USA', '2020-01-01') , 10, 20
2, ('USA', 'IND', '2020-01-02') , 10, 20
3, ('AUS', 'IND', '2020-01-02') , 30, 15
4, ('IND', 'AUS', '2020-01-03') , 22, 34
5, ('UAE', 'AUS', '2020-01-04') , 14, 41

*/
create table match_plan 
	(
		id serial NOT NULL,
		Team_A varchar(40),
		Team_B varchar(40), 
		match_date Date 
	);

truncate match_plan;
insert into match_plan (Team_A, Team_B, match_date )values
	('IND', 'USA', '2020-01-01'),
	('USA', 'IND', '2020-01-02'),
	('AUS', 'IND', '2020-01-02'),
	('IND', 'AUS', '2020-01-03'),
	('IND', 'SZ', '2020-01-03'),
	('UAE', 'AUS', '2020-01-04');

# Solution:

-- Teams who have more then one match 
with temp as(
        select * , row_number() over(partition by Team_A, Team_B order by Team_A, Team_B) as row
        from match_plan
), temp2 as (
select a.Team_A, a.Team_B, 
case when b.Team_B = a.Team_A and b.Team_A = a.Team_B then 1 else 0 end as match
from temp as a
join temp b 
on b.id > a.id and (b.Team_B = a.Team_A and b.Team_A = a.Team_B)        
where a.row=1)
select -- distinct Team_A, Team_B 
*
from temp2;


-- Teams who have only one match 

with temp as( 
select a.Team_A, a.Team_B, case when b.Team_B = a.Team_A and b.Team_A = a.Team_B then 1 else 0 end as match
from match_plan as a
join match_plan b 
on (b.Team_B = a.Team_A and b.Team_A = a.Team_B)	
)
select Team_A, Team_B from match_plan
except
select Team_A, Team_B from temp;

