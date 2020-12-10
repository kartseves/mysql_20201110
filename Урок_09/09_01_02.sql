
-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE OR REPLACE VIEW prod_cat AS
	SELECT
		prod.name AS prod_name,
		cat.name AS cat_name
	FROM products AS prod
		LEFT JOIN catalogs AS cat
		ON prod.catalog_id = cat.id
	ORDER BY
		cat_name,
		prod_name;
		
SELECT * FROM prod_cat;
