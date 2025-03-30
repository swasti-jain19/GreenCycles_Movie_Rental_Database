-- Identify customers who have spent more than the average amount on rentals and list the films they have rented. --

-- Step 1: Define the CTE for calculating total spending per customer
WITH customer_spending AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name

-- Step 2: Define the CTE for finding high-spending customers
high_spending_customers AS (
    SELECT cs.customer_id, cs.first_name, cs.last_name, cs.total_spent
    FROM customer_spending cs
    WHERE cs.total_spent > (SELECT AVG(total_spent) FROM customer_spending)
)

-- Step 3: Use the CTEs to find films rented by high-spending customers
SELECT
    hsc.customer_id,
    hsc.first_name,
    hsc.last_name,
    hsc.total_spent,
    f.film_id,
    f.title
FROM high_spending_customers hsc
JOIN rental r ON hsc.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;
