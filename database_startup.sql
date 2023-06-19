CREATE DATABASE sql_playground;



CREATE TABLE customers (
    id int NOT NULL UNIQUE AUTO_INCREMENT,
    first_name TEXT,
    last_name TEXT,
    PRIMARY KEY(id)

);

/*  CREATE CUSTOMERS   */

INSERT INTO customers (first_name, last_name) VALUES ('Talin', 'Williamson');
INSERT INTO customers (first_name, last_name) VALUES ('Emon', 'Jenkins');
INSERT INTO customers (first_name, last_name) VALUES ('Ed', 'Blaine');
INSERT INTO customers (first_name, last_name) VALUES ('Nancy', 'Coney');
INSERT INTO customers (first_name, last_name) VALUES ('Jim', 'Smith');





CREATE TABLE orders (
    id int NOT NULL UNIQUE AUTO_INCREMENT,
    order_number INT UNIQUE,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
    );


 
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10001', 1, 99.99);
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10002', 1, 150.99);
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10003', 2, 500.999);
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10004', 2, 300);
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10005', 3, 47.49);
    INSERT INTO orders (order_number, customer_id, total_amount) VALUES ('10006', 4, 199.99);









/*  QUERIES   */


/*  Select all customers that have orders   */


SELECT first_name, last_name, orders.id FROM customers INNER JOIN orders ON customers.id = orders.customer_id;


/*  Select all customers that have orders WITH ALIAS FOR orders.id  */


SELECT first_name, last_name, orders.id as order_id FROM customers INNER JOIN orders ON customers.id = orders.customer_id;



/*  Select all customers that have not ORDERED   */


SELECT first_name, last_name FROM customers WHERE id NOT IN (SELECT customer_id FROM orders);


/*  Select all customers that have not more than 1 orders   */

SELECT first_name, last_name FROM customers WHERE id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) > 1);



/* COMPUTED COLUMN EXAMPLE */

SELECT CONCAT(first_name,' ',last_name) AS Name FROM customers;


SELECT customer_id, COUNT(*) AS Count FROM orders GROUP BY customer_id;


/* GOTCHA: This query doesn't show customers with zero orders because it uses the ORDERS tab as the join*/

SELECT CONCAT(customers.first_name, ' ', customers.last_name) AS full_name, customer_id, COUNT(*) 
AS order_count FROM orders  INNER JOIN customers ON customer_id = customers.id GROUP BY customer_id;


/* RESOLUTION: */

SELECT first_name, SUM(orders.total_amount)AS total_spent, ROUND(AVG(orders.total_amount),2) AS average_spent, COUNT(orders.customer_id) AS order_count FROM customers LEFT JOIN orders ON customers.id = orders.customer_id GROUP BY customers.id;
