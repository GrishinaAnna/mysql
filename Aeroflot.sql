/* Эта база данных была создана на основе сайта авиакомпании «Аэрофлот»,
 которая вместе со своими дочерними авиакомпаниями «Россия», «Аврора» и «Победа» образует авиационный холдинг Группа «Аэрофлот»,
 который входит в ТОП-20 авиаперевозчиков мира по пассажиропотоку.
 По итогам 2018 года Группа занимает 40,7% российского рынка по пассажиропотоку.
 В течение года услугами авиакомпаний Группы воспользовались 55,7 млн пассажиров,
 в том числе 35,8 млн пассажиров перевезено рейсами авиакомпании «Аэрофлот». */


DROP DATABASE IF EXISTS aeroflot;
CREATE DATABASE aeroflot;
USE aeroflot;

	-- Список городов
DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
	label VARCHAR(3) NOT NULL COMMENT 'Код города', -- Есть ли смысл накладывать ограничение 'primary key' на 'label' вместо id?
	name VARCHAR(100) NOT NULL COMMENT 'Название города',
	country VARCHAR(100) NOT NULL COMMENT 'Страна',
	
	INDEX (label),
	INDEX (name)
);

INSERT INTO cities VALUES
	(NULL, 'AAQ', 'Anapa', 'Russia'),
	(NULL, 'ABZ', 'Aberdeen','Great Britain'),
	(NULL, 'BWI', 'Baltimore', 'USA'),
	(NULL, 'BCN', 'Barselona', 'Spain'),
	(NULL, 'MOW', 'Moscow', 'Russia'),
	(NULL, 'BER', 'Berlin', 'German'),
	(NULL, 'JMK', 'Mikonos', 'Greece'),
	(NULL, 'SCO', 'Aktau', 'Kazakhstan'),
	(NULL, 'ADL', 'Adelaida', 'Australia');

	-- Аэропорты
DROP TABLE IF EXISTS airports;
CREATE TABLE airports(
	id SERIAL PRIMARY KEY,
	label VARCHAR(3) NOT NULL COMMENT 'Код аэропорта',
	name VARCHAR(100) NOT NULL COMMENT 'Название аэропорта',
	city VARCHAR(100) NOT NULL COMMENT 'Город расположения',
	country VARCHAR(100) NOT NULL COMMENT 'Страна расположения',
	
	INDEX (label),
	INDEX (name)
);	



INSERT INTO airports VALUES
	(NULL, 'AAQ', 'Vityazevo','Anapa', 'Russia'),
	(NULL, 'ABZ', 'Dyce', 'Aberdeen','Great Britain'),
	(NULL, 'DCA', 'Ronald Reagan national airport', 'Washington', 'USA'),
	(NULL, 'BCN', 'El Prat De Llobregat', 'Barselona', 'Spain'),
	(NULL, 'SVO', 'Sheremetevo', 'Moscow', 'Russia'),
	(NULL, 'SXF', 'Schoenefeld', 'Berlin', 'German'),
	(NULL, 'JMK', 'Mikonos', 'Mikonos', 'Greece'),
	(NULL, 'SCO', 'Aktau', 'Aktau', 'Kazakhstan'),
	(NULL, 'HKG', 'Hong Kong', 'Hong Kong', 'China');
	
	
	-- Данные о самолетах
DROP TABLE IF EXISTS airplanes;
CREATE TABLE airplanes(
	id SERIAL PRIMARY KEY,
	name VARCHAR(250) NOT NULL COMMENT 'Название самолета',
	model VARCHAR(250) NOT NULL COMMENT 'Модель самолета',
	start_of_using DATE NOT NULL COMMENT 'Старт эксплуатации',
	number_of_seats INT UNSIGNED NOT NULL COMMENT 'Количество мест',
	
	INDEX (name)
);

INSERT INTO airplanes VALUES
	(NULL, 'Boeing', '777-300ER', '2005-07-16', 420),
	(NULL, 'Boeing', '737-800', '2017-05-06', 333),
	(NULL, 'Airbus', 'А330-200', '2015-09-23', 400),
	(NULL, 'Airbus', 'А321', '2017-05-06', 420),
	(NULL, 'Sukhoi', 'SuperJet 100', '2006-09-20', 180),
	(NULL, 'Airbus', 'А330-300', '2003-10-14', 337);
	

	-- Данные рейса
DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
	id SERIAL PRIMARY KEY,
	flight_number VARCHAR(10) COMMENT 'Номер рейса',
	airplane_id BIGINT UNSIGNED NOT NULL COMMENT 'Самолет',
	time_of_departure TIME COMMENT 'Время вылета',
	time_of_arrival TIME COMMENT 'Время прилета',
	flight_time TIME COMMENT 'Время в пути',
	price DECIMAL (11,2) COMMENT 'Цена',
	
	INDEX (flight_number),
	INDEX (price),
	FOREIGN KEY (airplane_id) REFERENCES airplanes(id)
);
	
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('1', '895914', '1', '23:36:07', '08:20:30', '04:10:22', '520744254.60');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('2', '9', '2', '01:25:55', '12:16:56', '22:52:00', '6435128.62');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('3', '2983', '3', '14:17:35', '10:02:25', '08:35:41', '254173613.00');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('4', '90637', '4', '23:07:42', '23:01:14', '07:04:17', '0.05');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('5', '18', '5', '00:13:24', '10:05:42', '14:28:04', '51.90');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('6', '815564045', '6', '17:46:01', '20:46:49', '23:05:43', '9109460.05');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('7', '6954', '1', '10:57:27', '19:17:50', '03:14:05', '244.00');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('8', '', '2', '11:29:35', '20:50:01', '10:50:52', '36186.71');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('9', '947', '3', '13:14:48', '10:27:46', '02:39:58', '38803468.31');
INSERT INTO `flights` (`id`, `flight_number`, `airplane_id`, `time_of_departure`, `time_of_arrival`, `flight_time`, `price`) VALUES ('10', '4552048', '4', '07:31:44', '03:23:25', '08:32:41', '118598.64');
	

	-- Данные для регистрации на сайте
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,	
	email VARCHAR(120) UNIQUE NOT NULL,
	phone BIGINT UNIQUE NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	INDEX (phone),
    INDEX (email)
 );
   
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'gleason.darby@example.org', '0', '2009-01-14 16:39:27');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'torp.valentine@example.org', '505', '1985-07-12 17:52:36');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'gretchen81@example.org', '1', '1984-10-24 04:41:54');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'bradtke.branson@example.net', '275', '2016-03-03 07:36:04');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'kovacek.daryl@example.com', '984737', '2019-08-19 18:39:12');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'keely91@example.com', '92', '1977-12-16 09:49:01');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'darrel.corkery@example.net', '888', '2005-09-11 09:04:44');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'tstrosin@example.org', '84', '1999-10-02 12:30:35');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'dschiller@example.org', '219', '2011-02-26 18:45:48');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'o\'kon.heidi@example.net', '7596219074', '1989-01-29 07:27:19');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'hickle.verla@example.net', '846', '1971-08-13 08:29:56');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'wisozk.kyla@example.org', '930', '1994-12-14 09:27:45');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`) VALUES (NULL, 'yost.clemens@example.net', '863', '1979-02-02 09:41:53');


	-- Аэрофлот Бонус
 DROP TABLE IF EXISTS bonus;
 CREATE TABLE bonus(
	id SERIAL PRIMARY KEY,
	bonus_number VARCHAR(20) UNIQUE NOT NULL,
	mili BIGINT,
	status ENUM ('Base', 'Silver', 'Gold', 'Platinum') COMMENT 'Статус участника',
 	user_id BIGINT UNSIGNED,
 	created_at DATETIME DEFAULT NOW(),
 	
	INDEX (bonus_number),
 	FOREIGN KEY (user_id) REFERENCES users(id)
 );

INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('1', '32607221', NULL, 'Platinum', '21', '2002-12-14 10:22:43');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('2', '613025392', NULL, 'Gold', '22', '1974-12-31 15:24:22');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('3', '1737', NULL, 'Base', '23', '1994-02-25 04:23:41');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('4', '9005535', NULL, 'Base', '26', '2014-11-11 11:39:43');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('5', '5011742', NULL, 'Gold', '25', '2003-12-30 11:08:10');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('6', '1', NULL, 'Gold', '32', '2010-02-03 21:35:18');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('7', '0', NULL, 'Base', '29', '1993-06-28 19:26:33');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('8', '7', NULL, 'Silver', '30', '1983-09-20 08:29:53');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('9', '74', NULL, 'Gold', '33', '1995-01-04 09:57:25');
INSERT INTO `bonus` (`id`, `bonus_number`, `mili`, `status`, `user_id`, `created_at`) VALUES ('10', '201606', NULL, 'Gold', '37', '2006-05-31 23:01:40');
    
	--  Данные о пассажире
DROP TABLE IF EXISTS passengers;
CREATE TABLE passengers(
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	gender CHAR(1),
	lastname VARCHAR(50) NOT NULL COMMENT 'Фамилия',
	name VARCHAR(50) NOT NULL,
    middlename VARCHAR(50) COMMENT 'Отчество',    
    nationality VARCHAR(50) NOT NULL COMMENT 'Национальность',
    number_of_document BIGINT UNIQUE NOT NULL COMMENT 'Номер паспорта',
    issuing_country VARCHAR(50) NOT NULL COMMENT 'Страна выдачи паспорта',
    end_date DATE NOT NULL COMMENT 'Дата окончания паспорта',
    birthday DATE NOT NULL,
    bonus_id BIGINT UNSIGNED NULL,
    
    FOREIGN KEY (bonus_id) REFERENCES bonus(id)
 );
    
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('1', 'm', 'Rosenbaum', 'quia', 'doloremque', '', '8320', '3', '1977-03-01', '2005-12-19', '1');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('2', 'f', 'Mann', 'nulla', 'mollitia', '', '54942', '84906730', '2014-12-01', '2000-06-23', '2');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('3', 'm', 'Hyatt', 'quis', 'est', '', '129', '6', '1998-11-15', '1991-07-25', '3');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('4', 'm', 'Brown', 'quia', 'sed', '', '959476', '9444', '1980-09-23', '2016-04-02', '4');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('5', 'm', 'Breitenberg', 'autem', 'quia', '', '7332115', '8829', '2014-03-31', '2008-08-22', '5');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('6', 'm', 'Beahan', 'illo', 'qui', '', '96534999', '605641', '1972-01-21', '1983-05-12', '6');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('7', 'm', 'Goldner', 'rerum', 'laudantium', '', '25', '', '1985-01-15', '2012-12-26', '7');
INSERT INTO `passengers` (`id`, `gender`, `lastname`, `name`, `middlename`, `nationality`, `number_of_document`, `issuing_country`, `end_date`, `birthday`, `bonus_id`) VALUES ('8', 'm', 'Veum', 'labore', 'voluptas', '', '272', '575022', '1970-11-15', '1995-11-09', '8');
    
	-- Состав заказа (билет)
DROP TABLE IF EXISTS booking;
CREATE TABLE booking(
	id SERIAL PRIMARY KEY,
	booking_code BIGINT UNSIGNED NOT NULL UNIQUE COMMENT 'Код бронирования',
	from_city_id BIGINT UNSIGNED NOT NULL COMMENT 'Город вылета',
    to_city_id BIGINT UNSIGNED NOT NULL COMMENT 'Город прибытия',
    departure DATE NOT NULL COMMENT 'Дата вылета',
    arrival DATE COMMENT 'Дата возврата',
    class ENUM ('Econom', 'Comfort', 'Business') COMMENT 'Тип класса',
    flight_id BIGINT UNSIGNED NOT NULL,
    airport_id BIGINT UNSIGNED NOT NULL,
    passenger_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX (booking_code),
    FOREIGN KEY (from_city_id) REFERENCES cities(id),
    FOREIGN KEY (to_city_id) REFERENCES cities(id),
    FOREIGN KEY (flight_id) REFERENCES flights(id),
    FOREIGN KEY (airport_id) REFERENCES airports(id),
    FOREIGN KEY (passenger_id) REFERENCES passengers(id)
);
   
INSERT INTO booking(id, booking_code, from_city_id, to_city_id, departure, class, flight_id, airport_id, passenger_id) VALUES
	(1, '123', 1, 5, '2019-12-12', 'Econom', 2, 2, 7),
	(2, '546456', 2, 5, '2019-12-01', 'Econom', 1, 1, 1),
	(3, '45', 3, 2, '2019-11-12', 'Business', 3, 3, 2),
	(4, '777', 8, 1, '2019-12-10', 'Econom', 5, 5, 8),
	(5, '5966', 9, 4, '2019-12-22',  'Econom', 4, 4, 3),
	(6, '42424', 1, 3, '2019-12-02',  'Econom', 2, 2, 5);


 	-- Онлайн-регистрация
 DROP TABLE IF EXISTS online_chek_in;
 CREATE TABLE online_chek_in(
 	id SERIAL PRIMARY KEY,
	booking_id BIGINT UNSIGNED NOT NULL,
 	passenger_id BIGINT UNSIGNED NOT NULL,
 	
 	FOREIGN KEY (booking_id) REFERENCES booking(id),
 	FOREIGN KEY (passenger_id) REFERENCES passengers(id)
 );
 
INSERT INTO online_chek_in VALUES
	(NULL, 1, 5),
	(NULL, 2, 4),
	(NULL, 3, 2),
	(NULL, 4, 1);
	
	-- Обратная связь
DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback(
 	id SERIAL PRIMARY KEY,
 	from_user_id BIGINT UNSIGNED NOT NULL COMMENT 'От кого обращение',
 	request TEXT COMMENT 'Текст обращения', 	
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (from_user_id) REFERENCES users(id)
);

INSERT INTO feedback (id, from_user_id, request) VALUES
	(NULL, 21, 'Добрый вечер!'),
	(NULL, 22, '&&&&&&&&&&&&'),
	(NULL, 23, '??????????????????'),
	(NULL, 30, 'qwerty');
