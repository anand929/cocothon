{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

SELECT
    DATE_SK AS DATE_KEY,
    ORDERDATE AS ORDER_DATE,
    QTR_ID AS QUARTER_NUMBER,
    MONTH_ID AS MONTH_NUMBER,
    YEAR_ID AS YEAR_NUMBER
FROM {{ ref('dim_date') }}
