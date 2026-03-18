

SELECT
    $1:ORDERNUMBER::VARCHAR AS ordernumber,
    $1:QUANTITYORDERED::VARCHAR AS quantityordered,
    $1:PRICEEACH::VARCHAR AS priceeach,
    $1:ORDERLINENUMBER::VARCHAR AS orderlinenumber,
    $1:SALES::VARCHAR AS sales,
    $1:ORDERDATE::VARCHAR AS orderdate,
    $1:STATUS::VARCHAR AS status,
    $1:QTR_ID::VARCHAR AS qtr_id,
    $1:MONTH_ID::VARCHAR AS month_id,
    $1:YEAR_ID::VARCHAR AS year_id,
    $1:PRODUCTLINE::VARCHAR AS productline,
    $1:MSRP::VARCHAR AS msrp,
    $1:PRODUCTCODE::VARCHAR AS productcode,
    $1:CUSTOMERNAME::VARCHAR AS customername,
    $1:PHONE::VARCHAR AS phone,
    $1:ADDRESSLINE1::VARCHAR AS addressline1,
    $1:ADDRESSLINE2::VARCHAR AS addressline2,
    $1:CITY::VARCHAR AS city,
    $1:STATE::VARCHAR AS state,
    $1:POSTALCODE::VARCHAR AS postalcode,
    $1:COUNTRY::VARCHAR AS country,
    $1:TERRITORY::VARCHAR AS territory,
    $1:CONTACTLASTNAME::VARCHAR AS contactlastname,
    $1:CONTACTFIRSTNAME::VARCHAR AS contactfirstname,
    $1:DEALSIZE::VARCHAR AS dealsize,
    'JSON' AS file_format,
    CURRENT_TIMESTAMP() AS loaded_timestamp
FROM @SOURCE_DB.PUBLIC.stage_source_data/sales_data_sample.json.gz
(FILE_FORMAT => 'coco_db.public.json_format')