--Section 1: DDL and DML (Scenario-Based)
--Scenario 1: A new customer walks into the store to rent a movie. You need to capture all the necessary information.


--1. Write the DDL to create a new temporary table called new_customer with appropriate fields (first_name, last_name, email, address_id, active, etc.).

CREATE temporary TABLE new_customer-- THIS IS OUR TEMPORARY TABLE and we capture all records for new custmerss
(
  customer_id integer,
  store_id smallint,
  first_name character varying(45),
  last_name character varying(45),
  email character varying(50),
  address_id smallint,
  activebool boolean,
  create_date date,
  last_update timestamp,
  active integer
)


--2. Insert a record for the new customer into the new_customer table.
-- below we insert records into new_customer table which is our temp table

INSERT INTO new_customer (customer_id,store_id,first_name, last_name,email,address_id, activebool,create_date,last_update,active)
VALUES(600,2,'Tesfaye','Hankebo','tesfaye@gamil.com',606, true,current_timestamp, now(),1)


--3. Insert the customer into the main customer table based on the record in new_customer.
-- FIRST WE HAVE TO INSERT INTO ADDRES TABLE THE ADRESSE_ID COULUM,

INSERT INTO address (address_id,address,address2,district,city_id,postal_code,phone,last_update)
VALUES( 606,'25 Miknos Manor','null','CapeTown',576,'c125','275658784',now())
--BELOW WE INSERT ALL THER RECORDS FROM TEMPORARY TABLE TO PERMENENT TABLE
INSERT INTO customer(customer_id,store_id,first_name,last_name,email,address_id,activebool,create_date,last_update,active)
SELECT customer_id,store_id,first_name,last_name,email,address_id,activebool,create_date,last_update,active
FROM new_customer
-- LETS CHECK IF THE NEW CUSTOMER RECORD HAS BEEN INSERTED CORRECTLTY
SELECT * FROM CUSTOMER
WHERE first_name='Tesfaye'

--4. Simulate a new rental:
--Insert a new record into the rental table for this customer, including rental date, inventory_id (assume it's available), and staff_id.
SELECT * FROM rental
where customer_id=600
/*we inspected the rental table schema, noting 
that fields like rental_id and last_update are auto generated, while rental_date requires the current timestamp. 
We also ensured that the inventory item being rented was available by checking the rental table for any active 
rentals using that inventory ID with a null return_date. When we confirmed the item was free, we proceeded to 
insert the rental record, linking it to the correct customer, staff member, and inventory item, and validated the 
action through a follow-up query. */
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
VALUES (CURRENT_TIMESTAMP, 007, 600, 1);
--5. Insert a corresponding payment record into the payment table for this rental, recording the amount and payment date.
SELECT * FROM payment
where customer_id=600
INSERT INTO payment(customer_id,staff_id,rental_id,amount,payment_date)
values(600,1,16050,3.99,current_timestamp)

____________________________________________________________________



-- Scenario 2: A new film is released and needs to be added to the system.


-- 6. Create a temporary table new_film with fields such as title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, and rating.
CREATE TEMP TABLE new_film (
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    language_id INT,
    rental_duration INT,
    rental_rate NUMERIC(4,2),
    length INT,
    replacement_cost NUMERIC(5,2),
    mpaa_rating mpaa_rating  -- use the enum type
);


-- 7. Insert a record for the new film into new_film table.

INSERT INTO new_film
(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, mpaa_rating)
VALUES
('AI Revolution', 'A sci-fi thriller about the rise of AI in 2030.', 2026, 1, 7, 3.99, 120, 19.99, 'PG-13');


-- 8. Insert the new film into the main film table using the data from new_film.

INSERT INTO film
(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
SELECT
    title,
    description,
    release_year,
    language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    mpaa_rating,
    NOW()  -- last_update
FROM new_film;


-- 9. Add inventory: insert 3 available copies of this new film into the inventory table, assigning them to different store locations.
-- There are 2 stores (store_id = 1 and store_id = 2)
-- Assign inventory to different stores

INSERT INTO inventory (film_id, store_id, last_update)
VALUES
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    1,
    NOW()
),
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    2,
    NOW()
),
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    1,
    NOW()
);


____________________________________________________________________

-- Section 2: DQL — Data Query Language (SELECT, WHERE, Aggregates, GROUP BY, HAVING, ORDER BY, JOINS, Subqueries)
-- General Analysis

