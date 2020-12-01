
-- Делаем текущей базу данных shop
USE shop;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT DISTINCT
	products.name AS product,
	catalogs.name AS catalog 
FROM
	products
	LEFT JOIN catalogs
	ON products.catalog_id = catalogs.id;
