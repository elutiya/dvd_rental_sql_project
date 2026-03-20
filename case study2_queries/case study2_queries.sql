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