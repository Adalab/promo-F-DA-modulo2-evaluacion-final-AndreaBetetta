
-- Ejercicios 
USE `sakila`;
-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT `title`  
FROM `film`;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT `title`
FROM `film`
WHERE `rating` = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT `title`
FROM `film`
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT `title`
FROM `film`
WHERE `length` >=120;

-- 5. Recupera los nombres de todos los actores.
SELECT `first_name` AS `nombre`
FROM `actor`;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT `first_name` AS `nombre`, `last_name` AS `apellido`
FROM `actor`
WHERE `last_name` LIKE "%Gibson%";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT `first_name` AS `nombre`
FROM `actor`
WHERE `actor_id`>=10 AND `actor_id` <= 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT `title` -- ,`rating`
FROM `film`
WHERE `rating` != "PG-13" AND `rating` != "R";

-- 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT `rating` AS `calificación`, COUNT(*) AS ` recuento calificación`
FROM `film`
GROUP BY `rating`;

-- 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT `r`.`customer_id`, COUNT(*) AS `total por cliente`, `c`.`first_name` AS `nombre`, `c`.`last_name` AS `apellido`
FROM `rental` AS `r`
JOIN `customer` AS `c`
WHERE `r`.`customer_id` = `c`.`customer_id`
GROUP BY `r`.`customer_id`;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT `c`.`name` AS `Nombre_Categoría`, COUNT(`f`.`category_id`) AS `Recuento_Alquileres`
FROM rental AS `r`
JOIN `inventory` AS `i`
JOIN `film_category` AS `f`
JOIN `category` AS `c`
WHERE `i`.`inventory_id` = `r`. `inventory_id`
	AND `f`.`film_id` = `i`.`film_id`
    AND `c`.`category_id` = `f`.`category_id`
GROUP BY `f`.`category_id`;





