
-- Делаем текущей базу данных vk
USE vk;

-- Заполняем новые таблицы

-- Добавляем записи видов КИ
INSERT INTO contact_info_types (name) VALUES
	('E-mail'),
	('Mobile telefon'),
	('Skype');

-- Добавляем записи КИ, которые сгенерировались в данных колонок таблицы profiles
INSERT INTO contact_info (user_id, contact_info_type_id, metadata)
	SELECT
		contact_info_data.user_id,
		contact_info_data.contact_info_type_id,
		contact_info_data.metadata
	FROM
		(SELECT
			users.id as user_id,
			contact_info_types.id as contact_info_type_id,
			CONCAT('{"value":"', users.email, '"}') as metadata
		FROM
			users
			INNER JOIN contact_info_types
			ON contact_info_types.name = 'E-mail'
		
		UNION ALL
		
		SELECT
			users.id,
			contact_info_types.id,
			CONCAT('{"value":"', users.phone, '"}')
		FROM
			users
			LEFT JOIN contact_info_types
			ON contact_info_types.name = 'Mobile telefon') as contact_info_data;

-- Запросы для отладки
-- SELECT * FROM contact_info;
-- TRUNCATE contact_info;
		
-- Добавляем записи полов
INSERT INTO genders (name) VALUES
  ('Male'),
  ('Female');

-- Запросы для отладки
-- SELECT * FROM genders;

-- Добавляем записи стран, которые сгенерировались в данных колонки country таблицы profiles
INSERT INTO countries (name) SELECT DISTINCT country FROM profiles ORDER BY country;

-- Запросы для отладки
-- SELECT * FROM countries ORDER BY name;

-- Добавляем записи городов, которые сгенерировались в данных колонки city таблицы profiles
-- Для записей устанавливаем country_id, соответствующий стране, которая указана в колонке country таблицы profiles
INSERT INTO cities (name, country_id) SELECT DISTINCT profiles.city, countries.id FROM profiles LEFT JOIN countries ON country = name ORDER BY city;

-- Запросы для отладки
-- SELECT * FROM cities ORDER BY name;
