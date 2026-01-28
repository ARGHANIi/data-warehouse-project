/*
============================================================
DDL Scripts: Creating Silver Tables
============================================================
Script purpose: 
	This scripts create Silver layer Tables, Dropping existing 
	Tables if they already exist .
	Run this to Re-Create Tables and Drop all Tables.
============================================================
*/

if object_id ('Silver.crm_cust_info','U') IS NOT NULL 
	DROP TABLE Silver.crm_cust_info;
	Go
Create table Silver.crm_cust_info (
	cst_id int,
	cst_key varchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date Date,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
if object_id ('Silver.crm_prd_info','U') IS NOT NULL 
	Drop Table Silver.crm_prd_info;
	GO
Create table Silver.crm_prd_info (
	prd_id int,
	cat_id varchar(50),
	prd_key varchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt Date,
	prd_end_dt Date,
	dwh_create_date DATETIME2 DEFAULT GETDATE()

);
if object_id ('Silver.crm_sales_details','U') IS NOT NULL 
	Drop Table Silver.crm_sales_details;
	GO
Create table Silver.crm_sales_details (
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales int,
	sls_quantity int,
	sls_price int,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
if object_id ('Silver.erp_cust_az12','U') IS NOT NULL 
	Drop Table Silver.erp_cust_az12;
	GO
Create Table Silver.erp_cust_az12(
	cst_cid nvarchar(50),
	cst_bdate Date,
	cst_gen nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
if object_id ('Silver.erp_loc_a101','U') IS NOT NULL 
	Drop Table Silver.erp_loc_a101;
	GO
Create Table Silver.erp_loc_a101(
	loc_cid nvarchar(50),
	loc_cntry nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
if object_id ('Silver.erp_px_cat_g1v2','U') IS NOT NULL 
	Drop Table Silver.erp_px_cat_g1v2;
	GO
Create Table Silver.erp_px_cat_g1v2(
	px_cid nvarchar(50),
	px_cat nvarchar(50),
	px_subcat nvarchar(50),
	px_maintenance nvarchar(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
