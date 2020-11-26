
-- Делаем текущей базу данных shop
USE shop;

-- Выборка данных с отбором и сортировкой по списку 
SELECT * 
FROM
	catalogs
WHERE 
	id IN (5, 1, 2)
ORDER BY
  FIELD(id, 5, 1, 2);
