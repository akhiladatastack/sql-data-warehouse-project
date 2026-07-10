
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE BRONZE.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 

    BEGIN TRY
    	SET @batch_start_time = GETDATE();

        PRINT '======================================';
        PRINT 'Loading data into Bronze tables...';
        PRINT '======================================';
    
        PRINT '--------------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '--------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.crm_cust_info'; 
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>INSERTING DATA INTO: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info 
        FROM '/datasets/source_crm/cust_info.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.crm_cust_info;
        -- select * from bronze.crm_cust_info;

        set @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.crm_prd_info'; 
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>>INSERTING DATA INTO: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info 
        FROM '/datasets/source_crm/prd_info.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.crm_prd_info;
        -- select * from bronze.crm_prd_info;

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>>INSERTING DATA INTO: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details 
        FROM '/datasets/source_crm/sales_details.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.crm_sales_details;
        -- select * from bronze.crm_sales_details ;
        PRINT '--------------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '--------------------------------------';
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>>INSERTING DATA INTO: bronze.erp_cust_az12';    
        BULK INSERT bronze.erp_cust_az12 
        FROM '/datasets/source_erp/cust_az12.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.erp_cust_az12;
        -- select * from bronze.erp_cust_az12;
    
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>>INSERTING DATA INTO: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101 
        FROM '/datasets/source_erp/loc_a101.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.erp_loc_a101;
        -- select * from bronze.erp_loc_a101;

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table:bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>>INSERTING DATA INTO: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2 
        FROM '/datasets/source_erp/px_cat_g1v2.csv'
        WITH (
            FIELDTERMINATOR = ',',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
        select count(*) from bronze.erp_px_cat_g1v2;
        -- select * from bronze.erp_px_cat_g1v2;
        SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while loading data into Bronze tables.';
        PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
    END CATCH    
END

