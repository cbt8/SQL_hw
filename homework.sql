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

#INNER JOIN payment
 #   ON staff.staff_id = payment.staff_id



#Having a strange problem here, where staff_id shows up both as 1 and 2 when I view each table separately, but when I try to join, the join only displays
#staff_id 1
#SELECT* from payment
#SELECT* from staff

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
