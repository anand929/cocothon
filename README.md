# Snowflake cortex code powered dbt pipeline
This project establishes a multi-layered madillion data architecture (Bronze, Silver, and Gold) within Snowflake using dbt (data build tool) for all ETL processing. It is designed to process source data from internal stages into a structured, analytics-ready format.

## Architecture Overview
The project follows a modular Medallion Architecture:

### Bronze Layer 
Raw data ingestion with initial metadata (file formats and timestamps).
### Silver Layer
Cleaned and transformed data with appropriate data types and surrogate keys.
### Gold Layer
Semantic views optimized for end-user consumption and reporting.

### Prerequisites & Environment Setup
1. #### Snowflake Infrastructure
    Before running the dbt project, ensure the following objects are initialized in Snowflake:

    Database: `COCO_DB`.

    Warehouse: `VW_COCO` (Size: `X-Small`).

    Schemas: BRONZE, SILVER, and GOLD under COCO_DB.

    Internal Stage: Source data must be **manually loaded** into `SOURCE_DB.PUBLIC.STAGE_SOURCE_DATA`.

2. #### RBAC (Role-Based Access Control)
    The project uses a dedicated role, `ETL_USER`, with the following privileges:

    USAGE on SOURCE_DB and COCO_DB (all current/future schemas).

    USAGE on VW_COCO warehouse.

    READ access to file formats in SOURCE_DB.

    Full DML/DDL permissions (SELECT, CREATE, DELETE, MODIFY, UPDATE) on tables and views in COCO_DB.

## Development Standards
### Query Standards

#### Fully Qualified Names
Always use `<DATABASE>.<SCHEMA>.<TABLE>` (e.g., COCO_DB.PUBLIC.MY_TABLE).

#### Complexity Management
Use Common Table Expressions (CTEs) instead of nested subqueries.

#### Performance
Filter data early in CTEs and avoid SELECT * in production code.

### dbt Project Configuration

**Project Name:** `coco_dbt`

**Role:** `ETL_USER`

**File Naming:** Models in the Bronze layer are named using the format filename_fileformat.

**Repository structure**
```
cocothon/
├── coco_dbt/
│   ├── analyses/
│   ├── logs/
│   ├── macros/
│   ├── models/
│   │   ├── bronze/
│   │   │   ├── schema.yml
│   │   │   ├── sources.yml
│   │   ├── silver/
│   │   └── gold/
│   ├── seeds/
│   ├── snapshots/
│   ├── target/
│   ├── tests/
│   ├── dbt_project.yml
│   ├── profiles.yml
└── README.md
```

## Processing Layers
### Bronze Layer

**Sources:** Defined in models/bronze/sources.yml referencing the internal stage.

**Metadata:** Every model includes `FILE_FORMAT` and `LOADED_TIMESTAMP`.

### Transformations

    Explicit type casting.

    Phone number formatting: +XX XXX-XXX-XXXX.

    Unification of sample data via UNION.

### Silver Layer
Data is categorized into Dimension and Fact attributes.

**Surrogate Keys:** Generated using SHA256 hashing of identifying columns.

### Gold Layer
Creation of Semantic Views corresponding to each Silver layer table for streamlined reporting.

### Validation & Execution
To deploy and validate the pipeline, use the following commands:

**Build Project:** dbt build (Executes models, seeds, and snapshots).

**Data Quality:** Includes uniqueness tests on ORDERNUMBER and ORDERLINENUMBER in the SALES_DATA model.

**Manual Checks:** Validate row counts and null values across all three layers.

### Note
GitHub check-ins must be performed manually as automated integration is currently not supported in snowflake trial account