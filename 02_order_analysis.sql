SELECT COUNT(*) AS customer_count FROM customers;

SELECT COUNT(*) AS order_count FROM orders;

SELECT COUNT(*) AS order_item_count FROM order_items;

SELECT COUNT(*) AS payment_count FROM payments;

SELECT COUNT(*) AS product_count FROM products;

SELECT COUNT(*) AS seller_count FROM sellers;

-- 1. NULL checks: Customers
SELECT
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(customer_unique_id IS NULL) AS customer_unique_id_nulls,
    SUM(customer_city IS NULL) AS city_nulls,
    SUM(customer_state IS NULL) AS state_nulls
FROM customers;


-- 2. NULL checks: Orders
SELECT
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(customer_id IS NULL) AS customer_id_nulls,
    SUM(order_status IS NULL) AS status_nulls,
    SUM(order_purchase_timestamp IS NULL) AS purchase_date_nulls,
    SUM(order_delivered_customer_date IS NULL) AS delivered_date_nulls,
    SUM(order_estimated_delivery_date IS NULL) AS estimated_date_nulls
FROM orders;


-- 3. NULL checks: Order Items
SELECT
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(product_id IS NULL) AS product_id_nulls,
    SUM(seller_id IS NULL) AS seller_id_nulls,
    SUM(price IS NULL) AS price_nulls,
    SUM(freight_value IS NULL) AS freight_nulls
FROM order_items;


-- 4. NULL checks: Payments
SELECT
    SUM(order_id IS NULL) AS order_id_nulls,
    SUM(payment_type IS NULL) AS payment_type_nulls,
    SUM(payment_installments IS NULL) AS installment_nulls,
    SUM(payment_value IS NULL) AS payment_value_nulls
FROM payments;


-- 5. Duplicate checks
SELECT COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids
FROM customers;

SELECT COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_order_ids
FROM orders;

SELECT COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_product_ids
FROM products;

SELECT COUNT(*) - COUNT(DISTINCT seller_id) AS duplicate_seller_ids
FROM sellers;


-- 6. Order date range
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;


-- 7. Order status distribution
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- E-COMMERCE BUSINESS KPIs

-- 1. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- 2. Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;


-- 3. Total Revenue
SELECT ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments;


-- 4. Average Order Value
SELECT ROUND(AVG(order_value), 2) AS average_order_value
FROM (
    SELECT order_id, SUM(payment_value) AS order_value
    FROM payments
    GROUP BY order_id
) AS order_totals;


-- 5. Delivered Orders
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';


-- 6. Cancelled Orders
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'canceled';


-- 7. Cancelled Order Rate
SELECT
    ROUND(
        100.0 * SUM(order_status = 'canceled') / COUNT(*),
        2
    ) AS cancelled_order_rate
FROM orders;


-- 8. Average Items per Order
SELECT ROUND(AVG(item_count), 2) AS avg_items_per_order
FROM (
    SELECT order_id, COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
) AS order_items_count;

