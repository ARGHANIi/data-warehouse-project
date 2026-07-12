/*
============================================================
DDL Scripts: Creating Bronze Tables
============================================================
Script purpose: 
This scripts create Bronze layer Tables, Dropping existing 
Tables if they already exist .
Run this to Re-Create Tables and Drop all Tables.
============================================================
*/

if object_id ('Bronze.crm_cust_info','U') IS NOT NULL 
	Drop Table Bronze.crm_cust_info;
Create table Bronze.crm_cust_info (
	cst_id int,
	cst_key varchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date Date
);
if object_id ('Bronze.crm_prd_info','U') IS NOT NULL 
	Drop Table Bronze.crm_prd_info;
Create table Bronze.crm_prd_info (
	prd_id int,
	prd_key varchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(10),
	prd_start_dt Date,
	prd_end_dt Date
);
if object_id ('Bronze.crm_sales_details','U') IS NOT NULL 
	Drop Table Bronze.crm_sales_details;
Create table Bronze.crm_sales_details (
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);
if object_id ('Bronze.erp_cust_az12','U') IS NOT NULL 
	Drop Table Bronze.erp_cust_az12;
Create Table Bronze.erp_cust_az12(
	cst_cid nvarchar(50),
	cst_bdate Date,
	cst_gen nvarchar(50),
);
if object_id ('Bronze.erp_loc_a101','U') IS NOT NULL 
	Drop Table Bronze.erp_loc_a101;
Create Table Bronze.erp_loc_a101(
	loc_cid nvarchar(50),
	loc_cntry nvarchar(50),
);
if object_id ('Bronze.erp_px_cat_g1v2','U') IS NOT NULL 
	Drop Table Bronze.erp_px_cat_g1v2;
Create Table Bronze.erp_px_cat_g1v2(
	px_cid nvarchar(50),
	px_cat nvarchar(50),
	px_subcat nvarchar(50),
	px_maintenance nvarchar(10)
);
