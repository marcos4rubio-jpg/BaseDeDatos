-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS holaaa
-- ==============================================
-- 27/10/2026
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
select actor_id, concat(first_name, ' ', last_name) as Nombre, count(film_id)
 from actor
 join film_actor using (actor_id)
 group by actor_id;

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
select actor_id, concat(first_name, ' ', last_name) as Nombre, count(film_id)
from actor 
join film_actor using (actor_id)
group by actor_id
having count(film_id) >= 20;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
select language_id, name, count(film_id)
from language
join film using (language_id)
group by language_id;

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
select language_id, name, avg(length)
from language
join film using (language_id)
group by language_id
having avg(length) > 110;

select name from language;

SELECT title, language_id, original_language_id
FROM film;

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
select film_id, title, count(rating)
from film
join inventory using(film_id)
group by film_id ;


-- 28/10/2026
-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
select film_id, title, count(rating)
from film
join inventory using(film_id)
group by film_id
having count(rating) >= 5;

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
select inventory_id, count(rental_id)
from inventory
join rental using(inventory_id)
group by inventory_id;

select inventory_id
from inventory
join rental using(inventory_id)
group by inventory_id;

-- solo salen solo hasta el 1001

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(rental_id) as total_alquileres
from customer
join rental using(customer_id)
group by customer_id  ;

-- 9:  Lista los clientes con 30 o más alquileres acumulados.
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(rental_id)
from customer
join rental using(customer_id)
group by customer_id
having  count(rental_id) >= 30 ;

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(amount) as total_pagos, sum(amount) as total_pagado
from customer
join payment using(customer_id)
group by customer_id ;

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(amount) as total_pagos, sum(amount) as total_pagado
from customer
join payment using(customer_id)
group by customer_id
having sum(amount) >= 200;

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
select staff_id, concat(first_name, ' ', last_name) as Nombre_staff, count(amount) as Pagos_procesados
from staff 
join payment using(staff_id)
group by staff_id ;

-- 13:  Para cada empleado, muestra el importe total procesado.
select staff_id, concat(first_name, ' ', last_name) as Nombre_staff, sum(amount)
from staff
join payment using(staff_id)
group by staff_id ;

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
select store_id, count(inventory_id) as asticulos_inventario
from store
join inventory using(store_id)
group by store_id ;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
select store_id, count(customer_id) as clientes_asignados
from store
join customer using(store_id)
group by store_id ;

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
select store_id, count(staff_id) as empleados_asignados
from store
join staff using(store_id)
group by store_id ;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
select address_id, address,  count(store_id)
from address
join store using(address_id)
group by address_id ;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
select address_id, address, count(staff_id) 
from address
join staff using(address_id)
group by address_id ;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
select address_id, address, count(customer_id) 
from address
join customer using(address_id)
group by address_id ;

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
select city_id, city, count(address_id) as direcciones_registradas
from city
join address using(city_id)
group by  city_id;
-- having count(address_id) > 1;

-- 21:  Para cada país, cuenta cuántas ciudades existen.
select country_id, country, count(city_id) as ciudades_pais
from country
join city using(country_id)
group by country_id ;

-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
select language_id, name, avg(length) as media_duracion
from language
join film using(language_id)
group by language_id
having avg(length) >= 90 && avg(length) <= 120;

select name from language; -- estan creados todes estos idiomas pero solo se ha utilizado el ingles

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
select film_id, title, count(rental_id)
from film
join inventory using(film_id)
join rental using(inventory_id)
group by film_id;

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(payment_id) as pagos
from customer
join payment using(customer_id)
where payment_date like '%2005%'
group by customer_id ;

select customer_id, concat(first_name, ' ', last_name) as Nombre, count(payment_id) as pagos
from customer
join payment using(customer_id)
group by customer_id
having payment_date like'2005%' ;

select payment_id, payment_date from payment;


-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
select film_id, title, avg(rental_rate)
from film 
join inventory using (film_id)
join rental using (inventory_id)
group by film_id  ;

-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
select actor_id, concat(first_name, ' ', last_name) as Nombre, avg(length) as duracion_media
from actor
join film_actor using(actor_id)
join film using (film_id)
group by actor_id  ;

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
select city_id, city, count(customer_id)
from city
join address using(city_id)
join customer using(address_id)
group by city_id 
order by city_id asc ;

