-- Задание 1

-- Создайте таблицу city с колонками city_id и city_name.
CREATE TABLE city
(
    city_id   INT         NOT NULL PRIMARY KEY,
    city_name VARCHAR(32) NOT NULL
);
-- Добавьте в таблицу employee колонку city_id.
ALTER TABLE employee
    ADD COLUMN city_id INT;
-- Назначьте эту колонку внешним ключом. Свяжите таблицу employee с таблицей city.
ALTER TABLE employee
    ADD FOREIGN KEY (city_id) REFERENCES city (city_id);
-- Заполните таблицу city и назначьте работникам соответствующие города.
INSERT INTO city (city_id, city_name)
VALUES (1, 'Магадан'),
       (2, 'Хабаровск'),
       (3, 'Усть-Лабинск'),
       (4, 'Ростов-на-Дону'),
       (5, 'Питербург'),
       (6, 'Южный_Сахалин'),
       (7, 'Саров');
UPDATE employee
SET city_id = 6
WHERE id = 1;
UPDATE employee
SET city_id = 1
WHERE id = 2;
UPDATE employee
SET city_id = 4
WHERE id = 3;
UPDATE employee
SET city_id = 2
WHERE id = 4;
UPDATE employee
SET city_id = 5
WHERE id = 5;

-- Задание 2

-- Получите имена и фамилии сотрудников, а также города, в которых они проживают.
SELECT first_name AS Имя,
       last_name  AS Фамилия,
       city_name  AS Город_проживания
FROM city
         INNER JOIN employee ON city.city_id = employee.city_id
ORDER BY id;
-- Получите города, а также имена и фамилии сотрудников, которые в них проживают.
-- Если в городе никто из сотрудников не живет, то вместо имени должен стоять null.
SELECT city_name  AS Город_проживания,
       first_name AS Имя,
       last_name  AS Фамилия
FROM city
         LEFT JOIN employee e on city.city_id = e.city_id
ORDER BY e.id;
-- Получите имена всех сотрудников и названия всех городов.
-- Если в городе не живет никто из сотрудников, то вместо имени должен стоять null.
-- Аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null.
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Максим', 'Проняев', 'муж.', 45);

SELECT first_name AS Имя,
       city_name  AS Город_проживания
FROM city
         FULL OUTER JOIN employee e ON city.city_id = e.city_id
ORDER BY e.id;
-- Получите таблицу, в которой каждому имени должен соответствовать каждый город.
SELECT first_name AS Имя,
       city_name  AS Город_проживания
FROM city
         CROSS JOIN employee
ORDER BY first_name;
--Получите имена городов, в которых никто не живет.
SELECT city_name AS Город_проживания
FROM city
         LEFT JOIN employee e on city.city_id = e.city_id
WHERE first_name is null
ORDER BY city_name;