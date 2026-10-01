USE ecommerce;

-- =====================================================
-- 10. REPEAT CUSTOMER REVENUE CONTRIBUTION
-- Business Question:
-- Do repeat customers contribute disproportionately
-- to overall revenue?
-- =====================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),

customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN co.order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,

    COUNT(*) AS customers,
    ROUND(SUM(cr.revenue), 2) AS revenue,
    ROUND(AVG(cr.revenue), 2) AS avg_customer_revenue

FROM customer_orders co
JOIN customer_revenue cr
    ON co.customer_unique_id = cr.customer_unique_id

GROUP BY customer_type;


-- =====================================================
-- 11. CATEGORY AVERAGE ORDER VALUE
-- Business Question:
-- Which product categories generate higher-value orders?
-- =====================================================

SELECT
    p.product_category,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT oi.order_id),
        2
    ) AS revenue_per_order

FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id

GROUP BY p.product_category

HAVING COUNT(DISTINCT oi.order_id) >= 500

ORDER BY revenue_per_order DESC;


-- =====================================================
-- 12. REVENUE BY CUSTOMER STATE
-- Business Question:
-- Which geographic markets generate the most revenue?
-- =====================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(oi.price), 2) AS revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order

FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_state

HAVING COUNT(DISTINCT o.order_id) >= 500

ORDER BY revenue DESC;


-- =====================================================
-- 13. SALES + DELIVERY RISK BY STATE
-- Business Question:
-- Which major markets combine high sales volume
-- with relatively high delivery delays?
-- =====================================================

SELECT
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(SUM(oi.price), 2) AS revenue,

    SUM(
        o.order_delivered_customer_date >
        o.order_estimated_delivery_date
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            o.order_delivered_customer_date >
            o.order_estimated_delivery_date
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_rate

FROM customers c

JOIN orders o
    ON c.customer_id = o.customer_id

JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY c.customer_state

HAVING COUNT(DISTINCT o.order_id) >= 1000

ORDER BY late_delivery_rate DESC;