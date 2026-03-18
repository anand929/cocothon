
  create or replace   view COCO_DB.BRONZE.sales_data_sample
  
   as (
    

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
    phone::VARCHAR AS phone,
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
FROM COCO_DB.BRONZE.sales_data_sample_csv

UNION ALL

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
    phone::VARCHAR AS phone,
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
FROM COCO_DB.BRONZE.sales_data_sample_json
  );

