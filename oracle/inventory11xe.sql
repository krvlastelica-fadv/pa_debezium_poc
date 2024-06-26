--drop tables
--DROP TABLE ORDERS ;
--DROP TABLE PRODUCTS_ON_HAND ;
--DROP TABLE PRODUCTS ;
--DROP TABLE CUSTOMERS ;


-- Create and populate our products using a single insert with many rows
CREATE TABLE products (
  id NUMBER(4) NOT NULL  PRIMARY KEY,
  name VARCHAR2(255) NOT NULL,
  description VARCHAR2(512),
  weight FLOAT
);
GRANT SELECT ON products to debezium;
ALTER TABLE products ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO products
  VALUES (101,'scooter','Small 2-wheel scooter',3.14);
INSERT INTO products
  VALUES (102,'car battery','12V car battery',8.1);
INSERT INTO products
  VALUES (103,'12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO products
  VALUES (104,'hammer','12oz carpenter''s hammer',0.75);
INSERT INTO products
  VALUES (105,'hammer','14oz carpenter''s hammer',0.875);
INSERT INTO products
  VALUES (106,'hammer','16oz carpenter''s hammer',1.0);
INSERT INTO products
  VALUES (107,'rocks','box of assorted rocks',5.3);
INSERT INTO products
  VALUES (108,'jacket','water resistent black wind breaker',0.1);
INSERT INTO products
  VALUES (109,'spare tire','24 inch spare tire',22.2);

-- Create and populate the products on hand using multiple inserts
CREATE TABLE products_on_hand (
  product_id NUMBER(4) NOT NULL PRIMARY KEY,
  quantity NUMBER(4) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(id)
);
GRANT SELECT ON products_on_hand to debezium;
ALTER TABLE products_on_hand ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO products_on_hand VALUES (101,3);
INSERT INTO products_on_hand VALUES (102,8);
INSERT INTO products_on_hand VALUES (103,18);
INSERT INTO products_on_hand VALUES (104,4);
INSERT INTO products_on_hand VALUES (105,5);
INSERT INTO products_on_hand VALUES (106,0);
INSERT INTO products_on_hand VALUES (107,44);
INSERT INTO products_on_hand VALUES (108,2);
INSERT INTO products_on_hand VALUES (109,5);

-- Create some customers ...
CREATE TABLE customers (
  id NUMBER(4)  NOT NULL PRIMARY KEY,
  first_name VARCHAR2(255) NOT NULL,
  last_name VARCHAR2(255) NOT NULL,
  email VARCHAR2(255) NOT NULL UNIQUE
);
GRANT SELECT ON customers to debezium;
ALTER TABLE customers ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO customers
  VALUES (1001,'Sally','Thomas','sally.thomas@acme.com');
INSERT INTO customers
  VALUES (1002,'George','Bailey','gbailey@foobar.com');
INSERT INTO customers
  VALUES (1003,'Edward','Walker','ed@walker.com');
INSERT INTO customers
  VALUES (1004,'Anne','Kretchmar','annek@noanswer.org');

-- Create some very simple orders
CREATE TABLE orders (
  id NUMBER(6)  NOT NULL PRIMARY KEY,
  order_date DATE NOT NULL,
  purchaser NUMBER(4) NOT NULL,
  quantity NUMBER(4) NOT NULL,
  product_id NUMBER(4) NOT NULL,
  FOREIGN KEY (purchaser) REFERENCES customers(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
GRANT SELECT ON orders to debezium;
ALTER TABLE orders ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

INSERT INTO orders
  VALUES (10001, '16-JAN-2016', 1001, 1, 102);
INSERT INTO orders
  VALUES (10002, '17-JAN-2016', 1002, 2, 105);
INSERT INTO orders
  VALUES (10003, '19-FEB-2016', 1002, 2, 106);
INSERT INTO orders
  VALUES (10004, '21-FEB-2016', 1003, 1, 107);
