-- QUALIFY command
-- In a SELECT statement, the QUALIFY clause filters the results of window functions.

CREATE TABLE qt (i INTEGER, p CHAR(1), o INTEGER);
INSERT INTO qt (i, p, o) VALUES
    (1, 'A', 1),
    (2, 'A', 2),
    (3, 'B', 1),
    (4, 'B', 2);

-- 1. With CTE
with t1 as (
    SELECT i, p, o,
        ROW_NUMBER() OVER (PARTITION BY p ORDER BY o) AS row_num
    FROM qt
)
select * from t1 where row_num = 1;

-- Using Qualify
SELECT i, p, o
FROM qt
QUALIFY ROW_NUMBER() OVER (PARTITION BY p ORDER BY o) = 1;