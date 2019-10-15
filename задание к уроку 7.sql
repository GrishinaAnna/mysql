USE shop;

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT id, name FROM users
WHERE id IN (SELECT user_id FROM orders) ; -- выбираем пользоват., которые делали заказ

--------------------------------------------------------------------------------------

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
  products.name,
  catalogs.name
FROM
  products, catalogs  
WHERE
  products.catalog_id = catalogs.id;
-------------------------------------------------------------------------------------



