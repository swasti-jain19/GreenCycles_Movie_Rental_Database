--  Check for Null Values. --

SELECT TABLE_NAME, COLUMN_NAME, COUNT(*) AS null_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('customer', 'film', 'inventory', 'rental', 'payment') 
  AND DATA_TYPE NOT IN ('timestamp', 'datetime') -- Exclude timestamp and datetime columns
  AND IS_NULLABLE = 'YES'
GROUP BY TABLE_NAME, COLUMN_NAME;

-- Check for Duplicate Values. --

SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);

--  Data Type Consistency. --

SELECT *
FROM film
WHERE LENGTH(title) > 255;  -- Assuming title is VARCHAR(255)

-- Check for inconsistencies in rental dates. --

SELECT *
FROM rental
WHERE rental_date > return_date;

-- Identify films with invalid release years. (release years before the invention of motion pictures ie 1895). --

SELECT *
FROM film
WHERE release_year < 1895;

-- Verify that all customers have a valid address. --

SELECT *
FROM customer
WHERE address_id IS NULL; 

-- Check for inconsistencies in staff assignments --

SELECT *
FROM staff
WHERE store_id IS NULL; 
