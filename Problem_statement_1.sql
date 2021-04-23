"""
Problem Statements :-
Write a SQL which will explode the above data into single unit level records as shown below

"""

INPUT :-  Order_Tbl has four columns namely ORDER_ID, PRODUCT_ID, QUANTITY and PRICE


DROP TABLE Order_Tbl;

CREATE TABLE Order_Tbl(
 ORDER_DAY date,
 ORDER_ID varchar(10) ,
 PRODUCT_ID varchar(10) ,
 QUANTITY int
);

INSERT INTO Order_Tbl(ORDER_DAY,ORDER_ID,PRODUCT_ID,QUANTITY)
VALUES ('2015-05-01','ODR1', 'PROD1', 5), 
	('2015-05-01','ODR2', 'PROD2', 2), 
	('2015-05-01','ODR3', 'PROD3', 10);


WITH RECURSIVE temp1 as (select order_day, order_id, product_id, 1 as quantity from Order_Tbl union all select b.order_day, b.order_id, b.product_id, temp1.quantity+1 as quantity from Order_Tbl b join temp1 on temp1.order_id =b.order_id where temp1.quantity < b.quantity) select * from temp1 order by order_id , quantity;


WITH RECURSIVE temp1 AS 
	(select order_day, order_id, product_id, 1 AS quantity , 1 AS cnt
		FROM Order_Tbl 
		UNION ALL 
		SELECT b.order_day, b.order_id, b.product_id, 1 AS quantity , cnt +1 AS cnt
		FROM Order_Tbl b 
		JOIN temp1 on temp1.order_id =b.order_id 
		WHERE temp1.cnt < b.quantity
	) SELECT order_day, order_id, product_id, quantity
	  FROM temp1 
	  ORDER BY order_id, product_id, quantity;