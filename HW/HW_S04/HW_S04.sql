USE vk;
/* Пусть задан некоторый пользователь (id = 1). 
Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем
(написал ему сообщений). */
-- через вложенные запросы
SELECT 
	COUNT(*) AS out_mesages,
	from_user_id,
    (SELECT firstname FROM users WHERE id = from_user_id) AS first_name,
    (SELECT lastname FROM users WHERE id = from_user_id) AS last_name
FROM messages
WHERE to_user_id = 1 
GROUP BY from_user_id
ORDER BY out_mesages DESC
LIMIT 1;

-- через JOIN 

SELECT 
	COUNT(*) AS count_messages,
    -- from_user_id,
    u.firstname AS first_name,
    u.lastname AS last_name
    
FROM messages AS m
JOIN users AS u ON u.id = m.from_user_id
WHERE to_user_id = 1
GROUP BY u.id
ORDER BY count_messages DESC
LIMIT 1;


/* Подсчитать количество групп, в которые вступил каждый пользователь. */

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


/* Подсчитать количество пользователей в каждом сообществе. */

SELECT 
	COUNT(*) AS user_count,
	c.name AS comm_name
FROM communities AS c   
JOIN users_communities AS uc ON (
	c.id = uc.community_id
)    
GROUP BY c.id 
ORDER BY c.name;
    
