
-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- Создаем базу данных lesson07
CREATE DATABASE IF NOT EXISTS lesson07;

-- Делаем текущей базу данных lesson07
USE lesson07;

-- Создаем и наполняем таблицу рейсов flights
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  city_from VARCHAR(255) COMMENT 'Откуда',
  city_to VARCHAR(255) COMMENT 'Куда'
) COMMENT = 'Рейсы';

INSERT INTO flights
  (city_from, city_to)
VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

-- Создаем и наполняем таблицу рейсов cities
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'Метка',
  name VARCHAR(255) COMMENT 'Название'
) COMMENT = 'Города';

INSERT INTO cities
VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');

-- Получаем таблицу рейсов согласно условию
SELECT
	flights.id AS id,
	cities1.name AS city_from,
	cities2.name AS city_to
FROM 
	flights
	LEFT JOIN cities AS cities1
	ON flights.city_from = cities1.label
	LEFT JOIN cities AS cities2
	ON flights.city_to = cities2.label;
