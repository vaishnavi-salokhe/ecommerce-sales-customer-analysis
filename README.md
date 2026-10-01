# E-Commerce Sales & Customer Analysis

## Project Overview

This project analyzes an e-commerce dataset using MySQL and SQL to understand sales performance, customer behavior, product categories, seller performance, payments, and delivery operations.

The analysis is structured around business questions and uses SQL to convert transactional data into metrics and insights that can support business decision-making.

## Business Questions

### Sales & Product Performance
1. How has sales performance changed over time?
2. Which product category generates the most revenue?
3. Which product categories generate high-value orders?
4. How does monthly order volume and revenue change over time?

### Customer Analysis
5. How are customers distributed across different regions?
6. How many customers placed more than one order?
7. Do repeat customers contribute disproportionately to overall revenue?
8. How is revenue distributed across customer states?

### Payment Analysis
9. What payment methods are most commonly used?
10. How do order counts and total payment values vary by payment type?

### Seller Performance
11. Which sellers generate the highest revenue?
12. How much revenue is contributed by the top sellers compared with overall revenue?
13. How are sellers distributed across different states?

### Delivery Performance
14. What is the average delivery time?
15. How many orders were delivered late?
16. What is the late-delivery rate?
17. Which customer regions experience higher delivery delays?
18. Which states show both strong sales and higher delivery risk?

## SQL Analysis Performed

The project uses:

- SQL Joins
- Common Table Expressions (CTEs)
- Subqueries
- Conditional Aggregation
- GROUP BY and HAVING
- Date and Time Functions
- Aggregate Functions
- CASE Statements
- Window Functions
- DENSE_RANK
- LAG
- Moving Averages
- Cumulative Calculations
- Revenue and KPI calculations
- Customer and seller segmentation

## Key Areas Analyzed

- Monthly revenue and order trends
- Product category revenue
- Average order value by category
- Customer geography
- Repeat customer behavior
- Repeat customer revenue contribution
- Payment behavior
- Seller revenue and ranking
- Delivery time and late-delivery performance
- Revenue by customer state
- Sales and delivery risk by state

## What I Learned

Through this project, I strengthened my ability to translate business questions into SQL queries and analyze transactional data from multiple related tables.

Key learning areas included:

- Writing SQL queries for business-oriented questions
- Joining multiple tables to create meaningful analysis
- Using CTEs and subqueries to structure complex analysis
- Applying window functions for ranking, trends, and comparisons
- Calculating business KPIs such as revenue, order volume, average order value, and delivery rates
- Analyzing customer purchasing and repeat-order behavior
- Comparing sales performance with operational delivery risk
- Interpreting SQL results from a business decision-making perspective

## Tools

- MySQL
- MySQL Workbench
- SQL

## Project Structure

The SQL analysis is organized into separate scripts covering database setup, order analysis, sales and customer analysis, delivery and seller analysis, customer revenue analysis, and payment analysis.
