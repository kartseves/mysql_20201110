
-- Делаем текущей базу данных shop
USE shop;

-- Очищаем и заполняем данные таблицы storehouses_products 
TRUNCATE storehouses_products; 
INSERT INTO storehouses_products VALUES
	(1,1,1,0,NOW(),NOW()),
	(2,1,2,2500,NOW(),NOW()),
	(3,1,3,0,NOW(),NOW()),
	(4,1,4,30,NOW(),NOW()),
	(5,1,5,500,NOW(),NOW()),
	(6,1,6,1,NOW(),NOW());

-- Выборка данных с сортировкой по заданному условию 
SELECT
	value
FROM 
	storehouses_products
ORDER BY
	IF (value > 0, 0, 1),
	value;
