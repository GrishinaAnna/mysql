/* Практическое задание по теме “Оптимизация запросов” */

-- 1) Создайте таблицу logs типа Archive.
-- Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
USE shop

-- Archive - не поддерживает индексы, поэтому при определении
-- таблицы первичный ключ не указывается.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  table_id INT,
  table_name VARCHAR(20),
  name VARCHAR(255),
  created_ad TIMESTAMP
  
) COMMENT = 'Логи' ENGINE=Archive;

DELIMITER //
CREATE PROCEDURE write_log(IN table_id INT, table_name VARCHAR(20), name VARCHAR(255))
BEGIN
    INSERT INTO logs(table_id, table_name, name, created_ad) VALUES (table_id, table_name, name, NOW());
END//

-- Триггер для users
DROP TRIGGER IF EXISTS users_log//
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN
    CALL write_log(NEW.id, "users", NEW.name);
END//

-- -- Триггер для catalogs
DROP TRIGGER IF EXISTS catalogs_log//
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    CALL write_log(NEW.id, "catalogs", NEW.name);
END//

-- -- Триггер для products
DROP TRIGGER IF EXISTS products_log//
CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW
BEGIN
    CALL write_log(NEW.id, "products", NEW.name);
END//

DELIMITER ;

-- Тестируем
INSERT INTO users (name) VALUES ('Анна');
INSERT INTO catalogs (name) VALUES ('Карты');
INSERT INTO products (name) VALUES ('New');

SELECT * FROM logs;

-- 2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER //
DROP PROCEDURE IF EXISTS million//
CREATE PROCEDURE million(IN m INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    
    WHILE i < m DO
	INSERT INTO users (name) VALUES (concat('user', i));
        SET i = i + 1;
    END WHILE;
    
END//
  
CALL million(1000000)//

/* Практическое задание по теме “NoSQL” */
-- Базы не устанавливала

-- 1) В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

HSET counters '192.168.0.1'

-- 2) При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
--  поиск электронного адреса пользователя по его имени.
HSET email 'Anna' 'anna@gmail.com'
HSET name 'anna@gmail.com' 'Anna'

HGET email 'Anna'
HGET name 'ann@gmail.com'


-- 3) Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

USE shop

db.shop.INSERT({catalog: 'Процессоры', products:[
				{id: 1, name: 'Intel Core i3-8100', description: '', price: 7890}]})
db.shop.UPDATE({catalog: 'Процессоры'}, {$push: 
 				{ products: {id: 2, name:'Intel Core i5-7400', description: '',price: 12700 } }})
db.shop.INSERT({catalog: 'Материнские платы', products:[
 				{id: 3, name: 'Intel Core i3-8100', description: '', price: 7890}]} )
db.shop.UPDATE({catalog: 'Материнские платы'}, {$set: 
				{ products:[{id: 3, name: 'Gigabyte H310M S2H', description: '', price: 4790}]}} )
db.shop.find()
