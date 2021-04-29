/*
Input :- SalesTable has four columns  namely  ID, Product , SalesYear and QuantitySold

Problem Statements :- Write SQL to get the total Sales 
in year 1998,1999 and 2000 for all the products as shown below.

The crosstab function receives an SQL SELECT command as a parameter, which must be compliant with the following restrictions:

The SELECT must return 3 columns.
The first column in the SELECT will be the identifier of every row in the pivot table or final result. In our example, this is the student's name. Notice how students' names (John Smith and Peter Gabriel) appear in the first column.
The second column in the SELECT represents the categories in the pivot table. In our example, these categories are the school subjects. It is important to note that the values of this column will expand into many columns in the pivot table. If the second column returns five different values (geography, history, and so on) the pivot table will have five columns.
The third column in the SELECT represents the value to be assigned to each cell of the pivot table. These are the evaluation results in our example.

ref: https://learnsql.com/blog/creating-pivot-tables-in-postgresql-using-the-crosstab-function/

*/

drop Table Sales;

Create Table Sales (
ID int,
Product Varchar(25),
SalesYear Varchar(25),
QuantitySold Varchar(25)
);


Insert into Sales Values(1,'Laptop','1998','2500'),(2,'Laptop','1999','3600')
,(3,'Laptop','2000','4200')
,(4,'Keyboard','1998','2300')
,(5,'Keyboard','1999','4800')
,(6,'Keyboard','2000','5000')
,(7,'Mouse','1998','6000')
,(8,'Mouse','1999','3400')
,(9,'Mouse','2000','4600');


# solution 1:

select 'TotalSales' as TotalSales, 
sum(case when SalesYear=1998 then QuantitySold else 0 end ) as "1998" ,
sum(case when SalesYear=1999 then QuantitySold else 0 end ) as "1999",
sum(case when SalesYear=2000 then QuantitySold else 0 end) as  "2000"
from Sales_Table;

# solution 2 using crosstab:

SELECT * 
FROM crosstab( 'select Product, SalesYear, QuantitySold::int as QuantitySold
	from Sales') 
     AS final_result(Product varchar, "1999" Int, "2000" Int, "1998" int);


SELECT * 
FROM crosstab( 'select Product::text , 
			SalesYear::text, 
			sum(QuantitySold::int)::text as QuantitySold
        from Sales group by Product, SalesYear order by Product, SalesYear') 
     AS final_result(Product text, "1999" text, "2000" text, "1998" text);


SELECT * 
FROM crosstab( 'select Product::text , SalesYear::text, sum(QuantitySold::int) over(order by SalesYear)::text as QuantitySold
        from Sales order by Product, SalesYear') 
     AS final_result(Product text, "1999" text, "2000" text, "1998" text);


SELECT * 
FROM crosstab( 'select ''TotalSales''::text , SalesYear::text, sum(QuantitySold::int) over(order by SalesYear)::text as QuantitySold
        from Sales order by Product, SalesYear') 
     AS final_result(Product text, "1999" text, "2000" text, "1998" text);