-- 8. List the top 10 longest movies along with their length and title.

	SELECT  title, length 
	FROM film
	ORDER BY length DESC
	limit 9;


-- 9. Find all customers who have rented more than 10 movies.

	SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
	FROM customer c
	JOIN rental r ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name
	HAVING COUNT(r.rental_id) > 10;


-- 10. Get the average rental rate for each movie rating (G, PG, R, etc.).

	SELECT rating, AVG(rental_rate) AS avg_rental_rate
	FROM film
	GROUP BY rating;


-- 11. Find the top 5 cities with the most customers.

	SELECT ci.city, count(c.customer_id) AS total_customer
	FROM customer c
	JOIN address a on a.address_id = c.address_id
	JOIN city ci on ci.city_id = a.city_id
	group by ci.city
	ORDER BY count(c.customer_id) DESC
	limit 5;


-- 12. Show the total revenue (payment amount) collected by each staff member.

	SELECT s.staff_id, s.first_name, s.last_name, count(p.amount) as Total_revenue
	FROM payment p
	JOIN  staff s ON s.staff_id = p.staff_id
	group by s.staff_id, s.First_name, s.last_name


-- 13. Retrieve the 10 most rented films along with how many times each was rented.

	SELECT f.title, COUNT(r.rental_id) AS times_rented
	FROM Rental r
	JOIN Inventory i ON r.inventory_id = i.inventory_id
	JOIN Film f ON i.film_id = f.film_id
	GROUP BY f.film_id, f.title
	ORDER BY COUNT(r.rental_id) DESC
	LIMIT 10;
	

-- 14. Find the customer who has spent the most in total payments.

	SELECT c.customer_id, c.first_name, c.last_name, COUNT(p.amount) AS total_payments
	FROM payment p 
	JOIN customer c  ON c.customer_id = p.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name
	ORDER BY COUNT(p.amount) DESC
	LIMIT 1;


-- 15. List all movies that have never been rented.

	SELECT f.title,f.description, f.release_year 
	FROM Film f
	LEFT JOIN Inventory i ON f.film_id = i.film_id
	LEFT JOIN Rental r ON i.inventory_id = r.inventory_id
	WHERE r.rental_id IS NULL;


____________________________________________________________________


--Case Study 1: Customer Behavior Analysis

--A marketing team wants to identify loyal customers to send special discount offers.
 select * from customer
 select * from payment

--Write a query to find customers who rented more than 20 movies and spent more than $100 in total.
--Return their full name, email, total rentals, and total amount paid.
--Sort the results by the total amount spent, highest first.

SELECT 
  c.first_name,
  c.last_name,
  c.email,
  sum(p.amount) as TOTAL_PAYMENTS,
  count(r.rental_id) as TOTAL_RENTALS
FROM CUSTOMER as c
INNER JOIN RENTAL as r on c.customer_id=r.customer_id
INNER JOIN payment as p on r.rental_id=p.rental_id
group by c.first_name,
       c.last_name,
       c.email
HAVING SUM(AMOUNT) >100   and count(r.rental_id) >20   
order by sum(amount) desc


____________________________________________________________________


--Case Study 2
--Find all films that have been rented fewer than 5 times.
SELECT 
f.title,
COUNT(r.rental_id) AS rental_count
FROM film f
LEFT JOIN inventory i 
ON f.film_id = i.film_id
LEFT JOIN rental r 
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) < 5
ORDER BY rental_count ASC;
							
--Return the film title, rental count, and average rental rate for each
  SELECT 
 f.title AS film_title,
 COUNT(r.rental_id) AS rental_count,
 AVG(f.rental_rate) AS avg_rental_rate
 FROM film f
 LEFT JOIN inventory i 
 ON f.film_id = i.film_id
 LEFT JOIN rental r 
 ON i.inventory_id = r.inventory_id
 GROUP BY f.title
 ORDER BY rental_count DESC;
--Sort the result by rental count, lowest first, and limit to 20 films.
 SELECT 
 f.title,
 COUNT(r.rental_id) AS rental_count
 FROM film f
 LEFT JOIN inventory i 
 ON f.film_id = i.film_id
 LEFT JOIN rental r 
 ON i.inventory_id = r.inventory_id
 GROUP BY f.title
 ORDER BY rental_count ASC
 LIMIT 20;

____________________________________________________________________