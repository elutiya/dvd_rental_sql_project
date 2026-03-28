-- TO BE PUSHED TO GITHUB



-Case Study 1: Customer Behavior Analysis
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
HAVING SUM(AMOUNT) >100	 and count(r.rental_id) >20	 
order by sum(amount) desc

