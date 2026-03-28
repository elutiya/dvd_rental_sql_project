-- TO BE PUSHED TO GITHUB

--Section 1: DDL and DML (Scenario-Based)
--Scenario 1: A new customer walks into the store to rent a movie. You need to capture all the necessary information.
--1. Write the DDL to create a new temporary table called new_customer with appropriate fields (first_name, last_name, email, address_id, active, etc.).
--2. Insert a record for the new customer into the new_customer table.
--3. Insert the customer into the main customer table based on the record in new_customer.
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
-- below we insert records into new_customer table which is our temp table
INSERT INTO new_customer (customer_id,store_id,first_name, last_name,email,address_id, activebool,create_date,last_update,active)
VALUES(600,2,'Tesfaye','Hankebo','tesfaye@gamil.com',606, true,current_timestamp, now(),1)
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
HAVING SUM(AMOUNT) >100   and count(r.rental_id) >20   
order by sum(amount) desc