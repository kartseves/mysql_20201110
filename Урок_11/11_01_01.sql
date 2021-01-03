
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

USE shop;

-- Создаем таблицу
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(10) NOT NULL,
	record_id BIGINT UNSIGNED NOT NULL,
	record_name VARCHAR(255) NOT NULL
) ENGINE = ARCHIVE;


-- Создаем триггер для users
DROP TRIGGER IF EXISTS add_to_log_users_insert;
delimiter //
CREATE TRIGGER add_to_log_users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- Создаем триггер для catalogs
DROP TRIGGER IF EXISTS add_to_log_catalogs_insert;
delimiter //
CREATE TRIGGER add_to_log_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


-- Создаем триггер для products
DROP TRIGGER IF EXISTS add_to_log_products_insert;
delimiter //
CREATE TRIGGER add_to_log_products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


-- Проверка работы триггеров
SELECT * FROM users;
SELECT * FROM catalogs;

INSERT INTO users (name, birthday_at) VALUES ('Егор', '1983-01-01');
INSERT INTO catalogs (name) VALUES ('Корпуса');

SELECT * FROM catalogs;
SELECT * FROM products;

INSERT INTO products (name, description, price, catalog_id) VALUES ('Zalman i3 Black', 'Компьютерный корпус Zalman i3 Black', 4000.00, 6);

SELECT * FROM logs;
