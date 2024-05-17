-- ******************************************
------------- тестовые записи-------------- *
-- ******************************************
-- Заполним директорами таблицы сотрудников-
INSERT INTO "EMPLOYEES"("ID",
                        "FIRST_NAME",
                        "LAST_NAME",
                        "PHONE",
                        "E_MAIL",
                        "JOB_NAME",
                        "SHOP_ID")
VALUES (1, 'Менеджер', 'Первый', '8-913-626-13-83', 'T1@mail.ru', 'Manager', NULL),
       (2, 'Менеджер', 'Второй', '8-922-222-22-22', 'T2@mail.ru', 'Manager', NULL),
       (3, 'Менеджер', 'Третий', '8-965-543-55-44', 'T3@mail.ru', 'Manager', NULL);

-- Cоздадим магазины-

INSERT INTO "SHOPS"("ID",
                    "NAME",
                    "REGION",
                    "CITY",
                    "ADDRESS",
                    "MANAGER_ID")
VALUES(1, 'Shop1','Омская область', 'Омск', '50 лет Профсоюзов 132', 1),
      (2, 'Shop2','Омская область', 'Омск', '20 лет PККА 9', 2),
      (3, 'Shop3','Томская область', 'Томск', 'Тенистая 4', 3);

-- Добавим в null значения директоров "ID" магазинов

UPDATE "EMPLOYEES"
SET "SHOP_ID" =
  (SELECT "MANAGER_ID"
   FROM "SHOPS" S
   WHERE "EMPLOYEES"."ID" = S."MANAGER_ID");

-- Добавим остальных сотрудников

INSERT INTO "EMPLOYEES"("ID",
                        "FIRST_NAME",
                        "LAST_NAME",
                        "PHONE",
                        "E_MAIL",
                        "JOB_NAME",
                        "SHOP_ID")
VALUES (13, 'Непродающий', 'Петр1', '8-913-626-13-81', 'T13@mail.ru', 'Seller', 2),
       (14, 'Супер-Продающий1', 'Иван2', '8-922-222-22-21', 'T14@mail.ru', 'Seller', 1),
       (15, 'Супер-Продающий1', 'Иван', '8-965-543-55-41', 'T15@mail.ru', 'Seller', 1),
       (16, 'Непродающая', 'Вторая', '8-913-626-13-88', 'T4@mail.ru', 'Seller', 2),
       (17, 'Петрова', 'Ирина', '8-922-222-22-13', 'T5@mail.ru', 'Seller', 2),
       (18, 'Супер-Продающий2', 'Иван', '8-965-543-55-44', 'T6@mail.ru', 'Seller', 2),
       (19, 'Непродающий', 'Иван3', '8-913-656-13-83', 'T7@mail.ru', 'Seller', 3),
       (20, 'Ивановa', 'Иванa', '8-922-222-22-22', 'T8@mail.ru', 'Seller', 3),
       (21, 'Супер-Продающий3', 'Иван3', '8-965-555-55-44', 'T9@mail.ru', 'Seller', 3),
       (10, 'Петров', 'Петр', '8-913-626-13-55', 'T10@mail.ru', 'Accountant', NULL),
       (11, 'Петрова', 'Ирина', '8-922-555-22-13', 'T11@mail.ru', 'Loader', NULL),
       (12, 'Котовa', 'Иван', '8-965-543-55-54', 'T12@mail.ru', 'Cleaner', NULL);

-- Заполним таблицу products

INSERT INTO "PRODUCTS" ("ID",
                        "CODE",
                        "NAME")
VALUES (1, '1', 'хлеб'),
       (2, '2', 'булочка'),
       (3, '3', 'молоко'),
       (4, '4', 'кефир'),
       (5, '5', 'торт'),
       (6, '6', 'йогурт'),
       (7, '7', 'сыр'),
       (8, '8', 'творог'),
       (9, '9', 'яблоки'),
       (10, '10', 'купленый 10'),
       (11, '11', 'купленый 11'),
       (12, '12', 'купленый 12'),
       (13, '13', 'купленый 13'),
       (14, '14', 'купленый 14'),
       (15, '15', 'купленый 15'),
       (16, '16', 'купленый 16'),
       (17, '17', 'купленый 17'),
       (18, '18', 'купленый 18'),
       (19, '19', 'купленый 19');
	------Заполним таблицу PURСHASES-------
 -- ************** Данные со сбоем *******************************
