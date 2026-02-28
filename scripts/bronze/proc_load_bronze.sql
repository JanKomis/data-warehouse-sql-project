/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Deklarace proměnných pro měření času (celkového i dílčího)
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';

        -- /////////////////////////////////////////////////////////

        -- Nahrání tabulky bronze.customers
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.customers';
        TRUNCATE TABLE bronze.customers; -- Vymaže obsah tabulky, ale ponechá její strukturu

        PRINT '>> Inserting Data Into: bronze.customers';
        BULK INSERT bronze.customers
        FROM 'C:\sql\dwh_project\customers.csv'
        WITH (
            FIRSTROW = 2, -- přeskočí první řádek s popisem sloupců
            FIELDTERMINATOR = ',', -- oddělovač polí
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
        -- konec nahrani tabulky bronze.customers

        -- /////////////////////////////////////////////////////////

        -- Nahrání tabulky bronze.items
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.items';
        TRUNCATE TABLE bronze.items; -- Vymaže obsah tabulky, ale ponechá její strukturu

        PRINT '>> Inserting Data Into: bronze.items';
        BULK INSERT bronze.items
        FROM 'C:\sql\dwh_project\items.csv'
        WITH (
            FIRSTROW = 2, -- přeskočí první řádek s popisem sloupců
            FIELDTERMINATOR = ',', -- oddělovač polí
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
        -- konec nahrani tabulky bronze.items
        
        -- /////////////////////////////////////////////////////////

        -- Nahrání tabulky bronze.sales
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.sales';
        TRUNCATE TABLE bronze.sales; -- Vymaže obsah tabulky, ale ponechá její strukturu

        PRINT '>> Inserting Data Into: bronze.sales';
        BULK INSERT bronze.sales
        FROM 'C:\sql\dwh_project\sales.csv'
        WITH (
            FIRSTROW = 2, -- přeskočí první řádek s popisem sloupců
            FIELDTERMINATOR = ',', -- oddělovač polí
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
        -- konec nahrani tabulky bronze.sales

        -- /////////////////////////////////////////////////////////

        -- Výsledné shrnutí
        SET @batch_end_time = GETDATE();
        PRINT '=========================================='
        PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '=========================================='
        
    END TRY
    BEGIN CATCH
        -- Ošetření chyb (vypíše detaily, pokud BULK INSERT selže)
        PRINT '=========================================='
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================='
    END CATCH
END