{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='GOLD'
    )
}}

{%- set create_semantic_view_sql -%}
CREATE OR REPLACE SEMANTIC VIEW COCO_DB.GOLD.SV_DIM_DATE
    TABLES (
        dim_date AS COCO_DB.SILVER.DIM_DATE
            PRIMARY KEY (date_sk)
            COMMENT = 'Date dimension table'
    )
    DIMENSIONS (
        dim_date.date_sk AS date_sk
            COMMENT = 'Date surrogate key',
        dim_date.orderdate AS orderdate
            COMMENT = 'Order date',
        dim_date.qtr_id AS qtr_id
            COMMENT = 'Quarter identifier',
        dim_date.month_id AS month_id
            COMMENT = 'Month identifier',
        dim_date.year_id AS year_id
            COMMENT = 'Year identifier'
    )
    METRICS (
        dim_date.date_count AS COUNT(DISTINCT orderdate)
            COMMENT = 'Count of distinct dates'
    )
    COMMENT = 'Semantic view for date dimension'
{%- endset -%}

SELECT '{{ create_semantic_view_sql | replace("'", "''") }}' AS semantic_view_ddl
