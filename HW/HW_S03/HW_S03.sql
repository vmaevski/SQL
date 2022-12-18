USE vk;

/* Написать скрипт, возвращающий список имен (только firstname) пользователей 
без повторений в алфавитном порядке. [ORDER BY]*/
SELECT DISTINCT firstname 
FROM users
ORDER BY firstname;

/* Выведите количество мужчин старше 35 лет [COUNT].*/
SELECT COUNT(*) AS `35_older`
FROM `profiles` 
WHERE (birthday + INTERVAL 35 YEAR) <= NOW() AND gender = 'm';


/* Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]*/
SELECT 
	COUNT(*) AS count_status, 
    `status`
FROM friend_requests
GROUP BY `status` 
ORDER BY count_status DESC;

/* Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].*/
SELECT 
	COUNT(*) AS requests,
    initiator_user_id
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY requests DESC
LIMIT 1;

/*  Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].*/

SELECT *
FROM communities
WHERE `name` LIKE '_____';