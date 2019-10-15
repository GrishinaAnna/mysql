-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

DROP DATABASE IF EXISTS cities;
CREATE DATABASE cities;
USE cities;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights(        		-- создаем таблицу flights
	id SERIAL PRIMARY KEY,
	from_city VARCHAR(255) NOT NULL,
	to_city VARCHAR(255) NOT NULL,
	FOREIGN KEY (from_city) REFERENCES cities(label),
	FOREIGN KEY (to_city) REFERENCES cities(label)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities(				-- создаем таблицу cities
	label VARCHAR(255) PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

-- заполняем таблицы данными

INSERT INTO flights(from_city, to_city) VALUES 
	('Moscow', 'Omsk'),
	('Novgorod', 'Kazan'),
	('Irkutsk', 'Moscow'),
	('Omsk', 'Irkutsk'),
	('Moscow', 'Kazan');


INSERT INTO cities(label, name) VALUES
	('Moscow', 'Москва'),
	('Novgorod', 'Новгород'),
	('Irkutsk', 'Иркутск'),
	('Omsk', 'Омск'),
	('Kazan', 'Казань');


SELECT C.name AS from_city, C1.name AS to_city
FROM flights AS F
INNER JOIN cities AS C ON C.label = F.from_city
INNER JOIN cities AS C1 ON C1.label = F.to_city
ORDER BY F.id




