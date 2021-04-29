#Problem Statements :- Write SQL to display total number of matches played, 
# matches won, matches tied and matches lost for each team


create table Match_result
(
id int,
Team1 varchar(100),
Team2 Varchar(100),
Result Varchar(100)
);

insert into Match_result Values (1,'India','Australia','India');
insert into Match_result Values (2,'India','England','England');
insert into Match_result Values (3,'SuthAfrica','India','India');
insert into Match_result Values (4,'Australia','England',NULL);
insert into Match_result Values (5,'England','SuthAfrica','SuthAfrica');
insert into Match_result Values (6,'Australia','India','Australia');

#solution 1:

with unique_teams as (
	select Team1 as team,
		count(*) as total_match,
		sum( case when Team1 = Result then 1 else 0 END) as match_won_count,
		sum( case when Team1 != Result then 1 else 0 END) as match_lose_count,
		sum( case when Result is NULL then 1 else 0 END) as match_tie_count
	from Match_result group by 1
	union all
	select Team2 as team, 
		count(*) as total_match,
		sum( case when Team2 = Result then 1 else 0 END) as match_won_count,
		sum( case when Team2 != Result then 1 else 0 END) as match_lose_count,
		sum( case when Result is NULL then 1 else 0 END) as match_tie_count
	from Match_result group by 1
)select team, 
		sum(total_match) as match_played,
		sum(match_won_count) as match_won_count,
		sum(match_lose_count) as match_lose_count,
		sum(match_tie_count) as match_tie_count
	from unique_teams group by 1 order by 1;


#solution 2:

with matches as
(
    select Team1 as team, result from Match_result
    UNION ALL
    select Team2 as team, result from Match_result
)
select 
    team, count(1) Matches_Played,
    sum(case when result=team then 1 else 0 end ) Matches_Won,
    sum(case when result is NULL then 1 else 0 end) Matches_Tied,
    sum(case when result!=team then 1 else 0 end) Matches_Lost
from matches group by team order by 1;