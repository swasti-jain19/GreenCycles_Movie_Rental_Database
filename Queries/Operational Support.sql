--1. Generate Rental Reports - --

SELECT 
    r.rental_id,
    c.first_name,
    c.last_name,
    f.title,
    r.rental_date,
    r.return_date
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;


--2. Retrieve the rental history for a specific movie say film_id = 101.  --

SELECT 
    c.first_name, 
    c.last_name, 
    r.rental_date, 
    r.return_date
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.film_id = 101;

-- 3. List all movies currently rented by a specific customer (customer_id = X)

SELECT 
    f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = X AND r.return_date IS NULL; -- Replace X with customer_id

-- 4. Generate daily/monthly sales reports by store

-- Daily
SELECT 
    s.store_id,
    DATE(p.payment_date) AS sale_date,
    SUM(p.amount) AS daily_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id, DATE(p.payment_date)
ORDER BY s.store_id, sale_date;

-- Monthly
SELECT 
    s.store_id,
    DATE_TRUNC('month', p.payment_date) AS sale_month,
    SUM(p.amount) AS monthly_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id, DATE_TRUNC('month', p.payment_date)
ORDER BY s.store_id, sale_month;


-- 5. Identify slow-moving inventory

SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) < 5; -- Adjust the threshold as needed

-- 6. Track inventory losses (assuming lost if not rented in a month)

SELECT 
    i.inventory_id,
    f.title
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL AND i.last_update < CURRENT_DATE - INTERVAL '1 month';

-- 7. Generate staff performance reports

SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    COUNT(r.rental_id) AS rentals_handled
FROM staff s
LEFT JOIN rental r ON s.staff_id = r.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY rentals_handled DESC;

-- 8. Manage inventory levels as 'Low Stock', 'Sufficient Stock'

SELECT 
    f.title,
    COUNT(i.inventory_id) AS inventory_count,
    CASE 
        WHEN COUNT(i.inventory_id) < 5 THEN 'Low Stock'
        ELSE 'Sufficient Stock'
    END AS stock_status
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;
