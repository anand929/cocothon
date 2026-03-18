{{
    config(
        materialized='table',
        database='COCO_DB',
        schema='SILVER'
    )
}}

SELECT DISTINCT
    SHA2(status || dealsize, 256) AS order_status_sk,
    status,
    dealsize
FROM {{ ref('sales_data') }}
