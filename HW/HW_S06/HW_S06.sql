/* Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы

- Используя транзакцию, написать функцию, которая удаляет всю информацию об указанном пользователе из БД. 
Пользователь задается по id. 
Удалить нужно все
сообщения, 
лайки, 
медиа записи, 
профиль и 
запись из таблицы users. 
Функция должна возвращать номер пользователя.
*/

# Не смог реализовать с помощью транзакции (((

USE vk;

DROP FUNCTION IF EXISTS delete_user_func;

DELIMITER //
CREATE FUNCTION delete_user_func(input_user_id BIGINT)
-- CREATE FUNCTION delete_user_func(input_user_id BIGINT, OUT `_rollback` BOOL)
RETURNS BIGINT
DETERMINISTIC
-- DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
-- 	begin
--     	SET `_rollback` = 1;
-- 	GET stacked DIAGNOSTICS CONDITION 1
--         code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
--     	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
-- end;
BEGIN
	DELETE FROM friend_requests WHERE initiator_user_id = input_user_id OR target_user_id = input_user_id;
    DELETE FROM messages WHERE from_user_id = input_user_id OR to_user_id = input_user_id;
	DELETE FROM likes WHERE media_id IN (SELECT id FROM media WHERE user_id = input_user_id) OR user_id = input_user_id;
	-- DELETE FROM `profiles` WHERE user_id = input_user_id OR photo_id IN (select id from media where id IN (select photo_id from profiles where user_id = input_user_id)); -- OR user_id = NULL; -- photo_id IN (SELECT id FROM media) ;
    DELETE FROM `profiles` WHERE user_id = input_user_id OR photo_id = (select photo_id from profiles where user_id = input_user_id); -- OR user_id = NULL; -- photo_id IN (SELECT id FROM media) ;
	DELETE FROM users_communities WHERE user_id = input_user_id;
	DELETE FROM media WHERE user_id = input_user_id;
	DELETE FROM users WHERE id = input_user_id;
RETURN input_user_id;
END//
DELIMITER ;

-- START TRANSACTION;
-- 	SELECT delete_user_func(105, 0) AS del_user_id;
-- IF `_rollback` THEN
-- 	ROLLBACK;
-- ELSE
-- 	COMMIT;
-- END IF; 

SELECT delete_user_func(2);

select * from users order by id;
select * from `profiles`;
select user_id, photo_id from `profiles` order by photo_id;
select * from profiles where photo_id = (select id from media where id = (select photo_id from profiles where user_id = 1));
Select * FROM `profiles` WHERE user_id = 1 OR photo_id = (select photo_id from profiles where user_id = 1); -- OR user_id = NULL; -- photo_id IN (SELECT id FROM media) ;

/* - Предыдущую задачу решить с помощью процедуры. */

DROP PROCEDURE IF EXISTS delete_user;

DELIMITER $$

CREATE PROCEDURE delete_user (input_user_id BIGINT UNSIGNED, OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE code varchar(100);
   	DECLARE error_string varchar(100);
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	begin
    	SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
        code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('. Text: ', error_string, 'Error occured. Code: ', code);
    end;
    START TRANSACTION;
		
        
        DELETE FROM friend_requests WHERE initiator_user_id = input_user_id OR target_user_id = input_user_id;
        DELETE FROM messages WHERE from_user_id = input_user_id OR to_user_id = input_user_id;
		DELETE FROM likes WHERE media_id IN (SELECT id FROM media WHERE user_id = input_user_id) OR user_id = input_user_id;
		DELETE FROM `profiles` WHERE user_id = input_user_id OR photo_id IN (SELECT id FROM media);
        DELETE FROM users_communities WHERE user_id = input_user_id;
		DELETE FROM media WHERE user_id = input_user_id;
        DELETE FROM users WHERE id = input_user_id;
        
	IF `_rollback` THEN
		ROLLBACK;
	ELSE
		set tran_result := 'ok';
		COMMIT;
	END IF;    

END$$

DELIMITER ;
-- вызываем процедуру
call delete_user(1, @tran_result);

-- смотрим результат
select @tran_result;

select * from users order by id;

/* * Написать триггер, который проверяет новое появляющееся сообщество. 
Длина названия сообщества (поле name) должна быть не менее 5 символов. 
Если требование не выполнено, то выбрасывать исключение с пояснением. */

DROP TRIGGER IF EXISTS name_length_check;

DELIMITER //

CREATE TRIGGER name_length_check
BEFORE INSERT 
ON communities FOR EACH ROW
begin
    IF LENGTH(NEW.name) < 5 THEN
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Создание отменено. Длина имени сообщества должна быть не менее 5 символов.';
    END IF;
END//

DELIMITER ;

INSERT INTO communities (name)
		  VALUES ('_NEW');