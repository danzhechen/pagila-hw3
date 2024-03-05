/*
 * Compute the country with the most customers in it. 
 */
SELECT cy.country
FROM customer c
JOIN address ad on ad.address_id = c.address_id
JOIN city ct on ct.city_id = ad.city_id
JOIN country cy on cy.country_id = ct.country_id
GROUP BY cy.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 1;
