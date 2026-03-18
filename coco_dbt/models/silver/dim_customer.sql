{{
    config(
        materialized='table',
        database='COCO_DB',
        schema='SILVER'
    )
}}

SELECT DISTINCT
    SHA2(customername || COALESCE(phone, '') || COALESCE(city, '') || COALESCE(country, ''), 256) AS customer_sk,
    customername,
    phone,
    addressline1,
    addressline2,
    city,
    state,
    postalcode,
    country,
    territory,
    contactlastname,
    contactfirstname
FROM {{ ref('sales_data') }}
