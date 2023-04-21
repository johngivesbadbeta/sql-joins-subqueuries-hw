-- 1. List all customers who live in Texas (use JOINs)

SELECT first_name, last_name, district
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name

SELECT first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 175
	ORDER BY sum(amount) desc
);

-- 4. List all customers who live in Nepal (use the city table)

SELECT first_name, last_name, address, city, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id 
INNER JOIN city 
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff memeber had the most transactions?

SELECT first_name, last_name, staff.staff_id, count(payment.staff_id)
FROM staff
LEFT JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name, staff.staff_id;

-- 6. How many movies of each rating are there?

SELECT rating, count(rating)
FROM film
GROUP BY rating;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99
);

-- 8. How many free rentals did our stores give away?

SELECT count(amount)
FROM payment
WHERE amount < 0.01;
