{{
    config(
        materialized='table',
        database='COCO_DB',
        schema='SILVER'
    )
}}

SELECT
    SHA2(CAST(ordernumber AS VARCHAR) || '-' || CAST(orderlinenumber AS VARCHAR), 256) AS sales_sk,
    ordernumber,
    orderlinenumber,
    SHA2(productcode, 256) AS product_sk,
    SHA2(customername || COALESCE(phone, '') || COALESCE(city, '') || COALESCE(country, ''), 256) AS customer_sk,
    SHA2(CAST(orderdate AS VARCHAR), 256) AS date_sk,
    SHA2(status || dealsize, 256) AS order_status_sk,
    quantityordered,
    priceeach,
    sales
FROM {{ ref('v_sales_data') }}
