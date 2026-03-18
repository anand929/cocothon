

SELECT
    $1::VARCHAR AS ordernumber,
    $2::VARCHAR AS quantityordered,
    $3::VARCHAR AS priceeach,
    $4::VARCHAR AS orderlinenumber,
    $5::VARCHAR AS sales,
    $6::VARCHAR AS orderdate,
    $7::VARCHAR AS status,
    $8::VARCHAR AS qtr_id,
    $9::VARCHAR AS month_id,
    $10::VARCHAR AS year_id,
    $11::VARCHAR AS productline,
    $12::VARCHAR AS msrp,
    $13::VARCHAR AS productcode,
    $14::VARCHAR AS customername,
    $15::VARCHAR AS phone,
    $16::VARCHAR AS addressline1,
    $17::VARCHAR AS addressline2,
    $18::VARCHAR AS city,
    $19::VARCHAR AS state,
    $20::VARCHAR AS postalcode,
    $21::VARCHAR AS country,
    $22::VARCHAR AS territory,
    $23::VARCHAR AS contactlastname,
    $24::VARCHAR AS contactfirstname,
    $25::VARCHAR AS dealsize,
    'CSV' AS file_format,
    CURRENT_TIMESTAMP() AS loaded_timestamp
FROM @SOURCE_DB.PUBLIC.stage_source_data/sales_data_sample.csv.gz
(FILE_FORMAT => 'coco_db.public.csv_format')