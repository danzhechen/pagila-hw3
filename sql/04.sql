/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Children'
AND NOT EXISTS (
    SELECT 1
    FROM film_actor fa2
    JOIN film f2 ON f2.film_id = fa2.film_id
    JOIN film_category fc2 ON fc2.film_id = f2.film_id
    JOIN category c2 ON c2.category_id = fc2.category_id
    WHERE c2.name = 'Horror'
    AND fa2.actor_id = a.actor_id
)
GROUP BY a.last_name, a.first_name
ORDER BY a.last_name;
