
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
WHERE `length` >120;

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
FROM `rental` AS `r`
JOIN `inventory` AS `i`
JOIN `film_category` AS `f`           -- podría hacerse como LEFT JOIN con AS....ON 
JOIN `category` AS `c`
WHERE `i`.`inventory_id` = `r`. `inventory_id`
	AND `f`.`film_id` = `i`.`film_id`
    AND `c`.`category_id` = `f`.`category_id`
GROUP BY `f`.`category_id`;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
 -- que me de promedio AVG con dos decimales ROUND
 
SELECT `rating` AS `calificacion`, ROUND(AVG(`length`),2) AS `promedio_duracion_calificacion`
FROM `film`
GROUP BY `rating`;

-- 13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

/*SELECT `f`.`title`,`a`.`first_name`,`a`.`last_name`
FROM `film` AS `f`
LEFT JOIN `film_actor` AS `f_a` ON `f_a`.`film_id` = `f`.`film_id`
LEFT JOIN `actor` AS `a` ON `f_a`.`actor_id` = `a`.`actor_id`
WHERE `f`.`title` LIKE "Indian Love";*/

SELECT `a`.`first_name`,`a`.`last_name`
FROM `film` AS `f`
LEFT JOIN `film_actor` AS `f_a` ON `f_a`.`film_id` = `f`.`film_id`
LEFT JOIN `actor` AS `a` ON `f_a`.`actor_id` = `a`.`actor_id`
WHERE `f`.`title` LIKE "Indian Love";

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT `title`
FROM `film`
WHERE `description` LIKE "%cat%" OR `description`LIKE "%dog%";

-- 15.Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT *
FROM `actor` AS `a`
LEFT JOIN `film_actor` AS `f_a` ON `a`.`actor_id` = `f_a`.`actor_id`
WHERE `f_a`.`film_id` IS NULL;

/*        PRUEBA 
SELECT * FROM sakila.actor;
INSERT INTO `actor`
VALUES (6758, "PEDRO", "SANCHEZ", NOW());

DELETE FROM `actor`
WHERE `actor_id` = 6758; */

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT `title`
FROM `film`
WHERE `release_year` >= 2005  AND `release_year`<= 2010;

/* todas las 1.000 primeras parecen del 2006 */

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT `f`.`title`, `c`.`name`
FROM `film` AS `f`
LEFT JOIN `film_category` AS `f_c` ON `f`. `film_id` = `f_c`.`film_id`
LEFT JOIN `category` AS `c` ON `c`.`category_id` = `f_c`.`category_id`
WHERE `c`.`name` = "Family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT `a`.`first_name`,`a`.`last_name`,COUNT(`a`.`actor_id`)
FROM `actor` AS `a`
LEFT JOIN `film_actor` AS `f_a` ON `f_a`.`actor_id` = `a`.`actor_id`
GROUP BY `a`.`actor_id`
HAVING COUNT(`a`.`actor_id`) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT `title`/*,`length`, `rating`*/
FROM `film`
WHERE `rating` = "R"
AND `length` > 120 ;

-- 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT `c`.`name`, ROUND(AVG(`length`),0) AS `promedio_duracion`
FROM `film` AS `f`
LEFT JOIN `film_category` AS `fc` ON `fc`.`film_id`= `f`.`film_id`
LEFT JOIN `category` AS `c` ON `c`.`category_id`= `fc`.`category_id`
GROUP BY `c`.`name`
HAVING AVG(`length`) > 120;

-- 21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
SELECT `a`.`first_name`,`a`.`last_name`,COUNT(`a`.`actor_id`) AS `n_peliculas`
FROM `actor` AS `a`
LEFT JOIN `film_actor` AS `f_a` ON `f_a`.`actor_id` = `a`.`actor_id`
GROUP BY `a`.`actor_id`
HAVING COUNT(`a`.`actor_id`) >= 5;

-- 22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
-- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.


-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

SELECT *
FROM `actor` AS `a`
WHERE `a`.`actor_id` NOT IN(
	SELECT DISTINCT `f_a`.`actor_id`
	FROM `film_category` AS `f_c`
    JOIN `film_actor` AS `f_a` ON `f_c`.`film_id` = `f_a`.`film_id`
    JOIN `category` AS `c` ON `f_c`.`category_id` = `c`.`category_id`
    WHERE `c`.`name` = "Horror");

-- 1. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

SELECT `c`.`name`, `f`.`title`, `f`.`length`
FROM `film` AS `f`
LEFT JOIN `film_category` AS `fc` ON `f`.`film_id` = `fc`.`film_id`
LEFT JOIN `category` AS `c` ON `c`.`category_id` = `fc`.`category_id`
WHERE `c`.`name` = "Comedy"
AND `f`.`length` > 180;


