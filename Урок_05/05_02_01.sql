
-- Делаем текущей базу данных shop
USE shop;

-- Вычисление среднего возраста users 
SELECT
	AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) 
FROM
	users;
