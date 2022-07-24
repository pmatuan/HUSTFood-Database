CREATE DATABASE hustfood
USE hustfood
DROP DATABASE hustfood
-- tables
-- Table: comment
CREATE TABLE comment (
    id int  NOT NULL IDENTITY,
    placed_order_id int  NOT NULL,
    comment_text text  NULL,
    vote char(1)  NULL,
    CONSTRAINT comment_pk PRIMARY KEY  (id)
);

-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL IDENTITY,
    customer_name nvarchar(255)  NOT NULL,
    phone_number varchar(255)  NOT NULL,
    email varchar(255)  NOT NULL,
    password varchar(255)  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY  (id)
);

-- Table: customer_payment
CREATE TABLE customer_payment (
    id int  NOT NULL IDENTITY,
    customer_id int  NOT NULL,
    payment_type char(20) NOT NULL CHECK(payment_type IN ('MOMO','ZALOPAY', 'VTMONEY', 'SHOPEEPAY', 'CASH')) DEFAULT 'CASH',
    CONSTRAINT customer_payment_pk PRIMARY KEY  (id)
);

-- Table: in_offer
CREATE TABLE in_offer (
    id int  NOT NULL IDENTITY,
    offer_id int  NOT NULL,
    menu_item_id int  NOT NULL,
    restaurant_id int  NOT NULL,
    CONSTRAINT in_offer_ak_1 UNIQUE (offer_id, menu_item_id),
    CONSTRAINT in_offer_pk PRIMARY KEY  (id)
);

-- Table: in_order
CREATE TABLE in_order (
    id int  NOT NULL IDENTITY,
    placed_order_id int  NOT NULL,
    menu_item_id int  NOT NULL,
    offer_id int  NOT NULL,
    quantity int  NOT NULL,
    item_price int  NOT NULL,
    price int  NOT NULL,
    comment text  NULL,
    CONSTRAINT in_order_pk PRIMARY KEY  (id)
);

-- Table: menu_item
CREATE TABLE menu_item (
    id int  NOT NULL IDENTITY,
    item_name nvarchar(255)  NOT NULL,
    category_name nvarchar(255)  NULL,
    image image  NULL,
    description text  NULL,
    ingredients text  NULL,
    price int  NOT NULL,
    active bit  NOT NULL,
    restaurant_id int  NOT NULL,
    CONSTRAINT menu_item_pk PRIMARY KEY  (id)
);

-- Table: offer
CREATE TABLE offer (
    id int  NOT NULL IDENTITY,
    date_active_from date  NULL,
    time_active_from time  NULL,
    date_active_to date  NULL,
    time_active_to time  NULL,
    offer_price int  NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY  (id)
);

-- Table: order_status
CREATE TABLE order_status (
    id int  NOT NULL IDENTITY,
    placed_order_id int  NOT NULL,
    time_order time  NOT NULL,
    order_status nvarchar(255) NOT NULL CHECK(order_status IN ('ADDED_TO_CART','CONFIRMED','PAYMENT_CONFIRMED','DELIVERED')),
    payment_status nvarchar(255) NOT NULL CHECK(payment_status IN('NOT_CONFIRMED','CONFIRMED')) DEFAULT 'NOT_CONFIRMED',
    CONSTRAINT order_status_pk PRIMARY KEY  (id)
);

-- Table: placed_order
CREATE TABLE placed_order (
    id int  NOT NULL IDENTITY,
    customer_id int  NOT NULL,
    restaurant_id int  NOT NULL,
    price int  NOT NULL,
    discount int  NULL,
    delivery_fee int  NULL,
    final_price int  NOT NULL,
    payment_type char(255)  NULL CHECK(payment_type IN ('CASH_ON_DELIVERY','ONLINE_PAYMENT')) DEFAULT 'CASH_ON_DELIVERY',
    delivery_address nvarchar(255)  NULL,
    estimated_delivery_time time  NULL,
    food_ready time  NULL,
    comment text  NULL,
    delivered bit  NOT NULL,
    CONSTRAINT Customer_order PRIMARY KEY  (id)
);

-- Table: restaurant
CREATE TABLE restaurant (
    id int  NOT NULL IDENTITY,
    restaurant_name nvarchar(255)  NOT NULL,
    restaurant_address nvarchar(255)  NOT NULL,
    CONSTRAINT restaurant_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: comment_placed_order (table: comment)
ALTER TABLE comment ADD CONSTRAINT comment_placed_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: customer_payment_customer (table: customer_payment)
ALTER TABLE customer_payment ADD CONSTRAINT customer_payment_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

ALTER TABLE customer ADD CONSTRAINT unique_email
    UNIQUE (email)

-- Reference: in_offer_menu_item (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_menu_item
    FOREIGN KEY (menu_item_id)
    REFERENCES menu_item (id);

-- Reference: in_offer_offer (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_offer
    FOREIGN KEY (offer_id)
    REFERENCES offer (id);

-- Reference: in_offer_restaurant (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant (id);

-- Reference: in_order_menu_item (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_menu_item
    FOREIGN KEY (menu_item_id)
    REFERENCES menu_item (id);

-- Reference: in_order_offer (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_offer
    FOREIGN KEY (offer_id)
    REFERENCES offer (id);

-- Reference: in_order_placed_order (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_placed_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: menu_item_restaurant (table: menu_item)
ALTER TABLE menu_item ADD CONSTRAINT menu_item_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant (id);

-- Reference: order_restaurant (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT order_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant (id);

-- Reference: order_status_order (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: placed_order_customer (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT placed_order_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);



