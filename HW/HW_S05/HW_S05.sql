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