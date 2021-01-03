
-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.

USE shop;

-- Создаем хранимую процедуру
DROP PROCEDURE IF EXISTS insert_into_users;
delimiter //
CREATE PROCEDURE insert_into_users(IN user_count INT)
BEGIN
	DECLARE idx INT DEFAULT 1;
	WHILE user_count > 0 DO
		INSERT INTO users (name, birthday_at) VALUES (CONCAT('user_', idx), NOW());
		SET idx = idx + 1;
		SET user_count = user_count - 1;
	END WHILE;
END //
delimiter ;

-- Проверка работы процедуры
CALL insert_into_users(1000000);
SELECT * FROM users;
