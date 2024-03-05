/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */
SELECT cy.country, SUM(p.amount) AS total_payments
FROM customer c
JOIN address ad on ad.address_id = c.address_id
JOIN city ct on ct.city_id = ad.city_id
JOIN country cy on cy.country_id = ct.country_id
JOIN payment p on c.customer_id = p.customer_id
GROUP BY cy.country
ORDER BY total_payments DESC, cy.country;
