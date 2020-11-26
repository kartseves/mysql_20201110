
-- Делаем текущей базу данных shop
USE shop;

-- Добавляем колонки created_at_new, updated_at_new с типом DATETIME
ALTER TABLE users ADD COLUMN created_at_new DATETIME;
ALTER TABLE users ADD COLUMN updated_at_new DATETIME;

-- Заполняем значения в новых колонках created_at_new и updated_at_new, преобразуя существующие значения created_at, updated_at
UPDATE users SET
	created_at_new = FROM_UNIXTIME(UNIX_TIMESTAMP(CONCAT( 
		SUBSTRING(created_at, 7, 4),
		'-',
		SUBSTRING(created_at, 4, 2),
		'-',
		SUBSTRING(created_at, 1, 2),
		' ',
		SUBSTRING(created_at, 12),
		':00'))),
	updated_at_new = FROM_UNIXTIME(UNIX_TIMESTAMP(CONCAT( 
		SUBSTRING(updated_at, 7, 4),
		'-',
		SUBSTRING(updated_at, 4, 2),
		'-',
		SUBSTRING(updated_at, 1, 2),
		' ',
		SUBSTRING(updated_at, 12),
		':00')))

-- Удаляем колонки created_at, updated_at
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;
-- Меняем колонки created_at_new, updated_at_new
ALTER TABLE users CHANGE COLUMN created_at_new created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE COLUMN updated_at_new updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
