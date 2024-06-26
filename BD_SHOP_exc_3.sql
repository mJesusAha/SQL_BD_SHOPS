CREATE TABLE "SHOPS" (
             "ID" numeric(20) NOT NULL,
             "NAME" VARCHAR(200) NOT NULL,
             "REGION" VARCHAR(200) NOT NULL,
             "CITY" VARCHAR(200) NOT NULL,
             "ADDRESS" VARCHAR(200) NOT NULL,
             "MANAGER_ID" NUMERIC(20) NOT NULL,
    CONSTRAINT "SHOPS_PK" PRIMARY KEY ("ID")
);


CREATE TABLE "EMPLOYEES"(
             "ID" numeric(20) NOT NULL,
             "FIRST_NAME" VARCHAR(200) NOT NULL,
             "LAST_NAME" VARCHAR(200) NOT NULL,
             "PHONE" VARCHAR(200) NOT NULL,
             "E_MAIL" VARCHAR(200) NOT NULL,
             "JOB_NAME" VARCHAR(200) NOT NULL,
             "SHOP_ID" NUMERIC(20),
    CONSTRAINT "EMPLOYEES_PK" PRIMARY KEY ("ID"),
    CONSTRAINT "EMPLOYEES_SHOPS_FK"
        FOREIGN KEY ("SHOP_ID") REFERENCES "SHOPS"("ID")
);


ALTER TABLE "SHOPS" ADD CONSTRAINT "SHOPS_EMPLOES_FK"
    FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES"("ID");


CREATE TABLE "PURCHASES"(
             "ID" NUMERIC(20) NOT NULL,
             "DATETIME" TIMESTAMP NOT NULL,
             "AMOUNT" NUMERIC(20) NOT NULL,
             "SELLER_ID" NUMERIC(20),
    CONSTRAINT "PURCHASES_PK" PRIMARY KEY ("ID"), 
    CONSTRAINT "PURCHASES_EMPLOYEES_FK"
        FOREIGN KEY ("SELLER_ID") REFERENCES "EMPLOYEES"("ID")
);

CREATE TABLE "PRODUCTS" (
             "ID" numeric(20) NOT NULL,
             "CODE" VARCHAR(50) NOT NULL,
             "NAME" VARCHAR(200) NOT NULL,
    CONSTRAINT "PRODUCTS_ID" PRIMARY KEY ("ID")
);

CREATE UNIQUE INDEX "PRODUCTS_CODE_UK" ON "PRODUCTS"("CODE");

CREATE TABLE "PURCHASE_RECEIPT"(
             "PURCHASE_ID" NUMERIC(20) NOT NULL,
             "ORDINAL_NUMBER" NUMERIC(5) NOT NULL,
             "PRODUCT_ID" NUMERIC(20) NOT NULL,
             "QUANTITY" NUMERIC(25, 5) NOT NULL,
             "AMOUNT_FULL" NUMERIC(20) NOT NULL,
             "AMOUNT_DISCOUNT" NUMERIC(20) NOT NULL,
    CONSTRAINT "PURCHASE_RECEIPTS_PK" PRIMARY KEY ("PURCHASE_ID", "ORDINAL_NUMBER"), 
    CONSTRAINT "PURCHASE_RECEIPTS_PURCHASES_FK"
        FOREIGN KEY ("PURCHASE_ID") REFERENCES "PURCHASES"("ID"),
    CONSTRAINT "EMPLOYEES_SHOPS_FK"
        FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCTS"("ID"));	