-- Create a CTE to calculate the total rental count and total rental amount for each customer -- 

WITH CustomerStats AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rental_count,
        SUM(p.amount) AS total_rental_amount
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    JOIN 
        payment p ON r.rental_id = p.rental_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
-- Selecting data from the CTE
SELECT 
    customer_id,
    first_name,
    last_name,
    total_rental_count,
    total_rental_amount
FROM 
    CustomerStats
ORDER BY 
    total_rental_count DESC;
