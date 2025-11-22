-- Total revenue generated
SELECT SUM(total_amount) AS "Total revenue"
FROM orders;

-- Top 5 best selling products (by quantity)
SELECT p.title AS "Book Title", SUM(oi.quantity) AS "Total Sold"
FROM product AS p
JOIN order_items AS oi ON p.product_id = oi.product_id
GROUP BY p.title
ORDER BY "Total Sold" DESC
LIMIT 5;
    
-- Top 5 revenue generating products 
SELECT p.title "Book Title", SUM(oi.price_at_purchase * oi.quantity) "Revenue Generated"
FROM product AS p
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY p.title
ORDER BY "Revenue Generated" DESC
LIMIT 5;

-- Products with less stocks(less than 10 units)
SELECT title "Book Title", stock_quantity "Quantity"
FROM product
WHERE stock_quantity < 10
ORDER BY stock_quantity;

-- Total number of customers
SELECT COUNT(customer_id)
FROM customer;

-- Customers who placed the most orders
SELECT c.customer_id AS "Customer ID",
c.name AS "Customer Name", 
COUNT(o.order_id) AS "Order Count"
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY "Order Count" DESC
LIMIT 5;

-- Sales per month
SELECT DATE_TRUNC('month', order_date)  AS "Month",
        SUM(total_amount) AS "Sales"
        FROM orders
        GROUP BY "Month"
        ORDER BY "Month";

-- Best selling authors
SELECT a.author_name, SUM(oi.quantity) AS "Books sold"
FROM order_items oi
JOIN product_author pa ON pa.product_id = oi.product_id
JOIN author a ON a.author_id = pa.author_id
GROUP BY a.author_name
ORDER BY "Books sold" DESC
LIMIT 5;

-- Sales by category
SELECT cat.category_name AS "Category", SUM(oi.quantity * oi.price_at_purchase) AS "Sales"
FROM order_items oi
JOIN product_category pcat ON pcat.product_id = oi.product_id
JOIN category cat ON cat.category_id = pcat.category_id
GROUP BY cat.category_name
ORDER BY "Sales" DESC;

-- No. of orders by each shipping carrier
SELECT carrier "Logistics company", COUNT(order_id) "Order Counts"
FROM shipment
GROUP BY carrier
ORDER BY "Order Counts" DESC;

-- Pending orders
SELECT customer_id, order_id, total_amount
FROM orders
WHERE status = 'Pending'
ORDER BY order_date;

-- Total successful payments
SELECT SUM(amount) AS "Successful payments"
FROM payment
WHERE status = 'paid';

-- Most popular items added to cart
SELECT p.title AS "Book title", COUNT(*) AS "Cart counts"
FROM cart_items ci
JOIN product p ON p.product_id = ci.product_id
GROUP BY p.title
ORDER BY "Cart counts" DESC
LIMIT 5;

-- Average order value
SELECT AVG(total_amount) AS "Avg. order value" FROM orders;

-- New customers added per month
SELECT DATE_TRUNC('month', created_at) AS "Month", COUNT(*) AS "New customers"
FROM customer
GROUP BY "Month"
ORDER BY "Month";

