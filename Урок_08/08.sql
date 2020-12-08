
-- Делаем текущей базу данных vk
USE vk;


-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT 
	genders.name AS gender,
	COUNT(*) AS likes_count 
FROM
	likes
	JOIN profiles
		JOIN genders
		ON profiles.gender_id = genders.id
	ON likes.user_id = profiles.user_id
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
		profiles.birthday AS user_birthday,
		COUNT(likes.id) AS likes_count 
	FROM 
		profiles
		LEFT JOIN likes
			JOIN target_types
			ON (likes.target_type_id = target_types.id) AND (target_types.name = 'users')
		ON profiles.user_id = likes.target_id
	GROUP BY
		profiles.user_id
	ORDER BY 
		user_birthday DESC
	LIMIT 10) AS likes_data;
	

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).
	
-- Критерий активности - общее количество медиа, сообщений, постов и лайков созданных за последние 30 дней

SELECT
	users.id,
	CONCAT(users.first_name, ' ', users.last_name) AS fullname,
	COUNT(content_added.content_id) count_content_added
FROM
	users
	LEFT JOIN (SELECT id AS content_id, user_id AS user_id, created_at AS created_at FROM media
		UNION ALL
		SELECT id, from_user_id, created_at FROM messages
		UNION ALL
		SELECT id, user_id, created_at FROM posts	
		UNION ALL
		SELECT id, user_id,	created_at FROM likes) AS content_added
	ON (users.id = content_added.user_id)
	AND TIMESTAMPDIFF(DAY, content_added.created_at, NOW()) < 30	
GROUP BY
	id
ORDER BY 
	count_content_added,
	fullname
LIMIT 10;
