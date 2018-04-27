use  sakila;

###1a#####
SELECT 
    first_name, last_name
FROM
    sakila.actor;
###1b#####

SELECT 
    CONCAT(first_name, ' ', last_name) AS Actor_Name
FROM
    sakila.actor;
	
###2a#####

SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    first_name LIKE 'joe';
	
###2b#####
    
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    last_name LIKE '%GEN%';
	
###2c#####
    
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    last_name LIKE '%LI%'
ORDER BY last_name , first_name;

###2d#####

SELECT 
    `country_id`
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');
	
###3a#####
   
alter table actor add column middle_name varchar(10) after first_name;

###3b#####

alter table actor modify column middle_name blob ;

###3c#####

alter table actor drop column middle_name  ;

###4a#####

SELECT 
    last_name, COUNT(*)
FROM
    sakila.actor
GROUP BY last_name;

###4b#####

SELECT 
    last_name, COUNT(*) AS cnt
FROM
    sakila.actor
GROUP BY last_name
HAVING cnt >= 2;

###4c#####

UPDATE actor 
SET 
    first_name = 'HARPO',
    last_name = 'WILLIAMS'
WHERE
    first_name = 'GROUCHO'
        AND last_name = 'WILLIAMS';
		
###4d#####
    
UPDATE actor 
SET 
    first_name = CASE
        WHEN first_name = 'HARPO' THEN 'GROUCHO'
        ELSE 'MUCHO GROUCHO'
    END
WHERE
    actor_id = 172;  
	
###5a#####

 SHOW CREATE TABLE sakila.address;
 
###6a#####

SELECT 
    first_name, last_name, address
FROM
    staff s
        INNER JOIN
    address a ON s.address_id = a.address_id;
	
###6b#####

SELECT 
    first_name, last_name, SUM(amount)
FROM
    staff s
        INNER JOIN
    payment p ON s.staff_id = p.staff_id
WHERE
    p.payment_date LIKE '2005-08%'
GROUP BY first_name , last_name;

###6c#####

SELECT 
    title, COUNT(actor_id)
FROM
    film_actor AS fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY title;

###6d#####

SELECT 
    i.film_id, title, COUNT(i.film_id)
FROM
    inventory i
        INNER JOIN
    film f ON f.film_id = i.film_id
WHERE
    f.title = 'Hunchback Impossible';
	
###6e#####

SELECT 
    last_name, first_name, SUM(amount)
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;

###7a#####

SELECT 
    title
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
WHERE
    l.name = 'English'
        AND (f.title LIKE 'k%' OR f.title LIKE 'q%');
		
###7b#####
        
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
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
					
###7c#####
				
SELECT 
    first_name, last_name, email, country
FROM
    customer cu
        JOIN
    address a ON (cu.address_id = a.address_id)
        JOIN
    city cit ON (a.city_id = cit.city_id)
        JOIN
    country cntry ON (cit.country_id = cntry.country_id)
WHERE
    cntry.country = 'Canada';
    
###7d#####
   
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
            category_id IN (SELECT 
                    category_id
                FROM
                    category c
                WHERE
                    name = 'Family'));
###7e#####

SELECT 
    f.title, COUNT(i.inventory_id) AS count
FROM
    inventory i
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY title
ORDER BY count DESC;

###7f#####

SELECT 
    s.store_id, SUM(amount)
FROM
    payment p
        JOIN
    customer c ON p.customer_id = c.customer_id
        JOIN
    store s ON c.store_id = s.store_id
GROUP BY s.store_id;

###7g#####
SELECT 
    s.store_id, c.city, co.country
FROM
    store s
        JOIN
    address a ON s.address_id = a.address_id
        JOIN
    city c ON a.city_id = c.city_id
        JOIN
    country co ON co.country_id = c.country_id;
	
###7h#####

SELECT 
    c.name, SUM(amount) AS gross
FROM
    category c
        JOIN
    film_category f ON c.category_id = f.category_id
        JOIN
    inventory i ON i.film_id = f.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY gross DESC
LIMIT 5;

###8a#####
    
CREATE VIEW top_5_genre AS
    SELECT 
        c.name, SUM(amount) AS gross
    FROM
        category c
            JOIN
        film_category f ON c.category_id = f.category_id
            JOIN
        inventory i ON i.film_id = f.film_id
            JOIN
        rental r ON r.inventory_id = i.inventory_id
            JOIN
        payment p ON p.rental_id = r.rental_id
    GROUP BY c.name
    ORDER BY gross DESC
    LIMIT 5;
    
###8b#####
   
SELECT 
    *
FROM
    top_5_genre;
###8c#####
   drop view top_5_genre;
