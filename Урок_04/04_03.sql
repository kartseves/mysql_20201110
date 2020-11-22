
-- Делаем текущей базу данных vk
USE vk;

-- Дорабатываем тестовые данные
-- Смотрим все таблицы
SHOW TABLES;


-- Анализируем типы медиаконтента (media_types)
SELECT * FROM media_types;
-- Очистим и заполним заново нужными типами 
TRUNCATE media_types;
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;


-- Анализируем медиаконтент пользователей (media)
SELECT * FROM media;
-- Обновляем данные для ссылки на тип
UPDATE media SET media_type_id = 1 + FLOOR(RAND() * 3);
-- Создаём временную таблицу расширений для медиафайлов
CREATE TEMPORARY TABLE IF NOT EXISTS extensions (name VARCHAR(10), media_type_id INT UNSIGNED);
TRUNCATE extensions;
-- Заполняем временную таблицу значениями
INSERT INTO extensions (name, media_type_id) VALUES ('jpeg', 1), ('avi', 2), ('mp3', 3), ('png', 1);
-- Проверяем
SELECT * FROM extensions;
-- Обновляем ссылку на файл
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  (SELECT name FROM extensions WHERE extensions.media_type_id = media.media_type_id ORDER BY RAND() LIMIT 1)
);
-- Обновляем размер файлов
UPDATE media SET size = 100000 + FLOOR((RAND() * 1000000)) WHERE size < 100000;
-- Заполняем метаданные файлов
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  


-- Анализируем данные пользователей (users)
SELECT * FROM users LIMIT 10;
-- Приводим в порядок временные метки
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;                  


-- Анализируем данные профилей пользователей profiles)
SELECT * FROM profiles LIMIT 20;
-- Заполняем gender_id
UPDATE profiles SET gender_id = 1 + FLOOR(RAND() * 2);
-- Заполняем country_id и city_id значениями, соответствующими city и country
UPDATE profiles SET 
	country_id = ( SELECT id FROM countries WHERE countries.name = country),
	city_id = ( SELECT id FROM cities WHERE cities.name = city); 
SELECT * FROM profiles;
-- Удаляем колонки gender, country, city
ALTER TABLE profiles DROP COLUMN gender;
ALTER TABLE profiles DROP COLUMN country;
ALTER TABLE profiles DROP COLUMN city;
-- Добавляем ссылки на фото
UPDATE profiles SET photo_id = (SELECT media.id FROM media WHERE media.user_id = profiles.user_id AND media.media_type_id = 1 LIMIT 1);


-- Анализируем данные сообщений пользователей (messages)
SELECT * FROM messages LIMIT 10;
-- Обновляем значения ссылок на отправителя и получателя сообщения
UPDATE messages SET 
  from_user_id = 1 + FLOOR(RAND() * 100),
  to_user_id = 1 + FLOOR(RAND() * 100);
-- Обновляем значение флага is_read, если is_delivered = 0 тогда 0, иначе случайное 0 или 1
UPDATE messages SET is_read = CASE WHEN is_delivered = 0 THEN 0 ELSE FLOOR(RAND() * 2) END;


-- Анализируем данные статусов дружб (friendship_statuses)
SELECT * FROM friendship_statuses;
-- Очищаем таблицу
TRUNCATE friendship_statuses;
-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

 
-- Анализируем данные дружб (friendships)
SELECT * FROM friendships LIMIT 20;
-- Обновляем ссылки на друзей
UPDATE friendships SET 
  user_id = 1 + FLOOR(RAND() * 100),
  friend_id = 1 + FLOOR(RAND() * 100);
-- Исправляем случай когда user_id = friend_id
UPDATE friendships SET friend_id = CASE WHEN friend_id < 100 THEN friend_id + 1 ELSE friend_id - 1 END WHERE user_id = friend_id;
-- Обновляем ссылки на статус 
UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3); 
-- Обновляем метку created_at
UPDATE friendships SET created_at = requested_at; 
-- Обновляем метку confirmed_at если статус дружбы равен 'Confirmed' (status_id = 2)
UPDATE friendships SET confirmed_at = NOW() WHERE status_id = 2; 


-- Анализируем данные сообществ (communities)
SELECT * FROM communities;
-- Приводим в порядок временные метки
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;                  


-- Анализируем таблицу связи пользователей и групп (communities_users)
SELECT * FROM communities_users;
-- Обновляем значения community_id
UPDATE communities_users SET community_id = 1 + FLOOR(RAND() * 30);


-- Анализируем таблицу типов объектов лайка (likes_obj_types) 
SELECT * FROM likes_obj_types;


-- Анализируем таблицу лайков (likes) 
SELECT * FROM likes;
-- Обновляем значение ссылки на объект лайка
UPDATE likes SET like_obj_id = CASE 
		WHEN like_obj_type_id = 1
			THEN (SELECT users.id FROM users WHERE users.id <> likes.user_id ORDER BY RAND() LIMIT 1) 
		WHEN like_obj_type_id = 2
			THEN (SELECT messages.id FROM messages WHERE messages.from_user_id <> likes.user_id ORDER BY RAND() LIMIT 1) 
		WHEN like_obj_type_id = 3
			THEN (SELECT media.id FROM media WHERE media.user_id <> likes.user_id ORDER BY RAND() LIMIT 1) 
		ELSE 
			NULL
	END;