-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
select film_id, title, count(actor_id)
from film
join film_actor using(film_id)
group by film_id ;

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
select category_id, name, count(film_id) as peliculas
from category
join film_category using(category_id)
group by category_id  ;

-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
select store_id, count(rental_id) as alquileres_totales
from store
join inventory using(store_id)
join rental using (inventory_id)
group by store_id ;

-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
select actor_id, concat(first_name, ' ', last_name) as Nombre, count(film_id) as peliculas
from actor
join film_actor using(actor_id)
join film using(film_id)
group by actor_id 
having  count(film_id) > 15;

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
select category_id, name, count(film_id)
from category
join film_category using(category_id)
group by category_id ;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
select film_id, title, count(rental_id)
from film
join inventory using(film_id)
join rental using(inventory_id)
group by film_id ;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
select customer_id, concat(first_name, ' ', last_name) as Nombre, sum(amount) as pago
from customer
join payment using(customer_id)
where payment_date like '%2005%'
group by  customer_id 
having sum(amount) >= 150;

select * from payment;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
select store_id, sum(amount) as importe_cobrado
from store
join staff using(store_id)
join payment using(staff_id)
group by store_id ;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
select city_id, city, count(staff_id)
from city
join address using(city_id)
join staff using(address_id)
group by city_id ;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
select city_id, city, count(store_id)
from city
join address using(city_id)
join store using(address_id)
group by city_id ;

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
select actor_id, concat(first_name, ' ', last_name) as Nombre, avg(length) as duracion_media
from actor
join film_actor using(actor_id)
join film using(film_id)
where release_year like '%2006%'
group by actor_id ;

select * from film;

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
select category_id, name, avg(length)
from category
join film_category using(category_id)
join film using(film_id)
group by category_id
having avg(length) >120;

-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
select language_id, name as idioma, sum(rental_rate) as tasas_sumo
from language
join film using(language_id)
join inventory using(film_id)
group by language_id ;

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
select concat(first_name, ' ', last_name) as nombre, count(rental_id) as alquileres
from customer
join rental using (customer_id)
where dayofweek(rental_date) in (1, 7)
group by  customer_id;
-- como el domingo es = 1 en el where pongo 1 y el 7 que es el sabado.

-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
select actor_id, concat(first_name, ' ', last_name) as Nombre, count(distinct (title))as Titulos_distintos
from actor
join film_actor using(actor_id)
join film using(film_id)
group by actor_id ;

-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
select city_id, city, count(customer_id) as clientesResiden
from city
join address using(city_id)
join customer using(address_id)
group by city_id;


-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
select category_id, name, count(distinct (actor_id)) as actoresPeliculas
from category
join film_category using (category_id)
join film using(film_id)
join film_actor using(film_id)
group by category_id;


-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
select store_id, count(inventory_id) as copiasTotales
from store
join inventory using(store_id)
join film using(film_id)
where release_year = 2006
group by store_id ;


-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
select c.customer_id, concat(c.first_name, ' ', c.last_name) as Nombre, sum(p.amount) as TotalPagado
from customer c
join rental r using(customer_id)
join payment p using(rental_id)
where p.staff_id = 1
group by c.customer_id ;


-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
select film_id, title, count(last_name) as actores
from film
join film_actor using (film_id)
join actor using(actor_id)
where char_length(last_name) >= 5
group by film_id ;

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
select category_id, name, sum(length) as duracionpeliculas
from category
join film_category using(category_id)
join film using(film_id)
group by category_id ;


-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
select city_id, city, sum(amount) as pagos
from city 
join address using(city_id)
join customer using(address_id)
join rental using(customer_id)
join payment using(rental_id)
group by city_id ;

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
select language_id, name, count(distinct(actor_id)) as actores
from language
join film using(language_id)
join film_actor using(film_id)
group by language_id ;

-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
select store_id, count(customer_id)
from store 
join customer using(store_id)
where active = 1
group by store_id ;

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
select customer_id, concat(first_name, ' ', last_name) as nombre, count(distinct (category_id)) as alquileres2006
from customer 
join rental using(customer_id)
join inventory using(inventory_id)
join film_category using(film_id)
WHERE rental_date like '2006%'
group by customer_id ;

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
select staff_id, concat(s.first_name, ' ', s.last_name) as Nombre, count(distinct(customer_id))
from staff s
join payment p using(staff_id)
join customer c using(customer_id)
group by s.staff_id  ;

