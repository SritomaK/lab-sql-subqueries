use sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS 'number_of_copies'
    FROM inventory
    WHERE inventory.film_id= (
		SELECT film_id FROM film WHERE title = "Hunchback Impossible"
        );
        
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

-- option 1

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- option 2 with subqueries

SELECT AVG(length) FROM film;

SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film)
ORDER BY length ASC;

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT 
	first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                    
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT * FROM category;

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));
                    
-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT * FROM address;
SELECT * FROM country;

SELECT 
    first_name, last_name, email
FROM
    customer
        JOIN
    address ON customer.address_id = address.address_id
WHERE
    address.city_id IN (SELECT 
            city_id
        FROM
            city
        WHERE
            country_id = (SELECT 
                    country_id
                FROM
                    country
                WHERE
                    country = 'Canada'));

