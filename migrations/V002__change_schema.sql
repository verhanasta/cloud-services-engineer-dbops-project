-- Обработка таблицы product: Добавление колонки "price" с типом число с плавающей точкой и Назначение колонки "id" первичным ключом таблицы
ALTER TABLE product
    ADD price DOUBLE PRECISION,
    ADD PRIMARY KEY (id);

-- Цена из таблицы product_info
UPDATE product p
SET    price = pi.price
FROM   product_info pi
WHERE  p.id = pi.product_id;

-- Обработка таблицы orders. Добавление колонки "date_created" с типом дата и назначение колонки "id" первичным ключом таблицы
ALTER TABLE orders
    ADD date_created DATE,
    ADD PRIMARY KEY (id);

-- Даты из таблицы orders_date
UPDATE orders o
SET    date_created = od.date_created,
       status = COALESCE(o.status, od.status) -- Если status был NULL, берем из orders_date
FROM   orders_date od
WHERE  o.id = od.order_id;

-- Добавление внешних ключей для целостности информации
ALTER TABLE order_product
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES product (id),
    ADD CONSTRAINT fk_orders_id FOREIGN KEY (order_id) REFERENCES orders (id);

-- Удаление таблиц
DROP TABLE product_info;
DROP TABLE orders_date;