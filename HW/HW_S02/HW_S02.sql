USE vk;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country_name VARCHAR(100) UNIQUE,
    INDEX idx_country_name(country_name) 
);

DROP TABLE IF EXISTS towns;
CREATE TABLE towns(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	town_name VARCHAR(100),
    country_id BIGINT UNSIGNED NOT NULL 
    , FOREIGN KEY (country_id) REFERENCES countries(id)
) COMMENT 'Населённые пункты';

INSERT INTO countries (country_name) VALUES 
('Азербайджанская Республика'), ('Республика Армения'), ('Республика Беларусь'), ('Республика Казахстан'), ('Кыргызская Республика'), ('Республика Молдова'), ('Российская Федерация'), ('Республика Таджикистан'), ('Туркменистан'), ('Республика Узбекистан'), ('Украина');

INSERT INTO towns (town_name, country_id) VALUES 
('Москва', '7'), ('Санкт-Петербург', '7'), ('Новосибирск', '7'), ('Екатеринбург', '7'), ('Казань', '7'), ('Нижний Новгород', '7'), ('Челябинск', '7'), ('Омск', '7'), ('Самара', '7'), ('Красноярск', '7');

-- SELECT id, country_name FROM countries;
-- SELECT id, town_name, country_id FROM towns;
