-- **************************************
-- *------Задание 1A-------------------**
-- *    Вывод 1-е 9 записей            **
-- **************************************
    (SELECT "CODE",
          "NAME"
   FROM "PRODUCTS")
EXCEPT
  (SELECT DISTINCT "CODE",
                   "NAME"
   FROM "PURCHASES"
   JOIN "PURCHASE_RECEIPT" ON "PURCHASE_ID" = "ID"
   JOIN "PRODUCTS" ON "PRODUCTS"."ID" = "PRODUCT_ID"
   WHERE "DATETIME" >= date_trunc('month', CURRENT_TIMESTAMP - interval '1 month')
     AND "DATETIME" < date_trunc('month', CURRENT_TIMESTAMP))
ORDER BY "CODE";
-- **************************************
-- **************************************
-- * -----Задание 1c--------------------*
-- * Выход: 10030 | Томская область     *
-- *        3070  | Омская область      *
-- **************************************
SELECT sum("AMOUNT") AS "REVENUE",
       "REGION"
FROM "PURCHASES"
JOIN "EMPLOYEES" ON "EMPLOYEES"."ID" = "SELLER_ID"
JOIN "SHOPS" ON "SHOPS"."ID" = "SHOP_ID"
WHERE "DATETIME" >= date_trunc('month', CURRENT_TIMESTAMP - interval '1 month')
  AND "DATETIME" < date_trunc('month', CURRENT_TIMESTAMP)
GROUP BY "REGION"
ORDER BY "REVENUE" DESC;
-- **************************************
-- **************************************
-- * -----Задание 1b--------------------*
-- * Выход                              *
-- * 2 непродающих из магазина 2        *
-- * 1 непродающий из магазина 1        *
-- * В магазине 3 все что то да продали *
-- * Два максимально продавших на       *
-- * одну сумму из магазина 1           *
-- * По одному из магазина 2 и 3        *
-- **************************************
WITH "by_stores" AS
  (WITH "by_stores_all" AS (
    (SELECT "SHOPS"."NAME",
            "FIRST_NAME",
            "LAST_NAME",
            count(*)-1 AS "SALES"
     FROM "SHOPS"
     JOIN "EMPLOYEES" ON "SHOP_ID" = "SHOPS"."ID"
                     AND "JOB_NAME" = 'Seller'
     GROUP BY "FIRST_NAME",
              "LAST_NAME",
              "SHOPS"."NAME")
 UNION
    (SELECT "SHOPS"."NAME",
            "FIRST_NAME",
            "LAST_NAME",
            sum("AMOUNT") AS "SALES"
     FROM "SHOPS"
     JOIN "EMPLOYEES" ON "SHOP_ID" = "SHOPS"."ID"
     JOIN "PURCHASES" ON "PURCHASES"."SELLER_ID" = "EMPLOYEES"."ID"
     WHERE ("DATETIME" >= date_trunc('month', CURRENT_TIMESTAMP - interval '1 month')
     AND "DATETIME" < date_trunc('month', CURRENT_TIMESTAMP))
     AND "JOB_NAME" = 'Seller'
     GROUP BY "FIRST_NAME",
              "LAST_NAME",
              "SHOPS"."NAME"))
  SELECT "NAME",
         "FIRST_NAME",
         "LAST_NAME",
          sum("SALES") AS "SALES"
   FROM "by_stores_all"
   GROUP BY "FIRST_NAME",
            "LAST_NAME",
            "NAME")
(SELECT a."NAME",
        a."FIRST_NAME",
        a."LAST_NAME",
        a."SALES" AS "best/no_sales"
 FROM "by_stores" AS a
 JOIN
   (SELECT "by_stores"."NAME",
            max("by_stores"."SALES")AS"SALES"
    FROM "by_stores"
    GROUP BY "NAME")AS b
 ON b."NAME" = a."NAME"
 AND b."SALES" = a."SALES"
 WHERE b."SALES" > 0
 )
UNION
(SELECT "NAME",
        "FIRST_NAME",
        "LAST_NAME",
        "SALES" AS "best/no_sales"
 FROM "by_stores"
 EXCEPT  
 SELECT "NAME",
        "FIRST_NAME",
        "LAST_NAME",
        "SALES" AS "best/no_sales"
 FROM "by_stores"
 WHERE "SALES">0)
ORDER BY "best/no_sales";
-- **************************************
-- **************************************
-- * -----Задание 2---------------------*
-- * Выход: две покупки из магазина 2   *
-- **************************************
WITH "receipts_sum" AS
  (SELECT sum("AMOUNT_FULL" - ("AMOUNT_FULL"/100 *"AMOUNT_DISCOUNT")) AS "sum",
          "PURCHASE_ID"
   FROM "PURCHASE_RECEIPT"
   GROUP BY "PURCHASE_ID")
SELECT "NAME",
       "DATETIME",
       "AMOUNT"-"sum" AS "AMOUNT-SUM_RECEIPTS"
FROM "PURCHASES"
JOIN "receipts_sum" ON "PURCHASE_ID" = "PURCHASES"."ID"
JOIN "EMPLOYEES" ON "EMPLOYEES"."ID" = "SELLER_ID"
JOIN "SHOPS" ON "SHOPS"."ID" = "SHOP_ID"
WHERE "sum" != "AMOUNT";
