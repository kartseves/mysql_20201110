
-- Делаем текущей базу данных shop
USE shop;

-- Выборка данных с отбором по списку названий месяца рождения 
SELECT
	name,
	birthday_at
FROM 
	users
WHERE
	LOWER(DATE_FORMAT(birthday_at, '%M')) IN ('may', 'august');
