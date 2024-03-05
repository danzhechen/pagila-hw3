/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH Bacall_1 AS (
    SELECT DISTINCT fa2.actor_id
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    JOIN film_actor fa2 ON f.film_id = fa2.film_id
    WHERE a.first_name = 'RUSSELL' AND a.last_name = 'BACALL'
), Bacall_2 AS (
    SELECT DISTINCT fa3.actor_id
    FROM Bacall_1
    JOIN film_actor fa2 ON Bacall_1.actor_id = fa2.actor_id
    JOIN film f2 ON fa2.film_id = f2.film_id
    JOIN film_actor fa3 ON f2.film_id = fa3.film_id
    WHERE fa3.actor_id NOT IN (SELECT actor_id FROM Bacall_1)
    AND fa3.actor_id NOT IN (
        SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
    )
)
SELECT DISTINCT a.first_name ||' '|| a.last_name AS "Actor Name"
FROM actor a
JOIN Bacall_2 ON a.actor_id = Bacall_2.actor_id
ORDER BY "Actor Name";
