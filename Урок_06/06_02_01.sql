
-- Добавляем внешние ключи в БД vk

-- Делаем текущей базу данных vk
USE vk;

-- Для таблицы профилей
-- Смотрим структуру таблицы
DESC profiles;
-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то профиль удаляем 
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
-- Если удалили медиа фото, то ссылку на фото в профиле зачищаем 
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT profiles_country_id_fk
    FOREIGN KEY (country_id) REFERENCES countries(id)
-- Если ссылка на страну есть в профиле, то её удалять нельзя
      ON DELETE RESTRICT,
  ADD CONSTRAINT profiles_city_id_fk
    FOREIGN KEY (city_id) REFERENCES cities(id)
-- Если ссылка на город есть в профиле, то его удалять нельзя
      ON DELETE RESTRICT,
  ADD CONSTRAINT profiles_gender_id_fk
    FOREIGN KEY (gender_id) REFERENCES genders(id)
-- Если ссылка на пол есть в профиле, то его удалять нельзя
      ON DELETE RESTRICT;


-- Для таблицы контактной информации
-- Смотрим структуру таблицы
DESC contact_info;
-- Добавляем внешние ключи
ALTER TABLE contact_info
  ADD CONSTRAINT contact_info_contact_info_type_id_fk 
    FOREIGN KEY (contact_info_type_id) REFERENCES contact_info_types(id)
-- Если ссылка на вид КИ есть в КИ, то его удалять нельзя
      ON DELETE RESTRICT,
  ADD CONSTRAINT contact_info_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то его КИ удаляем 
      ON DELETE CASCADE;

     
-- Для таблицы сообществ пользователей
-- Смотрим структуру таблицы
DESC communities_users;
-- Добавляем внешние ключи
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
-- Если ссылка на сообщество есть в сообществах пользователей, то его удалять нельзя
      ON DELETE RESTRICT,
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то его участие в сообществах удаляем 
      ON DELETE CASCADE;
     

-- Для таблицы дружб
-- Смотрим структуру таблицы
DESC friendships;
-- Добавляем внешние ключи
ALTER TABLE friendships
  ADD CONSTRAINT friendships_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о его дружбах удаляем 
      ON DELETE CASCADE,
  ADD CONSTRAINT friendships_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о его дружбах удаляем 
      ON DELETE CASCADE,
  ADD CONSTRAINT friendships_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
-- Если ссылка на статус дружбы есть в дружбах пользователей, то его удалять нельзя
      ON DELETE RESTRICT;


-- Для таблицы медиафайлов
-- Смотрим структуру таблицы
DESC media;
-- Добавляем внешние ключи
ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о его медиа удаляем 
      ON DELETE CASCADE,
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
-- Если ссылка на тип медиа в медиа пользователей, то его удалять нельзя
      ON DELETE RESTRICT;


-- Для таблицы сообщений пользователей
-- Смотрим структуру таблицы
DESC messages;
-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
-- Если пользователь отправлял сообщения, то его удалять нельзя, нужно сначала удалить его сообщения
      ON DELETE RESTRICT,
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о сообщениях ему зачищаем 
      ON DELETE CASCADE;

      
-- Для таблицы лайков пользователей
-- Смотрим структуру таблицы
DESC likes;
-- Добавляем внешние ключи
-- Внешний ключ к объетам лайка не устанавливаем, контролируем целостность этих данных на уровне приложения 
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о его лайках зачищаем 
      ON DELETE CASCADE,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
-- Если ссылка на тип объета лайка в лайках пользователей, то его удалять нельзя
      ON DELETE RESTRICT;

     
-- Для таблицы постов пользователей
-- Смотрим структуру таблицы
DESC posts;
-- Добавляем внешние ключи
-- Внешний ключ к объетам лайка не устанавливаем, контролируем целостность этих данных на уровне приложения 
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
-- Если удалили пользователя, то данные о его постах зачищаем 
      ON DELETE CASCADE,
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
-- Если ссылка на сообщество в постах пользователей, то его удалять нельзя
      ON DELETE RESTRICT,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
-- Если ссылка на медиа в постах пользователей, то её зачищаем
      ON DELETE SET NULL;
