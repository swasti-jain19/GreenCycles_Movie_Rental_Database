-- List the details of the films rented by these high-rental customers.-- 

-- Step 1: Create a CTE to calculate the total rental count and total rental amount for each customer
 
WITH customer_totals AS (
    SELECT c.customer_id, c.first_name, c.last_name,
           COUNT(r.rental_id) AS rental_count,
           SUM(p.amount) AS total_amount
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON c.customer_id = p.customer_id AND p.rental_id = r.rental_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
 
-- Step 2: Calculate the average rental count across all customers
 
average_rental_count AS (
    SELECT AVG(rental_count) AS avg_rental_count
    FROM customer_totals
)
,
 
-- Step 3: Identify customers who have rented more than the average number of films (high-rental customers)
 
high_rental_customers AS (
    SELECT ct.customer_id, ct.first_name, ct.last_name, ct.rental_count, ct.total_amount
    FROM customer_totals ct
    JOIN average_rental_count arc ON ct.rental_count > arc.avg_rental_count
)
 
-- Step 4: List the details of the films rented by these high-rental customers
 
SELECT hrc.customer_id, hrc.first_name, hrc.last_name, hrc.rental_count, hrc.total_amount, f.film_id, f.title
FROM high_rental_customers hrc
JOIN rental r ON hrc.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;

