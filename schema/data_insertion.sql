-- PRODUCT
INSERT INTO product (product_id, title, description, publisher, publisher_date, price, stock_quantity)
VALUES
(1, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 'Prentice Hall', '2008-08-01', 500, 10),
(2, 'Design Patterns', 'Elements of Reusable Object-Oriented Software', 'Addison-Wesley', '1994-10-31', 650, 5),
(3, 'Refactoring', 'Improving the Design of Existing Code', 'Addison-Wesley', '1999-07-08', 550, 8),
(4, 'Introduction to Algorithms', 'CLRS algorithms textbook', 'MIT Press', '2009-07-31', 800, 4),
(5, 'Deep Learning', 'Deep learning book by Goodfellow et al.', 'MIT Press', '2016-11-18', 900, 6);


-- AUTHOR
INSERT INTO author (author_id, author_name)
VALUES
(1, 'Robert C. Martin'),
(2, 'Erich Gamma'),
(3, 'Martin Fowler'),
(4, 'Thomas H. Cormen'),
(5, 'Ian Goodfellow');


-- PRODUCT_AUTHOR (many-to-many)
INSERT INTO product_author (product_id, author_id)
VALUES
(1, 1),  -- Clean Code -> Robert C. Martin
(2, 2),  -- Design Patterns -> Erich Gamma (actually + others, but ok for sample)
(3, 3),  -- Refactoring -> Martin Fowler
(4, 4),  -- Intro to Algorithms -> Cormen
(5, 5);  -- Deep Learning -> Ian Goodfellow


-- CATEGORY
INSERT INTO category (category_id, category_name)
VALUES
(1, 'Programming'),
(2, 'Software Engineering'),
(3, 'Algorithms'),
(4, 'Machine Learning');


-- PRODUCT_CATEGORY (product ↔ category)
INSERT INTO product_category (product_id, category_id)
VALUES
(1, 1), (1, 2),      -- Clean Code: Programming, Software Engineering
(2, 1), (2, 2),      -- Design Patterns: Programming, Software Engineering
(3, 1), (3, 2),      -- Refactoring: Programming, Software Engineering
(4, 1), (4, 3),      -- CLRS: Programming, Algorithms
(5, 1), (5, 4);      -- Deep Learning: Programming, Machine Learning


-- PRODUCT_IMAGE
INSERT INTO product_image (image_id, product_id, image_url)
VALUES
(1, 1, 'https://example.com/images/clean_code_front.jpg'),
(2, 1, 'https://example.com/images/clean_code_back.jpg'),
(3, 2, 'https://example.com/images/design_patterns_front.jpg'),
(4, 3, 'https://example.com/images/refactoring_front.jpg'),
(5, 5, 'https://example.com/images/deep_learning_front.jpg');


-- CUSTOMER
INSERT INTO customer (customer_id, name, email, phone)
VALUES
(1, 'Naveen', 'naveen@example.com', '9876543210'),
(2, 'Alice', 'alice@example.com', '9123456780'),
(3, 'Bob',   'bob@example.com',   '9988776655');


-- ADDRESS
INSERT INTO address (address_id, customer_id, city, state, country, postal_code)
VALUES
(1, 1, 'Kochi',   'Kerala',   'India', '682001'),
(2, 2, 'Bengaluru','Karnataka','India', '560001'),
(3, 3, 'Chennai', 'Tamil Nadu','India', '600001');


-- CART
INSERT INTO cart (cart_id, customer_id)
VALUES
(1, 1),
(2, 2),
(3, 3);


-- CART_ITEMS
INSERT INTO cart_items (cart_items_id, cart_id, product_id, quantity)
VALUES
(1, 1, 1, 1),  -- Naveen has 1 x Clean Code
(2, 1, 3, 2),  -- Naveen has 1 x Refactoring
(3, 2, 4, 1),  -- Alice has 1 x CLRS
(4, 3, 5, 2);  -- Bob has 2 x Deep 



-- ORDERS
INSERT INTO orders (order_id, customer_id, total_amount, order_date, shipping_address_id, status)
VALUES
(1, 1, 1050, '2025-01-10', 1, 'delivered'),  -- maybe 500 + 550
(2, 2, 800,  '2025-01-11', 2, 'shipped'),    -- CLRS
(3, 3, 1800, '2025-01-12', 3, 'processing'); -- 2 x Deep Learning


-- ORDER_ITEMS
INSERT INTO order_items (order_items_id, order_id, product_id, quantity, price_at_purchase)
VALUES
(1, 1, 1, 1, 500),   -- Clean Code
(2, 1, 3, 1, 550),   -- Refactoring
(3, 2, 4, 1, 800),   -- CLRS
(4, 3, 5, 2, 900);   -- 2 x Deep Learning at 900 each


-- SHIPMENT
INSERT INTO shipment (shipment_id, order_id, carrier, tracking_number, status)
VALUES
(1, 1, 'Blue Dart', 'BD123456789IN', 'delivered'),
(2, 2, 'Delhivery', 'DL987654321IN', 'in_transit'),
(3, 3, 'India Post','IP555666777IN', 'booked');


-- PAYMENT
INSERT INTO payment (payment_id, order_id, amount, payment_method, status)
VALUES
(1, 1, 1050, 'UPI',  'paid'),
(2, 2, 800,  'Card', 'paid'),
(3, 3, 1800, 'COD',  'pending');
