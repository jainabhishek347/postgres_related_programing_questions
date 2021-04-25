
#Problem Statements :- Write a SQL which will fetch total schedule of 
#matches between each Team vs opposite team:

/*
Input :-  Team Table has two columns namely ID and TeamName 
and it contains 4 TeamsName.
*/

create table teams (id serial, name varchar(40));
insert into teams (name) values ('india'),
('australia'), 
('england'),
('new zealand');

# Solution:

select concat( a.name, ' vs ', b.name) from teams as a
join teams b 
on a.id < b.id;