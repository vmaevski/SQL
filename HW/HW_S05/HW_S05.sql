USE VK;

/* - Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]
- Выведите данные, используя написанное представление [SELECT]
- Удалите представление [DROP VIEW]
(Подсчитать количество групп, в которые вступил каждый пользователь.) */
CREATE OR REPLACE VIEW number_of_user_groups AS
	SELECT 
		COUNT(*) AS group_count,
		u.id AS user_ID,
		u.firstname AS firstname,
		u.lastname AS lastname
	FROM users AS u
	JOIN users_communities AS uc ON (
		u.id = uc.user_id
	)    
	GROUP BY u.id;
    
SELECT * FROM number_of_user_groups;

DROP VIEW number_of_user_groups;

/* 
* Сколько новостей (записей в таблице media) у каждого пользователя?
 Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя). 
Попробовать решить с помощью CTE или с помощью обычного JOIN. */

WITH cte_media AS (
	select 
		count(*) AS news_count,
		user_id
	from media
	group by user_id
)
SELECT news_count, user_id, u.email AS user_email
FROM cte_media 
JOIN users as u on u.id = cte_media.user_id

