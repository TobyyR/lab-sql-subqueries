use sakila;

SELECT COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);

SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT fa.actor_id, COUNT(fa.film_id) AS film_count
FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY film_count DESC
LIMIT 1;
SELECT f.film_id, f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = 107;

SELECT p.customer_id, SUM(p.amount) AS total_amount
FROM payment p
GROUP BY p.customer_id
ORDER BY total_amount DESC
LIMIT 1;
SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = 526;

SELECT customer_id, total_amount_spent
FROM (
    SELECT p.customer_id, SUM(p.amount) AS total_amount_spent
    FROM payment p
    GROUP BY p.customer_id
) AS customer_totals
WHERE total_amount_spent > (SELECT AVG(total_amount_spent) FROM (
    SELECT SUM(p.amount) AS total_amount_spent
    FROM payment p
    GROUP BY p.customer_id
) AS subquery);
