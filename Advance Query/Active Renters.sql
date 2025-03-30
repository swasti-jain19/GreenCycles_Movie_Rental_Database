-- Use the CTE to filter customers who have rented more than the average number of films --

-- Step 1: Create a CTE to calculate the rental stats for each customer
WITH CustomerStats AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rentals,
        SUM(p.amount) AS total_amount
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    JOIN 
        payment p ON r.rental_id = p.rental_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
),
-- Step 2: Calculate the average number of rentals
AverageRentals AS (
    SELECT 
        AVG(total_rentals) AS avg_rentals
    FROM 
        CustomerStats
)
-- Step 3: Filter customers with rentals above the average
SELECT 
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.total_rentals,
    cs.total_amount
FROM 
    CustomerStats cs
JOIN 
    AverageRentals ar ON cs.total_rentals > ar.avg_rentals
ORDER BY 
    cs.total_rentals DESC;
