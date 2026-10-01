USE ecommerce;

-- =====================================================
-- 1. MONTHLY REVENUE & ORDER TREND
-- Business Question:
-- How has sales performance changed over time?
-- =====================================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(p.payment_value), 2) AS revenue,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;


-- =====================================================
-- 2. PRODUCT CATEGORY PERFORMANCE
-- Business Question:
-- Which product categories generate the most revenue?
-- =====================================================

SELECT
    pr.product_category,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(AVG(oi.price), 2) AS avg_product_price
FROM order_items oi
JOIN products pr
    ON oi.product_id = pr.product_id
GROUP BY pr.product_category
ORDER BY product_revenue DESC;


-- =====================================================
-- 3. CUSTOMER GEOGRAPHY
-- Business Question:
-- Which states generate the most customers?
-- =====================================================

SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS customers
FROM customers
GROUP BY customer_state
ORDER BY customers DESC
LIMIT 10;


-- =====================================================
-- 4. PAYMENT BEHAVIOR
-- Business Question:
-- How do customers prefer to pay?
-- =====================================================

SELECT
    payment_type,
    COUNT(*) AS payment_transactions,
    ROUND(SUM(payment_value), 2) AS payment_value,
    ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM payments
GROUP BY payment_type
ORDER BY payment_value DESC;


-- =====================================================
-- 5. SELLER PERFORMANCE
-- Business Question:
-- Which sellers generate the most product revenue?
-- =====================================================

SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 6. DELIVERY PERFORMANCE
-- Business Question:
-- How long does delivery take, and how often are orders late?
-- =====================================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                DATE(o.order_delivered_customer_date),
                DATE(o.order_purchase_timestamp)
            )
        ), 2
    ) AS avg_delivery_days,

    SUM(
        o.order_delivered_customer_date >
        o.order_estimated_delivery_date
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            o.order_delivered_customer_date >
            o.order_estimated_delivery_date
        ) / COUNT(*),
        2
    ) AS late_delivery_rate

FROM orders o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL;