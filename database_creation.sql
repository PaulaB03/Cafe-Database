--creare tabel locations
CREATE TABLE locations (
    location_id    NUMBER(3) PRIMARY KEY,
    street_address VARCHAR2(20),
    postal_code    CHAR(6),
    city           VARCHAR2(10)
);

--creare tabel jobs
CREATE TABLE jobs (
    job_id     NUMBER(3) PRIMARY KEY,
    job_title  VARCHAR2(10),
    min_salary NUMBER(4),
    max_salary NUMBER(4)
);

--creare tabel customers
CREATE TABLE customers (
    customer_id NUMBER(3) PRIMARY KEY,
    first_name  VARCHAR2(10),
    last_name   VARCHAR2(10)
);

--creare tabel categories
CREATE TABLE categories (
    category_id   NUMBER(3) PRIMARY KEY,
    category_name VARCHAR2(10)
);

--creare tabel glasses
CREATE TABLE glasses (
    glass_id       NUMBER(3) PRIMARY KEY,
    glass_type     VARCHAR2(10),
    glass_material VARCHAR2(10)
);

--creare tabel cafes
CREATE TABLE cafes (
    cafe_id           NUMBER(3) PRIMARY KEY,
    location_id       NUMBER(3) NOT NULL,
    cafe_name         VARCHAR(20),
    cafe_phone_number CHAR(10),
    cafe_email        VARCHAR2(20),
    manager_id        NUMBER(3),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

--creare tabel suppliers
CREATE TABLE suppliers (
    supplier_id NUMBER(3) PRIMARY KEY,
    location_id NUMBER(3) NOT NULL,
    supplier_name VARCHAR2(15),
    phone_number CHAR(10),
    supplier_email VARCHAR(20),
    FOREIGN KEY (location_id) REFERENCES locations(location_id) 
);

--creare tabel products
CREATE TABLE products (
    product_id NUMBER(3) PRIMARY KEY,
    cafe_id    NUMBER(3) NOT NULL,
    product_name     VARCHAR2(15),
    price      NUMBER(2),
    FOREIGN KEY (cafe_id) REFERENCES cafes(cafe_id)
);

--creare tabel snacks
CREATE TABLE snacks (
    snack_id    NUMBER(3) PRIMARY KEY,
    supplier_id NUMBER(3) NOT NULL,
    product_id  NUMBER(3) NOT NULL,
    category_id NUMBER(3) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

--creare tabel drinks
CREATE TABLE drinks (
    drink_id    NUMBER(3) PRIMARY KEY,
    product_id  NUMBER(3) NOT NULL,
    glass_id    NUMBER(3) NOT NULL,
    category_id NUMBER(3) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (glass_id) REFERENCES glasses(glass_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id) 
);

--creare tabel employees
CREATE TABLE employees (
    employee_id  NUMBER(3) PRIMARY KEY,
    job_id       NUMBER(3) NOT NULL,
    cafe_id      NUMBER(3) NOT NULL,
    first_name   VARCHAR2(10),
    last_name    VARCHAR2(10),
    phone_number CHAR(10),
    email        VARCHAR2(20),
    salary       NUMBER(4),
    hire_date    DATE,
    manager_id   NUMBER(3),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (cafe_id) REFERENCES cafes(cafe_id)
);

--creare tabel bills
CREATE TABLE bills (
    bill_id      NUMBER(3) PRIMARY KEY,
    employee_id  NUMBER(3) NOT NULL,
    cafe_id      NUMBER(3) NOT NULL,
    customer_id  NUMBER(3) NOT NULL,
    payment_type CHAR(4) NOT NULL,
    data_bill    DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--creare tabel orders
CREATE TABLE orders (
    order_id   NUMBER(3) PRIMARY KEY,
    bill_id    NUMBER(3) NOT NULL,
    product_id NUMBER(3) NOT NULL,
    quantity   NUMBER(1) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- inserarea datelor in tabelul locations
INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (100, 'Grozavesti 21', '060752', 'Bucuresti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (101, 'Rovine 15', '110425', 'Pitesti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (102, 'Traian 20', '100062', 'Ploiesti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (103, 'Calarasi 52', '030611', 'Bucuresti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (104, 'Floarea-soarelui 7', '041271', 'Bucuresti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (105, 'Bucegi 30', '120208', 'Buzau');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (106, 'Carol 20', '030165', 'Bucuresti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (107, 'Alunului 9', '110335', 'Pitesti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (108, 'Azuga 1', '100526', 'Ploiesti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (109, 'Sebes 41', '033084', 'Bucuresti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (110, 'Gloriei 60', '120057', 'Buzau');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (111, 'Oltului 35', '100361', 'Ploiesti');

INSERT INTO locations (location_id, street_address, postal_code, city) 
VALUES (112, 'Parcului 5', '012329', 'Bucuresti');

-- verificare date
SELECT *
FROM locations;

-- inserarea datelor in tabelul jobs
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
VALUES (100, 'manager', 2500, 3000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
VALUES (101, 'barista', 2000, 2500);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
VALUES (102, 'waiter', 2000, 2500);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
VALUES (103, 'cashier', 1500, 2000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary) 
VALUES (104, 'janitor', 1500, 2000);

-- verificare date
SELECT *
FROM jobs;

-- inserarea datelor in tabelul categories
INSERT INTO categories (category_id, category_name) 
VALUES (100, 'Coffee');

INSERT INTO categories (category_id, category_name) 
VALUES (101, 'Tea');

INSERT INTO categories (category_id, category_name) 
VALUES (102, 'Lemonade');

INSERT INTO categories (category_id, category_name) 
VALUES (103, 'Soda');

INSERT INTO categories (category_id, category_name) 
VALUES (104, 'Juice');

INSERT INTO categories (category_id, category_name) 
VALUES (105, 'Sweets');

INSERT INTO categories (category_id, category_name) 
VALUES (106, 'Chips');

-- verificare date
SELECT *
FROM categories;

-- inserarea datelor in tabelul glasses
INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (100, 'teacup', 'porcelain');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (101, 'bottle', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (102, 'coffeecup', 'porcelain');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (103, 'farmhouse', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (104, 'delmonico', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (105, 'highball', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (106, 'pint', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (107, 'balloon', 'glass');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (108, 'nervis', 'porcelain');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (109, 'glence', 'porcelain');

INSERT INTO glasses (glass_id, glass_type, glass_material) 
VALUES (110, 'lomond', 'porcelain');

-- verificare date
SELECT *
FROM glasses;

-- inserarea datelor in tabelul cafes
INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id)
VALUES (100, 101, 'Noir Cafe', '0771846523', 'noircafe', 100);

INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id) 
VALUES (101, 100, 'Boulevard Cafe', '0748453500', 'boulevardcafe1', 105);

INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id)
VALUES (102, 104, 'Coffe House', '0760035522', 'coffee_house', 106);

INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id) 
VALUES (103, 107, 'Cafe Mania', '0778448526', 'cafemania', 108);

INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id)
VALUES (104, 111, 'Coffe Planet', '0750845665', 'coffee.planet', 102);

INSERT INTO cafes (cafe_id, location_id, cafe_name, cafe_phone_number, cafe_email, manager_id)
VALUES (105, 112, 'Coffe Point', '0770089564', 'coffee_point', 101);

-- verificare date
SELECT *
FROM cafes;

-- inserarea datelor in tabelul suppliers
INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (100, 105, 'Alfers', '0763459512', 'alfers24');

INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (101, 110, 'Milka', '0763459972', 'milka.ro');

INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (102, 102, 'Lay''s', '0771548625', 'laysRO');

INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (103, 106, 'Oreo', '0746485243', 'oreo101');

INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (104, 108, 'Lotto', '0761983462', 'lotto_romania');

INSERT INTO suppliers (supplier_id, location_id, supplier_name, phone_number, supplier_email)
VALUES (105, 103, 'Viva', '0741998544', 'viva14');

-- verificare date
SELECT *
FROM suppliers;

-- inserarea datelor in tabelul products
INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (100, 101, 'espresso', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (101, 101, 'americano', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (102, 101, 'cappuccino', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (103, 101, 'caffe latte', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (104, 101, 'green tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (105, 101, 'black tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (106, 101, 'fruits tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (107, 101, 'cola', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (108, 101, 'fanta', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (109, 101, 'sprite', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (110, 101, 'lemonade', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (111, 101, 'mint lemonade', 12);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (112, 101, 'peach lemonade', 12);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (113, 101, 'wafers', 4);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (114, 101, 'salt chips', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (115, 101, 'peper chips', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (116, 101, 'milka chocolate', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (117, 101, 'oreo brownies', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (118, 101, 'apple juice', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (119, 101, 'orange juice', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (120, 101, 'oreo biscuits', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (121, 100, 'espresso', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (122, 100, 'americano', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (123, 100, 'cappuccino', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (124, 100, 'caffe latte', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (125, 100, 'green tea', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (126, 100, 'black tea', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (127, 100, 'cola', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (128, 100, 'fanta', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (129, 100, 'salt chips', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (130, 100, 'peper chips', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (131, 100, 'oreo biscuits', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (132, 102, 'espresso', 4);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (133, 102, 'americano', 4);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (134, 102, 'cappuccino', 4);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (135, 102, 'caffe latte', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (136, 103, 'espresso', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (137, 103, 'americano', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (138, 103, 'cappuccino', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (139, 103, 'caffe latte', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (140, 103, 'green tea', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (141, 103, 'black tea', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (142, 103, 'lemonade', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (143, 103, 'cola', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (144, 103, 'fanta', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (145, 103, 'sprite', 6);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (146, 103, 'salt chips', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (147, 103, 'peper chips', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (148, 104, 'espresso', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (149, 104, 'americano', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (150, 104, 'cappuccino', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (151, 104, 'caffe latte', 5);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (152, 104, 'green tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (153, 104, 'black tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (154, 104, 'fruits tea', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (155, 104, 'cola', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (156, 104, 'fanta', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (157, 104, 'sprite', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (158, 104, 'lemonade', 13);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (159, 105, 'espresso', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (160, 105, 'cappuccino', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (161, 105, 'caffe latte', 7);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (162, 105, 'green tea', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (163, 105, 'black tea', 8);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (164, 105, 'lemonade', 15);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (165, 105, 'peach lemonade', 15);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (166, 105, 'mint lemonade', 15);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (167, 105, 'milka chocolate', 10);

INSERT INTO products (product_id, cafe_id, product_name, price) 
VALUES (168, 105, 'wafers', 19);

-- verificare date
SELECT *
FROM products;

-- inserarea datelor in tabelul snacks
INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (100, 100, 113, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (101, 102, 114, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (102, 102, 115, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (103, 101, 116, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (104, 103, 117, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (105, 103, 120, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (106, 105, 129, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (107, 105, 130, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (108, 103, 131, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (109, 102, 146, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (110, 102, 147, 106);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (111, 101, 167, 105);

INSERT INTO snacks (snack_id, supplier_id, product_id, category_id) 
VALUES (112, 100, 168, 105);

-- verificare date
SELECT *
FROM snacks;

-- inserarea datelor in tabelul drinks
SELECT * FROM drinks;


CREATE SEQUENCE sequence_1
START WITH 100
INCREMENT BY 1;

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 100, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 101, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 102, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 103, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 104, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 105, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 106, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 107, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 108, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 109, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 110, 102, 109);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 111, 102, 109);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (sequence_1.nextval, 112, 102, 108);
/*
INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (100, 100, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (101, 101, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (102, 102, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (103, 103, 100, 102);
INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (104, 104, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (105, 105, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (106, 106, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (107, 107, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (108, 108, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (109, 109, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (110, 110, 102, 109);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (111, 111, 102, 109);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (112, 112, 102, 108);
*/
INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (113, 118, 104, 105);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (114, 119, 104, 106);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (115, 121, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id)  
VALUES (116, 122, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (117, 123, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (118, 124, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (119, 125, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (120, 126, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (121, 127, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (122, 128, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (123, 132, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id)  
VALUES (124, 133, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (125, 134, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (126, 135, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (127, 136, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (128, 137, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (129, 138, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (130, 139, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (131, 140, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (132, 141, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (133, 142, 102, 105);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (134, 143, 104, 106);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (135, 144, 104, 106);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (136, 145, 104, 107);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (137, 148, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (138, 149, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (139, 150, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (140, 151, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (141, 152, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (142, 153, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (143, 154, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (144, 155, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (145, 156, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (146, 157, 103, 101);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (147, 158, 102, 105);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (148, 159, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (149, 160, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (150, 161, 100, 102);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (151, 162, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (152, 163, 101, 100);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (153, 164, 102, 106);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (154, 165, 102, 107);

INSERT INTO drinks (drink_id, product_id, category_id, glass_id) 
VALUES (155, 166, 102, 106);

-- verificare date
SELECT *
FROM drinks;

-- inserarea datelor in tabelul employees
INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id) 
VALUES (100, 100, 100, 'Bruce', 'Dilly', '0738217557', 'BDilly', 3000, to_date('28/Apr/21', 'DD-MON-RR'), NULL);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (101, 101, 100, 'Daniel', 'Fay', '0721887141', 'dfay', 2500, to_date('30/Apr/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id) 
VALUES (102, 102, 100, 'Luis', 'Marvis', '0724791424', 'lmarvis', 2500, to_date('30/Apr/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (103, 103, 100, 'Shelli', 'Grant', '0784395435', 'SGrant', 2000, to_date('2/May/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id) 
VALUES (104, 104, 101, 'Michael', 'OConnell', '0739817384', 'MOConnell', 2000, to_date('5/Mar/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (105, 101, 101, 'Jhon', 'Russell', '0767500120', 'JRussell', 2400, to_date('5/Mar/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (106, 101, 101, 'Trenna', 'Matos', '0767589667', 'TMatos', 2450, to_date('10/May/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (107, 102, 101, 'Laura', 'Olsen', '0793310740', 'lolsen', 2300, to_date('8/May/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (108, 104, 101, 'Sophie', 'Sully', '0711237299', 'ssully', 1700, to_date('5/Apr/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (109, 103, 101, 'Peter', 'Smith', '0746433608', 'PSmith', 1900, to_date('7/Mar/21', 'DD-MON-RR'), 100);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (110, 100, 102, 'Clara', 'Ozer', '0772806573', 'cozer', 2500, to_date('22/May/21', 'DD-MON-RR'), NULL);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (111, 100, 103, 'Sarath', 'Bloom', '0714926559', 'sbloom', 2570, to_date('10/Mar/21', 'DD-MON-RR'), NULL);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (112, 101, 103, 'Allan', 'Fox', '0763800455', 'afox', 2000, to_date('18/Mar/21', 'DD-MON-RR'), 111);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (113, 103, 103, 'Danielle', 'Russell', '0787965155', 'drussell', 1850, to_date('12/Mar/21', 'DD-MON-RR'), 111);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (114, 100, 104, 'Jack', 'Abel', '0797005558', 'JAbel', 2800, to_date('31/Mar/21', 'DD-MON-RR'), NULL);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (115, 101, 104, 'Julia', 'Roberts', '0735753702', 'jroberts', 2500, to_date('15/Apr/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (116, 102, 104, 'Alexis', 'Hall', '0738478164', 'ahall', 2000, to_date('17/Apr/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (117, 103, 104, 'Martha', 'Vargas', '0765007077', 'mvargas', 1500, to_date('30/Apr/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (118, 104, 104, 'Charles', 'Gee', '0762910685', 'cgee', 1500, to_date('7/May/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (119, 101, 105, 'Ellen', 'Landry', '0781997387', 'ELandry', 2400, to_date('19/May/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (120, 102, 105, 'Tayler', 'Red', '0711624052', 'tred', 2300, to_date('19/May/21', 'DD-MON-RR'), 114);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (121, 100, 105, 'Felix', 'Fay', '0755671789', 'felixfay', 2750, to_date('22/Apr/21', 'DD-MON-RR'), NULL);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (122, 101, 105, 'Susan', 'Russell', '0759546319', 'srussell', 2200, to_date('25/Apr/21', 'DD-MON-RR'), 121);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (123, 102, 105, 'Michael', 'Lee', '0726437768', 'mlee', 2250, to_date('18/May/21', 'DD-MON-RR'), 121);

INSERT INTO employees (employee_id, job_id, cafe_id, first_name, last_name, phone_number, email, salary, hire_date, manager_id)
VALUES (124, 103, 105, 'Allan', 'Bull', '0761548159', 'ABULL', 2050, to_date('20/May/21', 'DD-MON-RR'), 121);

-- verificare date
SELECT *
FROM employees;

-- inserarea datelor in tabelul customers
INSERT INTO customers (customer_id, first_name, last_name)
VALUES (100, 'Jenkins', 'Oliver');

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (101, 'Arhold', 'Rebecca');

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (102, 'White', 'Milly');

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (103, 'Rivera', 'Ross');

INSERT INTO customers (customer_id, first_name, last_name)
VALUES (104, 'Brown', 'Jay');

-- verificare date
SELECT *
FROM customers;

-- inserarea datelor in tabelul bills
INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (100, 103, 100, 100, 'Cash', to_date('15/May/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (101, 109, 101, 101, 'Card', to_date('20/Apr/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (102, 113, 100, 101, 'Cash', to_date('5/May/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (103, 113, 104, 102, 'Card', to_date('6/May/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (104, 103, 100, 102, 'Card', to_date('16/Mar/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (105, 117, 101, 103, 'Cash', to_date('30/Apr/21', 'DD-MON-RR'));

INSERT INTO bills (bill_id, employee_id, cafe_id, customer_id, payment_type, data_bill)
VALUES (106, 124, 103, 104, 'Cash', to_date('15/Mar/21', 'DD-MON-RR'));

-- verificare date
SELECT *
FROM bills;

-- inserarea datelor in tabelul orders
INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (100, 100, 143, 5);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (101, 106, 135, 7);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (102, 105, 101, 2);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (103, 102, 130, 3);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (104, 103, 153, 1);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (105, 104, 131, 5);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (106, 101, 105, 4);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (107, 100, 128, 6);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (108, 101, 101, 3);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (109, 101, 112, 8);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (110, 105, 106, 2);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (111, 105, 120, 2);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (112, 102, 129, 6);

INSERT INTO orders (order_id, bill_id, product_id, quantity) 
VALUES (113, 103, 148, 5);

-- verificare date
SELECT *
FROM orders;

-- stergere tabele
/*
DROP TABLE locations;
DROP TABLE jobs;
DROp TABLE customers;
DROP TABLE categories;
DROP TABLE glasses;
DROP TABLE cafes;
DROP TABLE suppliers;
DROP TABLE products;
DROP TABLE snacks;
DROP TABLE drinks;
DROP TABLE employees;
DROP TABLE bills;
DROP TABLE orders;
*/