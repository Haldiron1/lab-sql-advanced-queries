USE sakila;

#List each pair of actors that have worked together.

SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
       CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
GROUP BY actor1, actor2
ORDER BY actor1, actor2;

#For each film, list actor that has acted in more films.

SELECT f.title AS film_title,
       CONCAT(a.first_name, ' ', a.last_name) AS most_frequent_actor,
       COUNT(*) AS num_films
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id, most_frequent_actor
HAVING COUNT(*) = (
    SELECT MAX(actor_film_count)
    FROM (
        SELECT f.film_id, a.actor_id, COUNT(*) AS actor_film_count
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        JOIN actor a ON fa.actor_id = a.actor_id
        GROUP BY f.film_id, a.actor_id
    ) AS actor_film_counts
    WHERE actor_film_counts.film_id = f.film_id
)
ORDER BY film_title;



