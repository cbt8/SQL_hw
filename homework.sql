USE sakila;

#1a 
SELECT first_name, last_name
FROM actor;

#1b
SELECT CONCAT(first_name, " ", last_name) FROM actor;

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";

#2b
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%GEN%";

#2c
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

#2d
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China")

#3a
ALTER TABLE actor ADD description BLOB;

#3b
ALTER TABLE actor DROP description;

#4a
SELECT COUNT(last_name), last_name FROM actor GROUP BY last_name; 

#4b
SELECT COUNT(last_name), last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) >1; 

#4c
UPDATE actor SET first_name = "HARPO" WHERE first_name="GROUCHO" AND last_name = "WILLIAMS";

#4d
UPDATE actor SET first_name = "GROUCHO" WHERE first_name="HARPO" AND last_name = "WILLIAMS";

#5a
SHOW CREATE TABLE address;

#6a

SELECT staff.first_name, staff.last_name, address.address FROM staff
JOIN address ON staff.address_id=address.address_id;

#6b
SELECT first_name, last_name, sum(amount), payment.staff_id
FROM staff
INNER JOIN payment
    ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE "%-08-%"
GROUP BY first_name    

#6c
SELECT COUNT(actor_id), title
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY title

#6d
SELECT COUNT(inventory_id), film.title, inventory_id
FROM inventory 
INNER JOIN film
ON  inventory.film_id = film.film_id 
WHERE film.title = "Hunchback Impossible" 
#GROUP BY film.title

#6e

SELECT SUM(amount), payment.customer_id, customer.last_name, customer.first_name
FROM payment
INNER JOIN customer
ON  payment.customer_id = customer.customer_id 
GROUP BY last_name

#7a

SELECT title
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%" AND language_id = 
( SELECT language_id FROM language WHERE name = "English")

#7b
SELECT last_name, first_name FROM actor
WHERE actor.actor_id IN (SELECT film_actor.actor_id FROM film_actor WHERE film_actor.film_id = (SELECT film.film_id FROM film WHERE film.title = "Alone Trip"))
GROUP BY last_name

#7c
#name and address of all Canadian customers. Use Join

SELECT address.address, address.address2, customer.last_name, customer.first_name
FROM address
INNER JOIN customer
ON  address.address_id = customer.address_id 
WHERE address.city_id IN (SELECT city.city_id FROM city WHERE city.country_id = (SELECT country.country_id FROM country WHERE country.country = "Canada"))

#7d
#All movies categorized as family films. 

SELECT film.title FROM film WHERE film_id IN 
(SELECT film_id FROM film_category WHERE category_id = 
(SELECT category_id FROM category WHERE name = "Family"))

#7e most frequently rented movies in descending order


SELECT COUNT(rental_id), film.title
FROM rental 
INNER JOIN inventory 
ON rental.inventory_id = inventory.film_id
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(rental_id) DESC

#7f How much business in dollars did each store bring in?

#Note: This is essentially the same query from above, but with sum() instead of count()

SELECT SUM(payment.amount), address.address
FROM payment 
INNER JOIN staff
ON payment.staff_id = staff.staff_id
INNER JOIN address
ON staff.address_id = address.address_id
GROUP BY address.address
ORDER BY SUM(payment.amount) DESC

#7g

SELECT store_id, city, country
FROM store
INNER JOIN address
ON address.address_id = store.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON city.country_id = country.country_id

#7h top five genres ranked by gross revenue in descending order

SELECT SUM(payment.amount), category.name
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category
ON film_category.film_id = inventory.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY name
ORDER BY sum(payment.amount) DESC

#8a
CREATE VIEW Genre_by_Gross_Revenue AS 
SELECT SUM(payment.amount), category.name
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category
ON film_category.film_id = inventory.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY name
ORDER BY sum(payment.amount) DESC

#8b
SELECT * FROM Genre_by_Gross_Revenue

#8c
DROP VIEW Genre_by_Gross_Revenue