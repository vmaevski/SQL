#SELECT * FROM hw_s01.goods;
USE hw_s01;
/*- Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, 
количество которых превышает 2*/
SELECT product_name, manufactured, price
FROM goods
WHERE product_count > 2;
/*Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”*/
SELECT * 
FROM goods
WHERE manufactured = 'Samsung';
/*4.* С помощью SELECT-запроса с оператором LIKE найти:
4.1.* Товары, в которых есть упоминание "Iphone"*/
SELECT *
FROM goods
WHERE product_name LIKE 'iPhione';
/*4.2.* Товары, в которых есть упоминание "Samsung"*/
SELECT *
FROM goods
WHERE product_name LIKE '%Samsung%' 
	OR manufactured LIKE '%Samsung%';
/*4.3.* Товары, в названии которых есть ЦИФРЫ*/    
SELECT *
FROM goods
WHERE product_name LIKE '%[0-9]%'; # не работает
/*4.4.* Товары, в названии которых есть ЦИФРА "8"*/
SELECT *
FROM goods
WHERE product_name LIKE '%8%';