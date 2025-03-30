
-- multiple of 2 till 20 --

WITH RECURSIVE count_cte AS (
  -- Step 1: Define recursive CTE
    -- Anchor member: Start with 1
    SELECT 1 AS number
  
    UNION ALL
  
    -- Recursive member: Increment the number by 1 until 20
    SELECT number * 2
    FROM count_cte
    WHERE number <= 20
)

-- Step 2: Select al; nums from recurssive CTE
SELECT number
FROM count_cte
