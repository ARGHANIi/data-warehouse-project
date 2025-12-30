/*
============================
Create Database and scheas 
============================
Script Purpose:
This script check the database if its exist then drop it and then create a new one. And also create three schemas. Bronze, silver, gold

Warning:
Running this script will drop all database 'DataWarehouse' if its exist and everything remove. Be careful to run this script.
*/



use master    
GO

--Drop and recreate the 'DataWarehouse' database

If exists (select 1 from sys.databases where name ='DataWarehouse')
Begin
	Alter DATABASE DataWarehouse set SINGLE_USER with rollback immediate;
	Drop database DataWarehouse ;
End;

GO


--Creatin'DataWarehouse' Database
  
create Database DataWarehouse;
GO

use DataWarehouse ;
GO

--Create schemas 

Create schema Bronze ;
GO 
Create schema Silver ;
GO 
Create schema Gold ;
GO 
