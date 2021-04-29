/*
How to Print Alphabets A to Z in SQL

*/

# Approach:  postgresql-recursive-query
/*

syntax of a recursive CTE

WITH RECURSIVE cte_name AS(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion  -- recursive term
) SELECT * FROM cte_name;

A recursive CTE has three elements:

Non-recursive term: the non-recursive term is a CTE query definition that forms the base result set of the CTE structure.
Recursive term: the recursive term is one or more CTE query definitions joined with the non-recursive term using the UNION or UNION ALL operator. The recursive term references the CTE name itself.
Termination check: the recursion stops when no rows are returned from the previous iteration.
PostgreSQL executes a recursive CTE in the following sequence:

Execute the non-recursive term to create the base result set (R0).
Execute recursive term with Ri as an input to return the result set Ri+1 as the output.
Repeat step 2 until an empty set is returned. (termination check)
Return the final result set that is a UNION or UNION ALL of the result set R0, R1, … Rn

*/

# REF: https://www.postgresqltutorial.com/postgresql-recursive-query/

# Solution:

WITH RECURSIVE TEMP AS (
select CHR(ASCII('A')) AS NUM 
UNION ALL
select CHR(ASCII(NUM)+1) AS NUM FROM TEMP WHERE  NUM<>'Z'
)SELECT * FROM TEMP;