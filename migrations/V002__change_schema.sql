-- Обработка таблицы product: Добавление колонки "price" с типом число с плавающей точкой и Назначение колонки "id" первичным ключом таблицы
ALTER TABLE product
    ADD price DOUBLE PRECISION,
    ADD PRIMARY KEY (id);
-- Обработка таблицы orders. Добавление колонки "date_created" с типом дата и назначение колонки "id" первичным ключом таблицы
ALTER TABLE orders
    ADD date_created DATE,
    ADD PRIMARY KEY (id);

-- Добавление внешних ключей для целостности информации
ALTER TABLE order_product
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES product (id),
    ADD CONSTRAINT fk_orders_id FOREIGN KEY (order_id) REFERENCES orders (id);
--
---- Удаление таблиц
--DROP TABLE product_info;
--DROP TABLE orders_date;