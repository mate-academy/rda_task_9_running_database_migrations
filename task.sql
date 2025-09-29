--liquibase formatted sql

-- Changesets for initial schema version 0.0.1 (Base Tables)
-- Author: mate.acamemy
-- All these changesets should be applied initially and tagged 0.0.1

--changeset mate.acamemy:1 labels:0.0.1
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50)
);
--rollback DROP TABLE Countries;

--changeset mate.acamemy:2 labels:0.0.1
CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50)
);
--rollback DROP TABLE Products;

--changeset mate.acamemy:3 labels:0.0.1
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(50),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE NO ACTION
);
--rollback DROP TABLE Warehouses;

--changeset mate.acamemy:4 labels:0.0.1
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE NO ACTION,
    WarehouseAmount INT,
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE NO ACTION
);
--rollback DROP TABLE ProductInventory;


-- NEW CHANGESET 0.0.2: Create Users Table
-- Author: mate.acamemy
-- Unique ID for tracking: 5 (following the sequence)
-- Label: 0.0.2
--changeset mate.acamemy:5 labels:0.0.2
--comment: Creating Users table to store customer login and contact info.
CREATE TABLE Users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL
);
--rollback DROP TABLE Users;


-- NEW CHANGESET 0.0.3: Create Index on Users.Email
-- Author: mate.acamemy
-- Unique ID for tracking: 6
-- Label: 0.0.3
--changeset mate.acamemy:6 labels:0.0.3
--comment: Creating an index on the Email column for faster lookups (login).
CREATE INDEX Email ON Users (Email);
--rollback DROP INDEX Email ON Users;