-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
select city_id, city, count(rental_id)
from city
join address using(city_id)
join customer using(address_id)
join rental using(customer_id)
where rental_date like '2006%'
group by city_id ;


-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
select category_id, name, avg(replacement_cost) as 	avg_replacement_cos
from category
join film_category using(category_id)
join film using(film_id)
group by category_id  ;

-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
select store_id, sum(amount)
from store
join staff using(store_id)
join payment using(staff_id)
where payment_date like '2006%'
group by store_id ;

-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
select actor_id, concat(first_name, ' ', last_name) as nombre, count(film_id) as peli_title_long_12
from actor 
join film_actor using(actor_id)
join film using(film_id)
where char_length(title) > 12 
group by actor_id;

-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
select city_id, city, sum(amount) as pagos2005
from city
join address using(city_id)
join customer using(address_id)
join payment using(customer_id)
where payment_date like '2005%'
group by city_id
having pagos2005 >= 300;

-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
select category_id, name, count(film_id) as pelis_pg_pg13
from category
join film_category using(category_id)
join film using(film_id)
where rating like '%PG%' or  '%PG-13%' 
group by category_id; 

-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
select customer_id, concat(c.first_name, ' ', c.last_name) as nombreCliente, sum(amount) as pagos_procesado_staff2
from customer c
join payment using(customer_id)
join staff using(staff_id)
where staff_id = 2
group by customer_id;



-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
select city_id, city, count(customer_id) as clientes
from city
join address using(city_id)
join customer using(address_id)
group by city_id
having clientes >= 10;

