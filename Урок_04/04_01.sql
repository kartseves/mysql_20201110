
-- Делаем текущей базу данных vk
USE vk;

-- Создаем новые таблицы

-- Таблица видов контактной информации
CREATE TABLE contact_info_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название вида контактной информации",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник виды контактной информации";  

-- Таблица контактной информации пользователей
CREATE TABLE IF NOT EXISTS contact_info (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, к кому относится КИ",
  contact_info_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на вид КИ",
  metadata JSON COMMENT "Метаданные КИ"
) COMMENT "Контактная информация пользователей";  

-- Таблица полов
CREATE TABLE IF NOT EXISTS genders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название пола",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник полов";  

-- Таблица стран
CREATE TABLE IF NOT EXISTS countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название страны",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник стран";  

-- Таблица городов
CREATE TABLE IF NOT EXISTS cities  (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название города",
  country_id INT UNSIGNED NOT NULL COMMENT "Ссылка на страну города",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник городов";  

-- Модифицируем существующие таблицы

-- Для таблицы messages создаем колонку is_read.
ALTER TABLE messages ADD COLUMN is_read BOOLEAN COMMENT "Признак прочтения";

-- Для таблицы profiles добавляем колонки gender_id, country_id, city_id
ALTER TABLE profiles ADD COLUMN country_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пол";
ALTER TABLE profiles ADD COLUMN gender_id INT UNSIGNED NOT NULL COMMENT "Ссылка на страну";
ALTER TABLE profiles ADD COLUMN city_id INT UNSIGNED NOT NULL COMMENT "Ссылка на город";

-- Таблицу friendship переименуем в friendships
RENAME TABLE friendship TO friendships;
