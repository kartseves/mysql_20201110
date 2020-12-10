
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.

DELIMITER //

USE shop//

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
	SET @now_hour = HOUR(NOW());
	IF @now_hour > 17 THEN RETURN 'Добрый вечер';
	ELSEIF @now_hour > 11 THEN RETURN 'Добрый день';
	ELSEIF @now_hour > 5 THEN RETURN 'Доброе утро';
	ELSE RETURN 'Доброй ночи';
	END IF;
END//

SELECT hello() AS hello//
