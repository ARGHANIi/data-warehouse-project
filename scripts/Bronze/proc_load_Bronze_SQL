/*
===================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===================================================================================
Script Purpose: 
This stored prosedure loads data into 'Bronze' schema from external CSV files.
It performs the following actions:
	-Truncating tables before loading data
	-Use the 'Bulk Insert' command to load the data from csv file
	into Bronze layer tables.

Parameters:
	None.
	This stored prosedure does not any parameters or return any values.

Usage Example:
	EXEC Bronze.load_Bronze;
===================================================================================
*/

CREATE OR ALTER PROCEDURE Bronze.load_Bronze AS
BEGIN
	DECLARE @start_time Datetime , @end_time Datetime , @batch_start_time Datetime ,@batch_end_time Datetime;

	BEGIN TRY

		set @batch_start_time = GETDATE();
		PRINT '=======================================';
		PRINT 'Loading Bronze Layer ';
		PRINT '=======================================';

		PRINT '---------------------------------------';
		PRINT 'Loading crm Tables';
		PRINT '---------------------------------------';

		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.crm_cust_info';
		Truncate Table Bronze.crm_cust_info;

		Print '>>Inserting Data Into: Bronze.crm_cust_info';
		Bulk Insert Bronze.crm_cust_info 
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'

		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.crm_prd_info';
		Truncate Table Bronze.crm_prd_info;

		Print '>>Inserting Data Into: Bronze.crm_prd_info';
		Bulk Insert Bronze.crm_prd_info 
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'


		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.crm_sales_details';
		Truncate Table Bronze.crm_sales_details;

		Print '>>Inserting Data Into: Bronze.crm_sales_details';
		Bulk Insert Bronze.crm_sales_details 
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'


		PRINT '---------------------------------------';
		PRINT 'Loading erp Tables';
		PRINT '---------------------------------------';


		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.erp_cust_az12';
		Truncate Table Bronze.erp_cust_az12;

		Print '>>Inserting Data Into: Bronze.erp_cust_az12';
		Bulk Insert Bronze.erp_cust_az12 
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'


		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.erp_loc_a101';
		Truncate Table Bronze.erp_loc_a101;

		Print '>>Inserting Data Into: Bronze.erp_loc_a101';
		Bulk Insert Bronze.erp_loc_a101
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'


		Set @start_time = GETDATE();
		Print '>>Truncating Table: Bronze.erp_px_cat_g1v2';
		Truncate Table Bronze.erp_px_cat_g1v2;

		Print '>>Inserting Data Into: Bronze.erp_px_cat_g1v2';
		Bulk Insert Bronze.erp_px_cat_g1v2
		from 'C:\Users\alli\Documents\SQL Server Management Studio\Data With Baraa , Project Files\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		Set @end_time = GETDATE();
		PRINT '>> Load Duration:'+ Cast(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+ 'seconds';
		PRINT '--------------------------------'

		set @batch_end_time = GETDATE();
		PRINT '============================================='
		PRINT 'Loading Bronze Layer is Complited';
		PRINT ' --Tatal Load Duration:'+ Cast(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR);
		PRINT '============================================='
	END TRY

	BEGIN CATCH 
	PRINT '============================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '============================================'
	END CATCH 
END

