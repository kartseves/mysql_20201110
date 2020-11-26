
-- Создаем таблицу чисел и наполняем её 
CREATE TEMPORARY TABLE IF NOT EXISTS my_numbers (
  value INT COMMENT "Число"
) COMMENT "Таблица чисел";  
TRUNCATE my_numbers; 
INSERT INTO my_numbers VALUES (1),(2),(3),(4),(5);

-- Вычисление произведения чисел в столбце value таблицы  
SELECT 
	EXP(SUM((LN(value))))
FROM 
	my_numbers;
