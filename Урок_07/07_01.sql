
-- Делаем текущей базу данных shop
USE shop;

-- Добавляем данные о заказах в таблицу orders
INSERT INTO orders (user_id) VALUES
  (3),
  (5);

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT DISTINCT
	users.name
FROM
	users
	JOIN orders
	ON users.id = orders.user_id;
