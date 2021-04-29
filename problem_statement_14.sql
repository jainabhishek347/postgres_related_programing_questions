
# Problem_statement: How to print Prime Numbers


# Solution 1:
WITH x AS (
  SELECT * FROM generate_series( 2, 1000 ) x
)
SELECT x.x
FROM x
WHERE NOT EXISTS (
  SELECT 1 FROM x y
  WHERE x.x > y.x AND x.x % y.x = 0
)
;


# Solution 2:

SELECT serA.el AS prime
FROM generate_series(2, 100) serA(el)
LEFT JOIN generate_series(2, 100) serB(el) ON serA.el >= POWER(serB.el, 2)
                                              AND serA.el % serB.el = 0
WHERE serB.el IS NULL