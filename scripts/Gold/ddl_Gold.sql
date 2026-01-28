/*
==============================================================
DDL Script: Create Gold Views
==============================================================
Script Porpuse:
  -This script creats view for 'Gold' layer in the date warehouse.
  -The Gold layer represent the final dimension and fact table (star schema)
  -Each view performs transformation and combines data from Silver layer 
  to produce a clean, enrichrd and business-ready dataset.

Usage Note:
  These views can be queried directly for analytics and reporting.
==============================================================
*/
--============================================================
-- Create Fact Table: Gold_dim_customers
--============================================================
IF OBJECT_ID('Gold.dim_customers','V') IS NOT NULL 
    DROP VIEW Gold.dim_customers;
GO
  
CREATE VIEW Gold.dim_customers AS
	select 
		ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
		ci.cst_id AS customer_id,
		ci.cst_key AS customer_number,
		ci.cst_firstname AS first_name,
		ci.cst_lastname AS last_name,
		la.loc_cntry AS country,
		ci.cst_marital_status AS marital_status,
		CASE WHEN ci.cst_gndr != 'n/a' Then ci.cst_gndr --crm is the master for gender info 
			 ELSE COALESCE(ca.cst_gen,'n/a')
		END gender,
		ca.cst_bdate AS birthdate,
		ci.cst_create_date AS create_date
	from Silver.crm_cust_info ci
	left join Silver.erp_cust_az12 ca
	on		ci.cst_key = ca.cst_cid
	left join Silver.erp_loc_a101 la
	on		ci.cst_key = la.loc_cid


--============================================================
-- Create Fact Table: Gold_dim_products
--============================================================

IF OBJECT_ID('Gold.dim_products','V') IS NOT NULL 
    DROP VIEW Gold.dim_products;
GO
  
CREATE VIEW Gold.dim_products AS
	select
		ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) AS product_key,
		pn.prd_id AS product_id,
		pn.prd_key AS product_number,
		pn.prd_nm AS product_name,
		pn.cat_id AS category_id,
		pc.px_cat AS category,
		pc.px_subcat AS subcategory,
		pc.px_maintenance AS maintenance,
		pn.prd_cost AS cost,
		pn.prd_line AS product_line,
		pn.prd_start_dt AS start_date
	from Silver.crm_prd_info pn
	left join Silver.erp_px_cat_g1v2 pc
	on		pn.cat_id = pc.px_cid 
	where pn.prd_end_dt is null --Filter out all Historical data


--============================================================
-- Create Fact Table: Gold_fact_sales
--============================================================

IF OBJECT_ID('Gold.fact_sales','V') IS NOT NULL 
    DROP VIEW Gold.fact_sales;
GO
  
CREATE VIEW Gold.fact_sales AS
	select 
		sd.sls_ord_num AS order_number,
		pr.product_key,
		cu.customer_key,
		sd.sls_order_dt AS order_date,
		sd.sls_ship_dt AS shipping_date,
		sd.sls_due_dt AS due_date,
		sd.sls_sales AS sales_amount,
		sd.sls_quantity AS quantity,
		sd.sls_price AS price
	from Silver.crm_sales_details sd
	left join Gold.dim_customers cu
	on sd.sls_cust_id = cu.customer_id
	left join Gold.dim_products pr
	on sd.sls_prd_key = pr.product_number
