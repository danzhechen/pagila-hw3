/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
WITH RankedRentals AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        f.title,
        fc.category_id,
        r.rental_date,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY r.rental_date DESC) AS rn
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id AND cat.name = 'Action'
), ActionFanatics AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        COUNT(*) AS ActionCount
    FROM RankedRentals
    WHERE rn <= 5
    GROUP BY customer_id, first_name, last_name
    HAVING COUNT(*) >= 4
)
SELECT
    af.customer_id,
    af.first_name,
    af.last_name
FROM ActionFanatics af
ORDER BY af.customer_id;

