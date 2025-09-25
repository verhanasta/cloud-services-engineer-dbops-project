-- Изменение таблицы товаров
ALTER TABLE product
    ADD COLUMN price DOUBLE PRECISION;

-- Передача цен из таблицы product_info
UPDATE product p
SET    price = pi.price
FROM   product_info pi
WHERE  p.id = pi.product_id;

-- Изменение таблицы orders
ALTER TABLE orders
    ADD COLUMN date_created DATE;

-- Передача дат из таблицы orders_date
UPDATE orders o
SET    date_created = od.date_created,
       status = COALESCE(o.status, od.status) -- Если status был NULL, берем из orders_date
FROM   orders_date od
WHERE  o.id = od.order_id;

-- Установка первичных ключей
ALTER TABLE product
    ADD PRIMARY KEY (id);

ALTER TABLE orders
    ADD PRIMARY KEY (id);

-- Установка внешних ключей для обеспечения целостности информации
ALTER TABLE order_product
    ADD CONSTRAINT fk_order_product_product
        FOREIGN KEY (product_id) REFERENCES product(id),
    ADD CONSTRAINT fk_order_product_order
        FOREIGN KEY (order_id) REFERENCES orders(id);

-- Удаление лишних таблиц
DROP TABLE product_info;
DROP TABLE orders_date;