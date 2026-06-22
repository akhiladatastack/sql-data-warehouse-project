/*
Create database and schemas
Script Purpose:
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. aditionally, the script sets up three schemas with in the database:
  'Bronze' 'Silver' 'Gold'.

WARINING:
  Running this script will drop the entire DataWarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/
USE masters;
Go

-- drop and recreate the datawarehouse  database
IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = 'DataWarehouse')
BEGIN 
  ALTER DATABASE DataWarehouse set single_user with rollback immediate;
DROP DATABASE DataWarehouse;
END;
GO
-- CREATE DATABASE
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO
  -- CREATE SCHEMAS
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
