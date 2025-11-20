
-- This procedure finds the latest cart for the customer, 
-- creates a new order, 
-- copies cart_items into order_items with current product price
-- update total_amount
-- Clears the cart

CREATE OR REPLACE PROCEDURE place_order(cust_id INT, delivery_address_id INT)
LANGUAGE plpgsql 
AS $$ 
DECLARE 
    cust_cart_id INT;
    cust_ord_id INT;
BEGIN

    -- Find customer's latest cart
    SELECT cart_id FROM cart
    INTO cust_cart_id
    WHERE customer_id = cust_id
    ORDER BY created_at 
    LIMIT 1;

    IF cust_cart_id IS NULL THEN
        RAISE EXCEPTION 'No cart found for customer %', cust_id;
    END IF;

    -- Creating new order 
    INSERT INTO orders(customer_id, total_amount, order_date, shipping_address_id, status)
    VALUES(cust_id, 0, CURRENT_DATE, delivery_address_id, 'Pending')
    RETURNING order_id INTO cust_ord_id;

    -- Copy cart items to order items
    INSERT INTO order_items(order_id, product_id, quantity, price_at_purchase)
    SELECT ci.cust_ord_id, ci.product_id, quantity, p.price
    FROM cart_items ci
    JOIN product p ON p.product_id = ci.product_id
    WHERE ci.cart_id = cust_cart_id;

    -- calculate total amount and update it in the order
    UPDATE orders
    SET total_amount = (
        SELECT COALESCE(SUM(quantity*price_at_purchase), 0)
        FROM order_items
        WHERE order_id = cust_ord_id
    )
    WHERE order_id = cust_ord_id;

    -- Clear cart
    DELETE FROM cart_items
    WHERE cart_id = cust_cart_id;
    DELETE FROM cart
    WHERE cart_id = cust_cart_id;

END;
$$;



-- Calling the procedure
-- CALL place_order(4, 7);