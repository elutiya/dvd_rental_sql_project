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
