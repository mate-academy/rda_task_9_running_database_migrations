-- script to test version 0.0.3 of the database schema: 
-- database should contain only tables, decsribed in the 
-- initial changesets (Countries, Products, Warehouses, ProductInventory) + 
-- Users table + it should  have index for Email on Users table

SET @UsersTable := (SELECT count(*)
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'ShopDB'
AND TABLE_NAME = 'Users'); 
SELECT IF( @UsersTable = 1, 'Users table was found - OK', 'Error: Users table is not present in the database');

SET @EmailIndex := (SELECT count(*)
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'ShopDB' 
and TABLE_NAME = 'Users' 
and INDEX_NAME = 'Email' 
and COLUMN_NAME = 'Email'); 
SELECT IF( @EmailIndex = 1, 'Email index was found - OK', 'Error: Email index was not found in the Users table');
