# DDL: CREATE, ALTER, DROP

DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    # id2 SERIAL, # UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(2560),
    phone BIGINT UNIQUE,
    INDEX idx_usrers_username(firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender VARCHAR(1),
	hometown VARCHAR(100),
	created_at DATETIME DEFAULT NOW()
);

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE profiles ADD COLUMN birthday DATETIME;
ALTER TABLE profiles MODIFY COLUMN birthday DATE;
ALTER TABLE profiles RENAME COLUMN birthday TO date_of_birth;
ALTER TABLE profiles DROP COLUMN date_of_birth;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
	created_at DATETIME DEFAULT NOW(),
    
	FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)   
);
