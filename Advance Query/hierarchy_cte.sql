-- Goal: Identify and list all subcategories of a specified category within a hierarchy--

WITH RECURSIVE cte_name AS (
    -- Anchor member
    SELECT columns
    FROM table
    WHERE condition
  
     -- Recursive member
    SELECT columns
    FROM table
    JOIN cte_name ON condition
)
SELECT col
FROM cte_name;

-- step : 1- create a new hierarchical category table-- 

CREATE TABLE hierarchical_category (
    category_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    parent_category_id INTEGER REFERENCES hierarchical_category(category_id)
);

-- step : 2- Insert data --

INSERT INTO hierarchical_category (category_id, name, parent_category_id) VALUES
(1, 'Action', NULL),
(2, 'Animation', NULL),
(3, 'Children', 2),  -- Children under Animation
(4, 'Classics', 1),  -- Classics under Action
(5, 'Comedy', 1),     -- Comedy under Action
(6, 'Superhero', 4),  -- Superhero under Classics
(7, 'Slapstick', 5),  -- Slapstick under Comedy
(8, 'Documentary', NULL),
(9, 'Nature', 8),     -- Nature under Documentary
(10, 'Space', 9),     -- Space under Nature
(11, 'Astronomy', 10); -- Astronomy under Space

-- Step 3: Query new category table

SELECT * FROM hierarchical_category;

-- rec CTE in new hierarchical category table-- 

WITH RECURSIVE category_hierarchy AS (
    -- Anchor member: Select the given category
    SELECT c.category_id, c.name, c.parent_category_id , 1 AS depth
    FROM hierarchical_category c
    WHERE c.category_id = 1  -- Start with the given category (e.g., category_id = 1)
  
    UNION ALL
  
    -- Recursive member: Select subcategories of the current set of categories
    SELECT c.category_id, c.name, c.parent_category_id, ch depth + 1 AS depth
    FROM hierarchical_category c
    INNER JOIN category_hierarchy ch ON c.parent_category_id = ch.category_id
    WHERE ch.depth < 2 -- limit recursion depth to 2 levels 
)

-- Step 2: Select all subcategories from the recursive CTE
SELECT category_id, name, parent_category_id
FROM category_hierarchy;

