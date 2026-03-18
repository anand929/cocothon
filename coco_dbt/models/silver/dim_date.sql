{{
    config(
        materialized='table',
        database='COCO_DB',
        schema='SILVER'
    )
}}

SELECT DISTINCT
    SHA2(CAST(orderdate AS VARCHAR), 256) AS date_sk,
    orderdate,
    qtr_id,
    month_id,
    year_id
FROM {{ ref('sales_data') }}
WHERE orderdate IS NOT NULL
