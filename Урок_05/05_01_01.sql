
-- Делаем текущей базу данных shop
USE shop;

-- Заполняем значения в колонках created_at и updated_at текущими датой и временем
UPDATE users SET
	created_at = NOW(),
	updated_at = NOW();
