-- script to test version 0.0.1 of the database schema: 
-- database should contain only tables, decsribed in the 
-- initial changesets (Countries, Products, Warehouses, ProductInventory)

SET @UsersTable := (SELECT count(*)
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'ShopDB'
AND TABLE_NAME = 'Users'); 
SELECT IF( @UsersTable = 0, 'Users table was not found - OK', 'Error: Users table is present in the database');
