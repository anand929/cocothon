# Cortex Code Instructions for COCO_DB

## Query Standards
- Always use fully qualified names: For example `COCO_DB.PUBLIC.<table_name>`
- Test queries with `LIMIT 100` before running full table scans
- Use CTEs for complex logic instead of nested subqueries
- Create the necessary objects when unavailable.

## Best Practices
- Validate SQL compiles before execution
- Include column aliases for clarity in result sets
- Add descriptive comments for complex transformations
- Use appropriate data types in comparisons (avoid implicit casting)

## Performance Guidelines
- Filter early in CTEs to reduce data volume
- Use clustering keys when available
- Avoid SELECT * in production queries - specify needed columns

## POC assumptions and work arounds for trial account limitatoins
- The files are loaded manually into the internal stage `SOURCE_DB.PUBLIC.STAGE_SOURCE_DATA`. Note that this is a snowflake `trial account limitation` and in the paid accounts this step can be automated by `cortex cli`.
- Github checkin has to be done manually as corex code does not support automated checking.

## ETL pipeline prerequisite
- **Database**: Create or replace database named - `COCO_DB`
- **Warehouse**: Create a new x-small warehouse - `VW_COCO`. Skip this step if object exist.
- **Database Context**: Set the database contex as below-
    - *Database*: `COCO_DB`
    - *Schema*: `PUBLIC`
    - *Warehouse*: `VW_COCO`
    - *Role*: `ACCOUNTADMIN`
- **File format**: Under current context, based on files available in internal stage `SOURCE_DB.PUBLIC.STAGE_SOURCE_DATA`,identify and create different file formats required for processing. In case of `CSV` file format consider first row as header row for deriving column names.
- **Schema**: Create 3 schemas under database coco_db - `BRONZE`, `SILVER`, `GOLD`.
- **RBAC setup**: Skip this step if ETL_USER already exists.
    - Create role `ETL_USER` if it does not exist. 
    - Assign `ETL_USER` below mentioned privileges and execute them under single batch -
        - `USAGE` on all the current and future schemas on `SOURCE_DB` AND `COCO_DB`
        - `USAGE` on warehouse `VW_COCO`
        - `USAGE` and `READ` on different file formats under `SOURCE_DB`
        - `select`, `create`, `delete`, `modify`, `update` on existing and future TABLES, VIEWS and SEMANTIC VIEWS under COCO_DB
    - Assigne ETL_USER role to USERADMIN and current user.

## dbt project setup
- Initialize a new dbt project named: _`coco_dbt`_ within Cocothon folder. Use the role `ETL_USER` for this project
and current account and current user details. Replace all the environment variables with actual values for current context.

## Bronze layer processing
- Create a new folder _bronze_ under models folder and create all the files for subsequent prompts under current heading - Bronze layer processing
-create a `sources.yml` file under bronze folder and create the entry for `source_db.public.stage_source_data`.
- Refer the `source.yml` file and create one dbt model corresponding to each file available in the internal stage. Name of the model should be filename suffixed by file format. These models should create respective tables under coco_db.bronze schema when executed. In all these newely created models add two columns - `FILE_FORMAT` and `CURRENT TIMESTAMP` as Loaded_timestamp. Make sure that any Jinja function does not introduce any whitespace or newline character and remove them in case it is introduced.
- Create or update a view model named `V_SALES_DATA` in the bronze folder with below transformations -
    - Identify and explicitly `TYPE CAST` the columns to appropriate data types
    - Cleanse and format `PHONE` number to format `+XX XXX-XXX-XXXX`. +XX is the country code.
    - `UNION` the `SALES_DATA_SAMPLE_*` models.
- create a dbt test on SALES_DATA model to check the uniqueness on the combination of columns ORDERNUMBER and ORDERLINENUMBER

## Silver layer processing
- Create a new folder _silver_ under models folder and create all the files for subsequent prompts under current heading - Silver layer processing
- Identify if the column is a dimension or fact attribute in coco_db.bronze.v_sample_data.
- Create one model per table under silver schema. Generate hash 256 of the column to be used as Surrogate_key in all dimension and fact table.

## Gold layer processing
- Create a new folder _gold_ under models folder and create all the files for subsequent prompts under current heading - Gold layer processing. Skip this step if the folder already exists.
- Create or modify a view dbt model corresponding to each table created in previous step of silver layer processing and give meaningful names to the columns. Name of the models should start with 'v_'

## dbt project execution
- build the complete coco_dbt dbt project.
- Validate data quality by running row counts and null checks across COCO_DB.BRONZE, COCO_DB.SILVER, and COCO_DB.GOLD layers
