CREATE DATABASE ecommerce_project;

USE ecommerce_project;
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
signup_date DATE
);

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
category VARCHAR(50),
price INT
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE
);

CREATE TABLE order_details(
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT
);

SELECT * FROM customers;

SELECT SUM(p.price * od.quantity) AS total_revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id;

SELECT p.product_name,
SUM(od.quantity) AS total_sales
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

SELECT p.category,
SUM(p.price * od.quantity) AS revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT c.customer_name,
SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;