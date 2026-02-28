/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
*/

IF OBJECT_ID('bronze.customers', 'U') IS NOT NULL
    DROP TABLE bronze.customers;
GO

CREATE TABLE bronze.customers (
    customer_id     VARCHAR(50),
    created_at      VARCHAR(50),
    first_name      NVARCHAR(255),
    last_name       NVARCHAR(255),
    email           VARCHAR(255),
    phone           VARCHAR(100),
    email_opt_in    VARCHAR(10),
    sms_opt_in      VARCHAR(10),
    call_opt_in     VARCHAR(10)
);
GO

IF OBJECT_ID('bronze.items', 'U') IS NOT NULL
    DROP TABLE bronze.items;
GO

CREATE TABLE bronze.items (
    product_id      VARCHAR(50),
    product_name    NVARCHAR(500), 
    brand           NVARCHAR(255),
    category        NVARCHAR(100),
    gramm_g         VARCHAR(50),   
    unit_price      VARCHAR(50)
);
GO

IF OBJECT_ID('bronze.sales', 'U') IS NOT NULL
    DROP TABLE bronze.sales;
GO

CREATE TABLE bronze.sales (
    invoice_id      VARCHAR(100),
    customer_id     VARCHAR(50),
    invoice_date    VARCHAR(50),
    product_id      VARCHAR(50),
    quantity        VARCHAR(50),
    revenue         VARCHAR(50),
    store_id        VARCHAR(50)
);
GO
