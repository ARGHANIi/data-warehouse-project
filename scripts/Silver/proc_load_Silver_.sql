/*
===================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===================================================================================
Script Purpose: 
This stored prosedure loads data into 'Silver' schema from Bronze layer.
It performs the following actions:
	-Truncating tables before loading data
	-Use the 'Insert Into' command to load the data from Bronze layer
	into Silver layer tables.

	Parameters:
	None.
	This stored prosedure does not any parameters or return any values.

	Usage Example:
	EXEC Silver.load_Silver;
===================================================================================
*/
CREATE OR ALTER PROCEDURE Silver.load_Silver AS
BEGIN
	DECLARE @start_time DATETIME ,@end_time DATETIME ,@batch_start_time DATETIME , @batch_end_time DATETIME

	BEGIN TRY 

		set @batch_start_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading Silver Layer';
		PRINT '==========================================';

		PRINT '------------------------------------------';
		PRINT 'Loading crm Tables';
		PRINT '------------------------------------------';

		--Loading Silver.crm_cust_info
		set @start_time = GETDATE();
		PRINT '>> Truncating Table : Silver.crm_cust_info ';
		TRUNCATE TABLE Silver.crm_cust_info ;
		PRINT '>> Inserting Data Into Table : Silver.crm_cust_info ';
		Insert Into Silver.crm_cust_info(
				cst_id,
				cst_key,
				cst_firstname,
				cst_lastname,
				cst_marital_status,
				cst_gndr,
				cst_create_date
		)
			select 
			cst_id,
			cst_key,
			Trim (cst_firstname),
			Trim (cst_lastname),
			case  Upper(Trim(cst_marital_status))
				 when 'S' then 'Single'
				 when 'M' then 'Marreid'
				 Else 'n/a'
			end cst_marital_status,--Normalize martial status values
			case Upper(Trim(cst_gndr))
				 when 'M' then 'Male'
				 when 'F' then 'Female'
				 Else 'n/a'
			end cst_gndr,--Normalize gndr values 
			cst_create_date
			from(
			select
			*,
			Row_number () over (partition by cst_id order by cst_create_date desc) as flag_last
			from Bronze.crm_cust_info 
			where cst_id is not null
			)t
			where flag_last = 1 -- Select the most recent record per customer
		set @end_time = GETDATE();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR) +'Seconds';
		PRINT '-----------------------------------------'
	

		--Loading Silver.crm_prd_info
		set @start_time = Getdate();
		PRINT '>> Truncating Table : Silver.crm_prd_info';
		TRUNCATE TABLE Silver.crm_prd_info;
		PRINT '>> Inserting Data Into Table : Silver.crm_prd_info';
		Insert Into Silver.crm_prd_info(
				prd_id,
				cat_id, 
				prd_key,
				prd_nm,
				prd_cost,
				prd_line,
				prd_start_dt,
				prd_end_dt
		)
			select
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') As cat_id,--Extract category id
			SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,     --Extract product key	
			prd_nm,
			ISNULL(prd_cost,0) As prd_cost,
			CASE UPPER(TRIM(prd_line))
				 WHEN 'M' THEN 'Mountain'
				 WHEN 'R' THEN 'Road'
				 WHEN 'S' THEN 'Other Sales'
				 WHEN 'T' THEN 'Touring'
				 ELSE 'n/a'
			END AS prd_line,--Map product line codes to descriptive values 
			CAST(prd_start_dt AS DATE)AS prd_start_dt,
			CAST(
				LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 
				AS Date
			) AS prd_end_dt--Calculate and date as one day before the next start date 
			from Bronze.crm_prd_info;

		set @end_time = Getdate();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR)+'Seconds';
		PRINT '-----------------------------------------'


		--Loading Silver.crm_sales_details
		set @start_time = Getdate();
		PRINT '>> Truncating Table : Silver.crm_sales_details';
		TRUNCATE TABLE Silver.crm_sales_details;
		PRINT '>> Inserting Data Into Table : Silver.crm_sales_details';
		Insert Into Silver.crm_sales_details(
				sls_ord_num,
				sls_prd_key,
				sls_cust_id,
				sls_order_dt,
				sls_ship_dt,
				sls_due_dt,
				sls_sales,
				sls_quantity,
				sls_price
		)
			select
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE 
				WHEN sls_order_dt <=0 or Len(sls_order_dt)!=8 THEN NULL 
				ELSE CAST(CAST(sls_order_dt AS varchar) AS DATE)
			END AS sls_order_dt,
			CASE 
				WHEN sls_ship_dt <=0 or Len(sls_ship_dt)!=8 THEN NULL 
				ELSE CAST(CAST(sls_ship_dt AS varchar) AS DATE)
			END AS sls_ship_dt,
			CASE 
				WHEN sls_due_dt <=0 or Len(sls_due_dt)!=8 THEN NULL 
				ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE)
			END AS sls_due_dt,
			CASE 
				WHEN sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * ABS(sls_price)
					THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END AS sls_sales,
			sls_quantity,
			CASE WHEN sls_price is null or sls_price <= 0
					THEN sls_sales / NULLIF(sls_quantity,0)
				 ELSE sls_price
			END AS sls_price
			from Bronze.crm_sales_details;

		set @end_time = GetDate();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR)+'Seconds';
		PRINT '-----------------------------------------'


		PRINT '------------------------------------------';
		PRINT 'Loading erp Tables';
		PRINT '------------------------------------------';


		--Loading Silver.erp_cust_az12
		set @start_time = Getdate();
		PRINT '>> Truncating Table : Silver.erp_cust_az12';
		TRUNCATE TABLE Silver.erp_cust_az12;
		PRINT '>> Inserting Data Into Table : Silver.erp_cust_az12';
		Insert Into Silver.erp_cust_az12 (
				cst_cid,
				cst_bdate,
				cst_gen
		)
			select
				CASE WHEN cst_cid like 'NAS%' Then SUBSTRING(cst_cid,4,LEN(cst_cid))
					 else cst_cid
				END cst_cid,
				CASE WHEN cst_bdate > getdate() Then null 
					 else cst_bdate
				END cst_bdate,
				CASE WHEN UPPER(TRIM(cst_gen)) in ('F','FEMALE') THEN 'Female'
					 WHEN UPPER(TRIM(cst_gen)) in ('M','MALE') THEN 'Male'
					 ELSE 'n/a'
				END cst_gen
			from Bronze.erp_cust_az12;

		set @end_time = GetDate();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR)+'Seconds';
		PRINT '-----------------------------------------'


		--Loading Silver.erp_loc_a101
		set @start_time = Getdate();
		PRINT '>> Truncating Table : Silver.erp_loc_a101';
		TRUNCATE TABLE Silver.erp_loc_a101;
		PRINT '>> Inserting Data Into Table : Silver.erp_loc_a101';
		Insert Into Silver.erp_loc_a101 (
				loc_cid,
				loc_cntry
		)
			select
			REPLACE(loc_cid ,'-','')as loc_cid,
			Case When Trim(loc_cntry) IN ('US','USA') Then 'United States'
				 when Trim(loc_cntry) = 'DE'  Then 'Germany'
				 when Trim(loc_cntry) = '' or loc_cntry is Null Then 'n/a'
				 else Trim(loc_cntry)
			End loc_cntry
			from Bronze.erp_loc_a101;

		set @end_time = GetDate();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR)+'Seconds';
		PRINT '-----------------------------------------'


		--Loading Silver.erp_px_cat_g1v2
		set @start_time = Getdate();
		PRINT '>> Truncating Table : Silver.erp_px_cat_g1v2';
		TRUNCATE TABLE Silver.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into Table : Silver.erp_px_cat_g1v2';
		Insert Into Silver.erp_px_cat_g1v2 (
				px_cid,
				px_cat,
				px_subcat,
				px_maintenance
		)
			select 
			px_cid,
			px_cat,
			px_subcat,
			px_maintenance
			from Bronze.erp_px_cat_g1v2;

		set @end_time = GetDate();
		PRINT 'Load Duration :'+ Cast(Datediff(Second,@start_time,@end_time)AS NVARCHAR)+'Seconds';
		PRINT '-----------------------------------------'


		set @batch_end_time = GETDATE();
			PRINT '============================================='
			PRINT 'Loading Silver Layer is Complited';
			PRINT ' --Tatal Load Duration:'+ Cast(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR);
			PRINT '============================================='
	END TRY

	BEGIN CATCH 
	PRINT '============================================'
	PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Message'+ CAST(ERROR_NUMBER()AS NVARCHAR);
	PRINT 'Error Message'+ CAST(ERROR_STATE()AS NVARCHAR);
	PRINT '============================================'
	END CATCH 
END

-- Excuting to run the queries--
--EXEC Silver.load_Silver
