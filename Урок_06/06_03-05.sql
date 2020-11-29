
-- Делаем текущей базу данных vk
USE vk;


-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
	(SELECT name FROM genders WHERE id = (SELECT gender_id FROM profiles WHERE user_id = likes.user_id)) as gender,
	SUM(1) as likes_count 
FROM
	likes
GROUP BY
	gender
ORDER BY 
	likes_count DESC
LIMIT 1;


-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.
SELECT
	SUM(likes_data.likes_count) as young10_likes_count 
FROM
	(SELECT 
		user_id,
		(SELECT birthday FROM profiles WHERE user_id = likes.user_id) as user_birthday, 
		SUM(1) as likes_count 
	FROM
		likes
	GROUP BY
		user_id
	ORDER BY 
		user_birthday DESC LIMIT 10) as likes_data;
	

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).
	
-- Критерий активности - общее количество медиа, сообщений, постов и лайков созданных за последние 30 дней

SELECT
	user_id,
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id)  as fullname,
	SUM(inc) as count_content_added
FROM
	(SELECT	id as content_id, id as user_id, NOW() as created_at, 0 as inc FROM users
	UNION 
	SELECT id, user_id,	created_at, 1 FROM media
	UNION
	SELECT id, from_user_id, created_at, 1 FROM messages
	UNION
	SELECT id, user_id, created_at, 1 FROM posts	
	UNION 
	SELECT id, user_id,	created_at, 1 FROM likes) as content_added
WHERE
	TIMESTAMPDIFF(DAY, created_at, NOW()) < 30	
GROUP BY
	user_id
ORDER BY 
	count_content_added,
	fullname
LIMIT 10;
