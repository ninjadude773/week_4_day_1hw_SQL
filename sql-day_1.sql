SELECT * 
FROM actor; 

SELECT customer_id,amount
FROM payment
WHERE amount BETWEEN 2.00 AND 7.99;

--Query for data that shows customers who paid
-- an amount NOT EQUAL to $0.00 
-- Ordered in DESCENDING Order
SELECT customer_id, amount
FROM payment
WHERE amount <> 0.00
ORDER BY amount DESC;


--SQL Agreegations => SUM(), AVG(), COUNT(), MIN(), MAX()

--Query to display sum of amounts payed that are greater than 5.99
SELECT SUM(amount)
FROM payment
WHERE amount > 5.99;

--Query to average of amounts payed that are greater than $5.99
SELECT AVG(amount)
FROM payment
WHERE amount > 5.99;

--Query to display the count of amounts paid that are greater than $5.99
SELECT COUNT (amount)
FROM payment 
WHERE amount > 5.99;

--Query to display the count  DISTINCT amounts paid that are greater than $5.99
SELECT COUNT (DISTINCT amount)
FROM payment 
WHERE amount > 5.99;

--Query to display min amount greater than 7.99
SELECT MIN(amount) as MIN_Num_Payments
FROM payment
WHERE amount > 7.99;


--Query to display max amount greater than 7.99
SELECT MAX (amount) AS Max_Num_Payments
FROM payment
WHERE amount > 7.99;

-- Query to display all amounts (quick demo of groupby)
SELECT amount
FROM payment 
WHERE amount = 10.99;

--Query to display different amounts that are grouped together
--and count the amounts
SELECT amount, COUNT(amount)
FROM payment
GROUP BY amount
ORDER BY amount;

--Query to display customer_ids with the summed amounts for each customer_id
SELECT customer_id, amount
FROM payment
GROUP BY customer_id,amount
ORDER BY customer_id DESC;



-- HOMEWORK Section
-- Example Random Problem - Which film-rating do we have the most of (film table)?
--Select * From table to start (always) to see what kind of data you are working with 
SELECT rating, COUNT (rating)
from film 
GROUP BY rating 
ORDER BY COUNT (rating) DESC;


--Question 1 How many actors are there with the last name ‘Wahlberg’? 
SELECT last_name
FROM actor 
WHERE last_name = 'Wahlberg';

-- There are two actors with this last name. 


--Question 2.) How many payments were made between $3.99 and $5.99? 

SELECT COUNT(amount)
FROM payment
WHERE amount BETWEEN 2.00 AND 7.99;

--10,491 payments were made between 3.99 and 5.99


--Question 3.) What film does the store have the most of? (search in inventory) 
SELECT *
FROM inventory;
SELECT *
FROM film;



--Question 4.) How many customers have the last name ‘William’? 
SELECT *
FROM customer;
SELECT COUNT(last_name)
FROM customer
WHERE last_name LIKE 'William';


--Question 5.) What store employee (get the id) sold the most rentals?  - Mike did

SELECT *
FROM staff;
SELECT *
FROM rental;
SELECT fromInv.staff_id, staff.staff_ID, staff.first_name, fromInv.countSold
FROM staff, (
	SELECT rental.staff_id, COUNT(staff_id) countSold
	FROM rental
	GROUP BY rental.staff_id
	ORDER BY countSold DESC
	LIMIT 1) fromInv
WHERE staff.staff_Id = fromInv.staff_id;



--Question 6.) How many different distinct names are there? 

SELECT COUNT(DISTINCT full_name)
FROM (
	SELECT CONCAT(first_name, ' ', last_name)
	FROM actor
) full_name;


--Question 7.) What film has the most actors in it? (use film_actor table and get film_id) 

SELECT *
FROM film_actor;
SELECT *
FROM film;
SELECT COUNT(film_actor.actor_id) actorsPerFilm, film.title 
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id, film.title
ORDER BY actorsPerFilm DESC
LIMIT 1;


--Question 8.) From store_id 1, how many customers have a last name ending with ‘es’? (use customer table) 

SELECT *
FROM customer;
SELECT COUNT(last_name) inglastnames
FROM customer
WHERE store_id = 1 AND last_name LIKE '%es';



-- Question 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals 
--above 250 for customers  with ids between 380 and 430? (use group by and having > 250) 

SELECT *
FROM payment;
SELECT amount, COUNT(rental_id)
FROM payment
WHERE customer_id BETWEEN 380 and 430
GROUP BY amount
HAVING COUNT(rental_id) > 250;

-- Question 10. Within the film table, how many rating categories are there? And what rating has the most  movies total? 223

SELECT *
FROM film;

SELECT COUNT(DISTINCT rating)
FROM film;
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC
LIMIT 1;

