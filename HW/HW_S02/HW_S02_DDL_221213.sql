USE vk;

-- Начало **************************************************************************************
DROP TABLE IF EXISTS comments_photo;
CREATE TABLE comments_photo(
	photo_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Пользователь, оставивший комментарий',
	body VARCHAR(1000),
	created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'Комментарии к фотографиям';

-- INSERT INTO comments_photo VALUES 
-- ('1','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),



-- Конец **************************************************************************************