-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
select actor_id, concat(first_name, ' ', last_name) as NombreActor, count(rental_id)
from actor
join film_actor using(actor_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
group by actor_id;


-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
select category_id, name, sum(amount)
from category 
join film_category using(category_id)
join inventory using (film_id)
join rental using(inventory_id)
join payment using(rental_id)
group by category_id;


-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
select city_id, city, sum(amount)
from city 
join address using(city_id)
join customer using(address_id)
join payment using(customer_id)
where payment_date like '2005%'
group by city_id;


-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
select store_id, count(distinct(actor_id))
from store 
join inventory using(store_id)
join film using( film_id)
join film_actor using (film_id)
group by store_id ;

-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
select language_id, name, count(rental_id)
from language 
join film using(language_id)
join inventory using(film_id)
join rental using(inventory_id)
group by language_id; 

-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
select customer_id, concat(first_name, ' ', last_name) as Nombre, count(distinct month (payment_date))
from customer
join payment using(customer_id)
where payment_date like '2005%'
group by customer_id; 

-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
select category_id, name, avg(length) as duracion_media_pelis_alquiladas
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
group by category_id;

-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
select country_id, country, count(customer_id)
from country 
join city using(country_id)
join address using(city_id)
join customer using(address_id)
group by country_id;

-- 70:  Para cada país, suma los importes pagados por sus clientes.
select country_id, country, sum(amount)
from country
join city using(country_id)
join address using(city_id)
join customer using(address_id)
join payment using(customer_id)
group by country_id;


-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
select store_id, count(distinct (category_id))
from store 
join inventory using(store_id)
join film using(film_id)
join film_category using(film_id)
group by store_id;



-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
select store_id, category_id, name, sum(amount)
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join store using(store_id)
join customer using(store_id)
join payment using(customer_id)
group by store_id, category_id;
-- hasta aqui me tarda unos 27 segundos en ejecutarse pero me funciona bien,
-- al añadir el sum(amount) en el select me sale el error 2013 de lost conecction to MySQL server during query y ya no funciona 
-- ese error me daba por que hay un limite de 30 segundos si tarda mas no se ejecuta, lo he apliado el limite y funciona 
-- pero ha tardado 289 segundos y me da el resultado muy elevado ya que con el join customer using(store_id) relaciono inventario con clientes
-- mediante store_id y el amount suma muchos pagos repetidos.

-- la ia me da esta solucion con otros caminos de joins y tardando menos de 1 segundo en ejecutarse dando la solucion buena
-- mas o menos lo entiendo pero me parece muy dificil ya que con mas de 6 tablas hay que entender muchas relaciones, 
-- saber cual es la indicada para el ejercicio pero bueno ya sera mas facil practicando mas.
SELECT
    staff.store_id,
    category_id,
    name AS category_name,
    SUM(amount) AS revenue
FROM category
JOIN film_category USING(category_id)
JOIN film USING(film_id)
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
JOIN payment USING(rental_id)
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.store_id, category_id;


-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
select actor_id, concat(first_name, ' ', last_name) as nombre, count(distinct store_id) as tiendas_distintas_se_ha_alquilado
from actor
join film_actor using(actor_id)
join inventory using(film_id)
join rental using(inventory_id)
group by actor_id;

-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
select category_id, name, count(distinct customer_id) as clientes_distintos
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
group by category_id;

-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
select language_id, name, count(distinct actor_id) as actores_distintos
from language
join film using(language_id)
join film_actor using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
group by language_id;

-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
select country_id, country, count(store_id) as tiendas
from country
join city using(country_id)
join address using(city_id)
join store using(address_id)
group by country_id;

-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
select customer_id, concat(first_name, ' ', last_name) as nombre, count(rental_id) as alquileres_mismo_dia
from customer
join rental using(customer_id)
where date(rental_date) = date(return_date)
group by customer_id;

-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
select store_id, count(distinct customer_id) as clientesDistintos
from store
join customer using(store_id)
join payment using(customer_id)
where payment_date >= '2005-01-01'
and payment_date < '2006-01-01'
group by store_id;
-- esta era mi solucion pero no funciona por que estoy relacionando los pagos con la tienda a través del cliente (customer.store_id)
-- que no indica donde se ha procesado el pago 

-- Para obtener la tienda correcta, tengo que relacionar los pagos con los empleados (payment.staff_id)
-- y estos con su tienda (staff.store_id). Así cuento los clientes según la tienda que ha procesado sus pagos:
-- 78
select staff.store_id, count(distinct customer_id) as clientesdistintos
from payment
join staff using(staff_id)
where payment_date >= '2005-01-01'
and payment_date < '2006-01-01'
group by staff.store_id;

-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
select category_id, name, count(film_id) as peliculas
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
where char_length(title) > 15
group by category_id;

-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
select country_id, country, sum(amount) as total_pagos
from country
join city using(country_id)
join address using(city_id)
join store using(address_id)
join staff using(store_id)
join payment using(staff_id)
group by country_id;

-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
select customer_id, concat(first_name, ' ', last_name) as nombre, round(sum(amount) * 1.21, 2) as total_con_iva
from customer
join payment using(customer_id)
group by customer_id;

-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
select hour(rental_date) as hora, count(rental_id) as numero_alquileres
from rental
group by hour(rental_date)
order by hora;

-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
select store_id, avg(length) as duracion_media
from store
join inventory using(store_id)
join rental using(inventory_id)
join film using(film_id)
where rental_date >= '2005-01-01'
and rental_date < '2006-01-01'
group by store_id
having avg(length) >= 100;

-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
select category_id, name, avg(replacement_cost) as coste_medio
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
where dayofweek(rental_date) = 1
group by category_id;

-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
select staff_id, concat(first_name, ' ', last_name) as nombre, sum(amount) as total_pagos
from staff
join payment using(staff_id)
where time(payment_date) >= '00:00:00'
and time(payment_date) < '06:00:00'
group by staff_id;

-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
select actor_id,  concat(first_name, ' ', last_name) as nombre, count(film_id) as peliculas_titulo_LOVE
from actor
join film_actor using(actor_id)
join film using(film_id)
where title like '%LOVE%'
group by actor_id
order by actor_id asc;

-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
select language_id, name, sum(amount) as total_pagos
from language
join film using(language_id)
join inventory using(film_id)
join rental using(inventory_id)	
join payment using(rental_id)
group by language_id;


-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
select customer_id, concat(first_name, ' ', last_name) as nombre, count(distinct date(rental_date)) as dias_distintos_2005_realizo_alquiler
from customer
join rental using(customer_id)
where rental_date >= '2005-01-01'
and rental_date < '2006-01-01'
group by customer_id;


-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
select category_id, name, avg(char_length(title)) as longitud_media_titulos
from category
join film_category using(category_id)
join film using(film_id)
join inventory using(film_id)
join rental using(inventory_id)
group by category_id;

-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
select store_id, count(distinct customer_id) as clientes_distintos_alquilan_primerTrimestre_2006
from store
join inventory using(store_id)
join rental using(inventory_id)
where rental_date >= '2006-01-01'
and rental_date < '2006-04-01'
group by store_id;

-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media