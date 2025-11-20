
-- product table
CREATE TABLE product(
    product_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    publisher TEXT,
    publisher_date DATE,
    price INT NOT NULL,
    stock_quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- author table
CREATE TABLE author(
    author_id SERIAL PRIMARY KEY,
    author_name TEXT NOT NULL
);

-- product_author table
CREATE TABLE product_author(
    product_id INT NOT NULL,
    author_id INT NOT NULL,    

    PRIMARY KEY(product_id, author_id),

    FOREIGN KEY(product_id) REFERENCES product(product_id)
        ON DELETE CASCADE,
    FOREIGN KEY(author_id) REFERENCES author(author_id)
        ON DELETE CASCADE
);

-- product_image table
CREATE TABLE product_image(
    image_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    image_url TEXT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- category table
CREATE TABLE category(
    category_id SERIAL PRIMARY KEY,
    category_name TEXT
);

-- product_category table
CREATE TABLE product_category(
    product_id INT NOT NULL,
    category_id INT NOT NULL,

    PRIMARY KEY(product_id, category_id),

    FOREIGN KEY(product_id) REFERENCES product(product_id),
    FOREIGN KEY(category_id) REFERENCES category(category_id)
);

-- Customer table
CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- cart table
CREATE TABLE cart(
    cart_id SERIAL PRIMARY KEY,
    customer_id INT,
    created_at TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- cart_items table
CREATE TABLE cart_items(
    cart_items_id SERIAL PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY(cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY(product_id) REFERENCES product(product_id)
);

-- address table
CREATE TABLE address(
    address_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    city TEXT,
    state TEXT,
    country TEXT,
    postal_code TEXT,

    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

-- orders table
CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY, 
    customer_id INT,
    total_amount INT NOT NULL,
    order_date DATE NOT NULL,
    shipping_address_id INT NOT NULL,
    status TEXT NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id)
);

-- order_items table
CREATE TABLE order_items(
    order_items_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_at_purchase INT,

    FOREIGN KEY(product_id) REFERENCES product(product_id),
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- shipment table 
CREATE TABLE shipment(
    shipment_id SERIAL PRIMARY KEY, 
    order_id INT NOT NULL,
    carrier TEXT,
    tracking_number TEXT,
    status TEXT,
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- payment table
CREATE TABLE payment(
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    amount INT NOT NULL,
    payment_method TEXT NOT NULL,
    status TEXT NOT NULL,

    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- pending orders
SELECT customer_id, order_id, total_amount
FROM order
WHERE status = "Pending"
ORDER BY order_date;