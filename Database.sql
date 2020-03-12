CREATE DATABASE Umuzi;

CREATE TABLE customer(

    id SERIAL PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    gender varchar(10),
    address varchar(200),
    phone varchar(15),
    email varchar(100),
    city varchar(20),
    country varchar(50)
);
INSERT INTO customers(first_name, last_name, gender, address, phone, email, city, country)
VALUES ('John','Hilbert','Male','284 chaucer st','084789657','john@gmail.com','Johannesburg','South Africa')
       ('Thando','Sithole','Female','240 Sect 1','0794445584','thando@gmail.com','Cape Town','South Africa')
       ('Leon','Glen','Male','81 Everton Rd,Gillits','0820832830','Leon@gmail.com','Durban','South Africa')
       ('Charl','Muller','M￼ale','290A Dorset Ecke','+44856872553','Charl.muller@yahoo.com','Berlin','Germany')
       ('Julia','Stein','Female','22 Wernerring','+448672445058','Js234@yahoo.com','Frankfurt','Germany');

CREATE TABLE employees;(
    id SERIAL PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    job_title varchar(20)

);
INSERT INTO employees(first_name, last_name, email, job_title)

VALUES ('Kani','Matthew','mat@gmail.com','Manager');
       ('Lesly','Cronje','LesC@gmail.com','Clerk');
       ('Gideon','Maduku','m@gmail.com','Accountant');


CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    product_name varchar(100),
    description varchar(300),
    buying_price NUMERIC

);
INSERT INTO products(product_name, description, buying_price)
VALUES('Harley Davidson Chopper','This replica features working kickstand, front suspension, gear-shift lever','150.75');
      ('Classic Car','Turnable front wheels, steering function','550.75');
      ('Sports car','Turnable front wheels, steering function','700.60');


CREATE TABLE payments;(
    id SERIAL PRIMARY KEY,
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY(customer_id) INTEGER REFERENCES customers(id)
    amount NUMERIC,

);
INSERT INTO payments(payment_date, amount,customer_id)
VALUES('01-09-2018', '150.75','1');
      ('03-09-2018', '150.75','5');
      ('03-09-2018', '700.60','4');

CREATE TABLE orders;(
    id SERIAL PRIMARY KEY,
    date_required DATE,
    date_shipped  DATE,
    status varchar(20)
    FOREIGN KEY(fulfilled_by_employee_id) INTEGER REFERENCES employees(id),
    FOREIGN KEY(product_id) INTEGER REFERENCES products(id) --REFERENCES clause to define a foreign key constraint--)

);
INSERT INTO orders(date_required,date_shipped,status,product_id,payment_id,fullfilled_by_employeeid)
VALUES ('05-09-2018',NULL,'NOT SHIPPED','1','1','2');
       ('04-09-2018','03-09-2018','Shipped','1','2','2');
       ('06-09-2018',NULL,'Not shipped','3','3','3');

--PART 2: QUERYING DATABASE
SELECT * FROM customers;

-- Select only column with first_name and last_name as name on customers table
SELECT first_name || ' ' || last_name AS name FROM customers;

-- Show the name of the customer whose customer_id is 1
SELECT first_name || ' ' || last_name AS name FROM customers WHERE customer_id=2;

-- DELETE the record from customers table for customer 2 (customer_id=2) my list starts from the number two so i deleted my third customer_id as i am taking it as my second customer_id.
DELETE FROM customers WHERE id=2;

-- UPDATE the record for customer_id = 1 on the customer table so that the name is "Lerato Mabitso"
UPDATE customers set first_name = 'Lerato', last_name = 'Mabitso' WHERE id=1;

-- Select all unique statuses from the orders table and get a count of the number of orders for each unique status
SELECT DISTINCT status, COUNT(DISTINCT status) FROM orders GROUP BY status;

-- Return the MAXIMUM payment made on the payments table.
SELECT MAX(amount) FROM payments;

-- Select all customers from the customers table, sorted by country column in ascending order
SELECT * FROM customers ORDER BY country ASC;
-- Select all customers from the customers table, sorted by country column in descending order
SELECT * FROM customers ORDER BY country DESC;

 --Select all products with a price BETWEEN R100 and R600.
SELECT * FROM products WHERE buying_price BETWEEN 100 AND 600;

--Select all fields from “Customers” where country is “Germany” AND city is “Berlin”.
SELECT * FROM customers WHERE country = 'Germany' AND city = 'JBerlin';

--Select all fields from “Customers” where city is “Cape Town” OR “Durban”.
SELECT * FROM customers  WHERE city = 'Cape Town' OR city = 'Durban';

--Select all records from Products where the Price is GREATER than R500.
SELECT * FROM products WHERE buying_price >500;

--Return the sum of the Amounts on the Payments table.
SELECT SUM(amount) FROM payments;

--Count the number of shipped orders in the Orders table.
SELECT COUNT(status) FROM orders WHERE status='Shipped';

--Return the average price of all Products, in Rands and in Dollars (assume the exchange rate is R12 to the Dollar).
SELECT AVG(buying_price) AS Rand, AVG(buying_price/12) AS DOLLARS FROM products;

--Using INNER JOIN create a query that selects all Payments with Customer information.
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customers.gender,
    customers.address,
    customers.phone,
    customers.email,
    customers.city,
    customers.country,
    payments.payment_date,
    payments.amount
FROM
    customers
INNER JOIN payments ON customers.customer_id = payments.customerid;

-- Select all products that have turnable front wheels.
SELECT * FROM products WHERE description LIKE 'Turnable front wheels%';

