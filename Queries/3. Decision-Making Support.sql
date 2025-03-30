--1. Identify Low-Performing Categories --

SELECT c.name, COUNT(fc.film_id) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
HAVING COUNT(fc.film_id) < 900; -- Threshold can be adjusted

-- 2. Sales by Store. --

SELECT 
    s.store_id,
    SUM(p.amount) AS total_sales
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 3. Sales by Film Category. --

SELECT 
    c.name AS category,
    SUM(p.amount) AS total_sales
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name;

-- 4. Analyze customer preferences for different release years. --

SELECT f.release_year, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.release_year
ORDER BY rental_count DESC;

-- 5. Determine the optimal inventory levels for different movie titles. --

SELECT 
    f.title,
    COUNT(i.inventory_id) AS inventory_count,
    COUNT(r.rental_id) AS rental_count,
    (COUNT(r.rental_id) / COUNT(i.inventory_id)) AS rental_rate
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_rate DESC;
