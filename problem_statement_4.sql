# Problem statement:

/*

Shown below is a fragment of Orders table. 
Write SQL query to fetch all Orders where Customer has used the coupon 'HSBC-5%' 
more than 3 times in any 5 consecutive days window
*/

# Dummpy data:

DROP TABLE Orders;

CREATE TABLE Orders (
    id serial NOT NULL,
    order_date date,
    coupon_code varchar(40),
    user_id integer
);

INSERT INTO Orders (order_date, coupon_code,user_id) VALUES
('2015-01-01','HSBC-5',1),
('2015-01-01','XYZ',1),
('2015-01-02','XYZ',1),
('2015-01-03','HSBC-5',1),
('2015-01-04','XYZ',1),
('2015-01-05','HSBC-5',1),
('2015-01-06','HSBC-5',1),
('2015-01-07','HSBC-5',1),
('2015-01-08','HSBC-5',1),
('2015-01-01','HSBC-5',2),
('2015-01-02','XYZ',2),
('2015-01-03','HSBC-5',2),
('2015-01-03','XYZ',2),
('2015-01-04','HSBC-5',2),
('2015-01-05','ABC',2),
('2015-01-06','HSBC-5',2),
('2015-01-07','HSBC-5',2),
('2015-01-08','HSBC-5',2);


INSERT INTO Orders (order_date, coupon_code,user_id) VALUES
('2015-02-06','HSBC-5',2),
('2015-02-08','HSBC-5',2),
('2015-02-10','HSBC-5',2);

INSERT INTO Orders (order_date, coupon_code,user_id) VALUES
('2015-02-07','ds-5',2),
('2015-02-09','AdsC-5',2),


INSERT INTO Orders (order_date, coupon_code,user_id) VALUES
('2015-03-06','HSBC-5',2),
('2015-03-08','HSBC-5',2),
('2015-03-10','HSBC-5',2);



# Solution:

# first lets create a group of consecutive dates
SELECT user_id
       ,order_date, 
       order_date - ( 
       		dense_rank() 
       			OVER (PARTITION BY user_id ORDER BY order_date)
       		)::int AS grp
      FROM Orders;


# Based on consecutive date group check if it has 3 matched coupon code within 5 consecutive dates. 
with temp1 as (SELECT id, user_id
       ,order_date, 
       coupon_code,
       order_date - ( 
       		dense_rank() 
       			OVER (PARTITION BY user_id ORDER BY order_date)
       		)::int AS grp
      FROM Orders
      ),  temp2 AS(
      	SELECT *, 
      		count(grp) over(PARTITION by grp) AS group_count, 
      		count(grp) over(PARTITION by grp) >=5 AS group_with_5_consiciutive_dates, 
      		count(coupon_code LIKE 'HSBC-5%') over(PARTITION by grp) >=3 AS group_with_minimum_3_match
      	FROM temp1      	
      ) SELECT * FROM temp2 
      	WHERE coupon_code LIKE 'HSBC-5%'
      		AND group_with_minimum_3_match 
      		AND group_with_5_consiciutive_dates 
      	ORDER BY user_id, order_date;


# Approach 2:

with temp1 as (SELECT id, user_id
       ,order_date, 
       coupon_code,
       order_date - ( 
       		dense_rank() 
       			OVER (PARTITION BY user_id ORDER BY order_date)
       		)::int AS grp,
        dense_rank() OVER (PARTITION BY user_id
                            ORDER BY order_date)
      FROM Orders
      ),  temp2 as(
      	select *, count(grp) over(PARTITION by grp) as group_count from temp1
      ) 
      select array_agg(id),
      	user_id,
      	grp,
      	min(order_date),
      	max(order_date),
      	count(grp) as group_count ,
      	sum((coupon_code like 'HSBC-5%' )::int) as coupon_code_count
      from temp2 
      where group_count >=5
      group by user_id, grp 
      having count(coupon_code like 'HSBC-5%')>=3
      order by grp;      



       
