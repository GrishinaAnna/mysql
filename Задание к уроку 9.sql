/*Практическое задание по теме “Хранимые процедуры и функции, триггеры"*/


-- 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

-- DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE t TIMESTAMP; 
    SELECT DATE_FORMAT(NOW(), '%H:%i') INTO t;
    CASE 
        WHEN t BETWEEN '06:00' AND '12:00' THEN RETURN 'Доброе утро'; 
        WHEN t BETWEEN '12:00' AND '18:00' THEN RETURN 'Добрый день'; 
		WHEN t BETWEEN '18:00' AND '23:59' THEN RETURN 'Добрый вечер'; 
        ELSE RETURN 'Доброй ночи';  
    END CASE;
END//

SELECT hello()

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop

CREATE TRIGGER check_not_null BEFORE INSERT ON products
FOR EACH ROW 
BEGIN
   IF (NEW.name IS NULL AND NEW.desription IS NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Canceled. NOT NULL';
   END IF;
END//

CREATE TRIGGER check_not_null BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN
   IF (NEW.name IS NULL AND NEW.desription IS NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Canceled. NOT NULL';
   END IF;
END//

INSERT INTO products
  (name, desription, price, catalog_id)
VALUES
  (NULL, NULL, 7890.00, 1);
 
 

/* Практическое задание по теме “Транзакции, переменные, представления” */
 
 -- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
 -- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
USE sample;

START TRANSACTION;
	INSERT INTO sample.users
	SELECT * FROM shop.users WHERE id = 1;
COMMIT;

SELECT * FROM sample.users;

 -- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products
 -- и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE VIEW names AS
SELECT p.name AS product_name, c.name AS catalog_name 
FROM products AS p
LEFT JOIN catalogs AS c
ON c.id = catalog_id;

SELECT * FROM names;


-- 3) по желанию)
--  Пусть имеется таблица с календарным полем created_at.
--  В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
--  Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
--  если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP TABLE IF EXISTS dates;
CREATE TABLE dates (
	id SERIAL PRIMARY KEY,	
	created_at DATE 
);

INSERT INTO dates VALUES
('1', '2018-08-01'), ('2', '2018-08-04'), ('3', '2018-08-16') , ('4', '2018-08-17'),
('5', '2018-08-07'), ('6', '2018-08-10'), ('7', '2018-08-26') , ('8', '2018-08-27');


CREATE TABLE August
(
  dates_august date
);

-- заполняем таблицу датами 
DELIMITER //
DROP PROCEDURE IF EXISTS filldates//
CREATE PROCEDURE filldates(dateStart DATE, dateEnd DATE)
BEGIN
      WHILE dateStart <= dateEnd DO
        INSERT INTO August (dates_august) VALUES (dateStart);
        SET dateStart = date_add(dateStart, INTERVAL 1 DAY);
      END WHILE;
END//

   
CALL filldates('2018-08-01','2018-08-31')

DELIMITER ;

-- остальная часть задания не получилась

-- 4) (по желанию)
-- Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.


CREATE TABLE tab (created_at date);
INSERT INTO tab VALUES
('2018-08-01'), ('2018-08-04'), ('2018-08-16') , ('2018-08-17'),
('2018-08-07'), ('2018-08-10'), ('2018-08-26') , ('2018-08-27');

DELETE FROM tab
WHERE created_at NOT IN (
	SELECT * 
	FROM ( 
		SELECT * FROM tab
		ORDER BY created_at DESC LIMIT 5) AS TBL
) ORDER BY created_at DESC;

SELECT * FROM tab










