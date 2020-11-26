
-- Делаем текущей базу данных shop
USE shop;

-- Считаем количество дней рождений по дням недели текущего года
SELECT 
	DATE_FORMAT(DATE_ADD(birthday_at, INTERVAL TIMESTAMPDIFF(YEAR, birthday_at, NOW()) YEAR), '%W') as week_day,
	COUNT(birthday_at) as birthday_count 
FROM
	users
GROUP BY
	DATE_FORMAT(DATE_ADD(birthday_at, INTERVAL TIMESTAMPDIFF(YEAR, birthday_at, NOW()) YEAR), '%W')
;
