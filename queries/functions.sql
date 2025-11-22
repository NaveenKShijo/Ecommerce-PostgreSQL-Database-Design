
-- Get total value of a cart
CREATE OR REPLACE FUNCTION cart_value(cart_ident INT)
RETURNS INT AS $$
DECLARE 
    total_value INT;-- local variable to store the result
BEGIN
    SELECT COALESCE(SUM(ci.quantity*p.price), 0)
    INTO total_value
    FROM cart_items ci 
    JOIN product p ON p.product_id = ci.product_id
    WHERE ci.cart_id = cart_ident;

    RETURN total_value;
END;
$$ LANGUAGE plpgsql;




-- Function to get the total amount spent by a customer
CREATE OR REPLACE FUNCTION customer_lifetime_value(c_id INT)
RETURNS INT AS $$
DECLARE 
	ltv INT;
BEGIN
    SELECT COALESCE(SUM(total_amount), 0)
    INTO ltv
    FROM orders
    WHERE o.customer_id = c_id;
    RETURN ltv;
END;
$$ LANGUAGE plpgsql;



-- Get the product's current stock as a function
CREATE OR REPLACE FUNCTION product_stock(pro_id INT)
RETURNS INT AS $$
DECLARE 
	stock INT;
BEGIN
    SELECT stock_quantity 
    INTO stock
    FROM product
    WHERE product_id = pro_id;
    RETURN stock;
END;
$$ LANGUAGE plpgsql;
