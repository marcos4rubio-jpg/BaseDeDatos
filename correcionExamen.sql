-- consulta 1
SELECT 
    district AS distrito, 
    COUNT(address) AS num_direcciones
FROM address
GROUP BY district                       -- address_id lo puse y no hay que ponerlo
ORDER BY num_direcciones DESC, district ASC;

-- consulta 2
SELECT 
    a.first_name AS nombre, 
    a.last_name AS apellido, 
    f.title AS titulo, 
    f.length AS duracion_minutos
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
WHERE f.length >= 150
				-- group by a.actor_id, a.first_name, a.last_name no habia que poner group by
ORDER BY f.title ASC, a.last_name ASC;

-- consulta 3
SELECT 
    co.country AS pais, 
    COUNT(DISTINCT a.address) AS num_ciudades, 
    COUNT(a.address_id) AS total_direcciones
FROM country co
JOIN city ci USING (country_id)
JOIN address a USING (city_id)
WHERE co.country like 'India' or co.country like 'China'          -- puse and y es or 
GROUP BY co.country_id, co.country
having  COUNT(DISTINCT a.address) >= 1
ORDER BY total_direcciones DESC;

-- consulta 4
SELECT 
    f.title AS titulo, 
    COUNT(fi.actor_id) AS actores
FROM film f
JOIN film_actor fi USING (film_id)
WHERE f.rating = 'PG-13'
GROUP BY f.film_id, f.title
HAVING COUNT(fi.actor_id) >= 6
ORDER BY actores DESC, f.title ASC;



-- consulta 5
SELECT 
    DAYOFWEEK(r.rental_date) AS dia_semana,  -- solo puese day y eso cuenta dias del mes no de la semana
    COUNT(r.rental_id) AS total_alquileres, 
    COUNT(r.return_date) AS devueltos
FROM customer c
JOIN rental r USING (customer_id)
WHERE c.first_name LIKE 'S%'
GROUP BY DAYOFWEEK(r.rental_date)     -- rental_id lo puse y no hay que ponerlo
ORDER BY dia_semana ASC;