INSERT INTO "PURCHASES"("ID",
                        "DATETIME",
                        "AMOUNT",
                        "SELLER_ID")
    VALUES 
    (1, '2024-01-01 01:01:01', 70, 17),
       --70, Должен быть на 100
    (2, '2024-01-01 01:01:01', 80, 18); 
    --80, Должен быть на 100

 ------Заполним таблицу PURСHASE_RECEIPTS-----------
INSERT INTO "PURCHASE_RECEIPT"("PURCHASE_ID",
                               "ORDINAL_NUMBER",
                               "PRODUCT_ID",
                               "QUANTITY",
                               "AMOUNT_FULL",
                               "AMOUNT_DISCOUNT")
VALUES(1, 1, 10, 1, 20, 50),
      (1, 2, 11, 1, 30, 50),
      (1, 3, 12, 1, 60, 50),
      (1, 4, 13, 1, 15, 0),
      (1, 5, 14, 1, 60, 50),
      -- cумма со скидкой чек 1 = 100
      (2, 1, 10, 1, 40, 50),
      (2, 2, 11, 2, 120, 50),
      (2, 3, 12, 1, 20, 0);
     -- cумма со скидкой чек 2 = 100
-- *********************************************************************
-- без сбоев

INSERT INTO "PURCHASES"("ID",
                        "DATETIME",
                        "AMOUNT",
                        "SELLER_ID")
VALUES (3, '2024-02-02 01:01:01', 100, 14),
       -- 100 Должен быть на 100
       (4, '2024-02-02 01:01:01', 100, 15);
       --100 Должен быть на 100


INSERT INTO "PURCHASE_RECEIPT"("PURCHASE_ID",
                               "ORDINAL_NUMBER",
                               "PRODUCT_ID",
                               "QUANTITY",
                               "AMOUNT_FULL",
                               "AMOUNT_DISCOUNT")
VALUES(3, 1, 10, 1, 20, 50),
      (3, 2, 11, 1, 30, 50),
      (3, 3, 12, 1, 60, 50),
      (3, 4, 13, 1, 15, 0),
      (3, 5, 14, 1, 60, 50),
      -- cумма со скидкой чек 3 = 100
      (4, 1, 10, 1, 40, 50),
      (4, 2, 11, 2, 120, 50),
      (4, 3, 12, 1, 20, 0);

       -- cумма со скидкой чек 4 = 100
-- ****************************************************     
-- Данные на прошлый месяц, все без сбоев

INSERT INTO "PURCHASES"("ID",
                        "DATETIME",
                        "AMOUNT",
                        "SELLER_ID")
VALUES (6, CURRENT_TIMESTAMP - interval '1 month', 1000, 14),
       (5, CURRENT_TIMESTAMP - interval '1 month', 1000, 15);


INSERT INTO "PURCHASE_RECEIPT"("PURCHASE_ID",
                               "ORDINAL_NUMBER",
                               "PRODUCT_ID",
                               "QUANTITY",
                               "AMOUNT_FULL",
                               "AMOUNT_DISCOUNT")
VALUES(5, 1, 11, 1, 2000, 50),
      (6, 1, 11, 1, 1000, 50),
      (6, 2, 12, 1, 500, 0);

--------- 10 чек 5---------------------на 1000 чек 6--------------за прошлый месяц, маг 1

INSERT INTO "PURCHASES"("ID",
                        "DATETIME",
                        "AMOUNT",
                        "SELLER_ID")
VALUES (7, CURRENT_TIMESTAMP - interval '1 month', 20, 17),
       (8, CURRENT_TIMESTAMP - interval '1 month', 1000, 18),
       (9, CURRENT_TIMESTAMP - interval '1 month', 10, 20),
       (10, CURRENT_TIMESTAMP - interval '1 month', 50, 18),
       (11, CURRENT_TIMESTAMP - interval '1 month', 20, 21),
       (12, CURRENT_TIMESTAMP - interval '1 month', 2000, 21),
       (13, CURRENT_TIMESTAMP - interval '1 month', 8000, 21);


INSERT INTO "PURCHASE_RECEIPT"("PURCHASE_ID",
                               "ORDINAL_NUMBER",
                               "PRODUCT_ID",
                               "QUANTITY",
                               "AMOUNT_FULL",
                               "AMOUNT_DISCOUNT")
VALUES(7, 1, 13, 1, 40, 50),
      (8, 1, 14, 1, 1000, 50),
      (8, 2, 15, 1, 500, 0),
      (9, 1, 17, 1, 100, 90),
      (10, 1, 16, 1, 100, 50),
      (11, 1, 18, 1, 20, 0),
      (12, 1, 19, 1, 4000, 50),
      (13, 1, 19, 1, 10000, 50),
      (13, 2, 10, 1, 3000, 0);