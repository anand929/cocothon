{{
    config(
        materialized='view',
        database='COCO_DB',
        schema='BRONZE'
    )
}}

WITH country_codes AS (
    SELECT column1 AS country, column2 AS country_code FROM (VALUES
        ('USA', '+1'),
        ('Canada', '+1'),
        ('France', '+33'),
        ('Spain', '+34'),
        ('Australia', '+61'),
        ('UK', '+44'),
        ('Germany', '+49'),
        ('Italy', '+39'),
        ('Japan', '+81'),
        ('Singapore', '+65'),
        ('Philippines', '+63'),
        ('Denmark', '+45'),
        ('Sweden', '+46'),
        ('Finland', '+358'),
        ('Norway', '+47'),
        ('Austria', '+43'),
        ('Belgium', '+32'),
        ('Switzerland', '+41'),
        ('Ireland', '+353'),
        ('New Zealand', '+64')
    )
),

source_data AS (
    SELECT * FROM {{ ref('sales_data_sample_csv') }}
    UNION ALL
    SELECT * FROM {{ ref('sales_data_sample_json') }}
),

cleaned AS (
    SELECT
        s.*,
        cc.country_code,
        REGEXP_REPLACE(s.phone, '[^0-9]', '') AS phone_digits
    FROM source_data s
    LEFT JOIN country_codes cc ON s.country = cc.country
)

SELECT
    ordernumber::INTEGER AS ordernumber,
    quantityordered::INTEGER AS quantityordered,
    priceeach::DECIMAL(10,2) AS priceeach,
    orderlinenumber::INTEGER AS orderlinenumber,
    sales::DECIMAL(12,2) AS sales,
    TRY_TO_TIMESTAMP(orderdate, 'MM/DD/YYYY HH24:MI') AS orderdate,
    status::VARCHAR AS status,
    qtr_id::INTEGER AS qtr_id,
    month_id::INTEGER AS month_id,
    year_id::INTEGER AS year_id,
    productline::VARCHAR AS productline,
    msrp::INTEGER AS msrp,
    productcode::VARCHAR AS productcode,
    customername::VARCHAR AS customername,
    CASE
        WHEN LENGTH(phone_digits) >= 10 THEN
            COALESCE(country_code, '+1') || ' ' ||
            SUBSTRING(phone_digits, LENGTH(phone_digits) - 9, 3) || '-' ||
            SUBSTRING(phone_digits, LENGTH(phone_digits) - 6, 3) || '-' ||
            SUBSTRING(phone_digits, LENGTH(phone_digits) - 3, 4)
        ELSE phone
    END::VARCHAR AS phone,
    addressline1::VARCHAR AS addressline1,
    addressline2::VARCHAR AS addressline2,
    city::VARCHAR AS city,
    state::VARCHAR AS state,
    postalcode::VARCHAR AS postalcode,
    country::VARCHAR AS country,
    territory::VARCHAR AS territory,
    contactlastname::VARCHAR AS contactlastname,
    contactfirstname::VARCHAR AS contactfirstname,
    dealsize::VARCHAR AS dealsize,
    file_format::VARCHAR AS file_format,
    loaded_timestamp::TIMESTAMP_NTZ AS loaded_timestamp
FROM cleaned
