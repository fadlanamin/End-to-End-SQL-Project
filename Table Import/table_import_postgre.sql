-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/D3Zx1w
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "orders" (
    "order_date" date   NOT NULL,
    "order_id" varchar(35)   NOT NULL,
    "cust_id" varchar(35)   NOT NULL,
    "order_total" numeric   NOT NULL,
    "item_quantity" int   NOT NULL,
    "delivery_id" varchar(35)   NOT NULL,
    "payment_id" varchar(35)   NOT NULL,
    "status" varchar(35)   NOT NULL,
    CONSTRAINT "pk_orders" PRIMARY KEY (
        "order_id"
     )
);

CREATE TABLE "order_items" (
    "order_id" varchar(35)   NOT NULL,
    "item_id" varchar(35)   NOT NULL,
    "item_price" numeric   NOT NULL,
    "quantity" int   NOT NULL,
    "total_price" numeric   NOT NULL,
    CONSTRAINT "pk_order_items" PRIMARY KEY (
        "order_id","item_id"
     )
);

CREATE TABLE "products" (
    "sku_id" varchar(35)   NOT NULL,
    "product_name" varchar(70)   NOT NULL,
    "category_id" varchar(35)   NOT NULL,
    "product_type" varchar(35)   NOT NULL,
    "shelf_life" varchar(35)   NOT NULL,
    "cogs" numeric   NOT NULL,
    "product_price" numeric   NOT NULL,
    CONSTRAINT "pk_products" PRIMARY KEY (
        "sku_id"
     )
);

CREATE TABLE "category" (
    "category_id" varchar(35)   NOT NULL,
    "category_name" varchar(60)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "users" (
    "user_id" varchar(35)   NOT NULL,
    "customer_name" varchar(65)   NOT NULL,
    "gender" varchar(10)   NOT NULL,
    "email" varchar(50)   NOT NULL,
    "phone" int   NOT NULL,
    "address" varchar(100)   NOT NULL,
    "postal_code" int   NOT NULL,
    "location" varchar(45)   NOT NULL,
    CONSTRAINT "pk_users" PRIMARY KEY (
        "user_id"
     )
);

CREATE TABLE "competitors" (
    "product_id" varchar(35)   NOT NULL,
    "competitor_1" numeric   NOT NULL,
    "competitor_2" numeric   NOT NULL,
    "competitor_3" numeric   NOT NULL,
    CONSTRAINT "pk_competitors" PRIMARY KEY (
        "product_id"
     )
);

CREATE TABLE "delivery" (
    "delivery_id" varchar(35)   NOT NULL,
    "delivery_method" varchar(35)   NOT NULL,
    "delivery_fee" numeric   NOT NULL,
    CONSTRAINT "pk_delivery" PRIMARY KEY (
        "delivery_id"
     )
);

CREATE TABLE "payment" (
    "payment_id" varchar(35)   NOT NULL,
    "payment_method" varchar(35)   NOT NULL,
    "admin_costs" numeric   NOT NULL,
    CONSTRAINT "pk_payment" PRIMARY KEY (
        "payment_id"
     )
);

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_order_id" FOREIGN KEY("order_id")
REFERENCES "order_items" ("order_id");

ALTER TABLE "products" ADD CONSTRAINT "fk_products_sku_id" FOREIGN KEY("sku_id")
REFERENCES "order_items" ("item_id");

ALTER TABLE "category" ADD CONSTRAINT "fk_category_category_id" FOREIGN KEY("category_id")
REFERENCES "products" ("category_id");

ALTER TABLE "users" ADD CONSTRAINT "fk_users_user_id" FOREIGN KEY("user_id")
REFERENCES "orders" ("cust_id");

ALTER TABLE "competitors" ADD CONSTRAINT "fk_competitors_product_id" FOREIGN KEY("product_id")
REFERENCES "products" ("sku_id");

ALTER TABLE "delivery" ADD CONSTRAINT "fk_delivery_delivery_id" FOREIGN KEY("delivery_id")
REFERENCES "orders" ("delivery_id");

ALTER TABLE "payment" ADD CONSTRAINT "fk_payment_payment_id" FOREIGN KEY("payment_id")
REFERENCES "orders" ("payment_id");

