{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

{%- set create_semantic_view_sql -%}
CREATE OR REPLACE SEMANTIC VIEW COCO_DB.GOLD.SV_FACT_SALES
    TABLES (
        fact_sales AS COCO_DB.SILVER.FACT_SALES
            PRIMARY KEY (sales_sk)
            COMMENT = 'Sales fact table',
        dim_product AS COCO_DB.SILVER.DIM_PRODUCT
            PRIMARY KEY (product_sk)
            COMMENT = 'Product dimension table',
        dim_customer AS COCO_DB.SILVER.DIM_CUSTOMER
            PRIMARY KEY (customer_sk)
            COMMENT = 'Customer dimension table',
        dim_date AS COCO_DB.SILVER.DIM_DATE
            PRIMARY KEY (date_sk)
            COMMENT = 'Date dimension table',
        dim_order_status AS COCO_DB.SILVER.DIM_ORDER_STATUS
            PRIMARY KEY (order_status_sk)
            COMMENT = 'Order status dimension table'
    )
    RELATIONSHIPS (
        sales_to_product AS
            fact_sales (product_sk) REFERENCES dim_product,
        sales_to_customer AS
            fact_sales (customer_sk) REFERENCES dim_customer,
        sales_to_date AS
            fact_sales (date_sk) REFERENCES dim_date,
        sales_to_order_status AS
            fact_sales (order_status_sk) REFERENCES dim_order_status
    )
    FACTS (
        fact_sales.quantityordered AS quantityordered
            COMMENT = 'Quantity ordered',
        fact_sales.priceeach AS priceeach
            COMMENT = 'Price per unit',
        fact_sales.sales AS sales
            COMMENT = 'Total sales amount'
    )
    DIMENSIONS (
        fact_sales.sales_sk AS sales_sk
            COMMENT = 'Sales surrogate key',
        fact_sales.ordernumber AS ordernumber
            COMMENT = 'Order number',
        fact_sales.orderlinenumber AS orderlinenumber
            COMMENT = 'Order line number',
        dim_product.productcode AS productcode
            COMMENT = 'Product code',
        dim_product.productline AS productline
            COMMENT = 'Product line',
        dim_customer.customername AS customername
            COMMENT = 'Customer name',
        dim_customer.country AS country
            COMMENT = 'Customer country',
        dim_customer.city AS city
            COMMENT = 'Customer city',
        dim_date.orderdate AS orderdate
            COMMENT = 'Order date',
        dim_date.year_id AS year_id
            COMMENT = 'Year',
        dim_date.qtr_id AS qtr_id
            COMMENT = 'Quarter',
        dim_order_status.status AS status
            COMMENT = 'Order status',
        dim_order_status.dealsize AS dealsize
            COMMENT = 'Deal size'
    )
    METRICS (
        fact_sales.total_sales AS SUM(sales)
            COMMENT = 'Total sales revenue',
        fact_sales.total_quantity AS SUM(quantityordered)
            COMMENT = 'Total quantity ordered',
        fact_sales.avg_price AS AVG(priceeach)
            COMMENT = 'Average price per unit',
        fact_sales.order_count AS COUNT(DISTINCT ordernumber)
            COMMENT = 'Count of distinct orders'
    )
    COMMENT = 'Semantic view for sales fact with dimension relationships'
{%- endset -%}

SELECT '{{ create_semantic_view_sql | replace("'", "''") }}' AS semantic_view_ddl
