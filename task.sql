--liquibase formatted sql

--changeset mate.acamemy:1 labels:0.0.1
CREATE TABLE Countries (
    ID INT,
    Name VARCHAR(50),
    PRIMARY KEY (ID)
);
--rollback DROP TABLE Countries;

--changeset mate.acamemy:2 labels:0.0.1
CREATE TABLE Products (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50),
    PRIMARY KEY (ID)
);
--rollback DROP TABLE Products;

--changeset mate.acamemy:3 labels:0.0.1
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50),
    Address VARCHAR(50),
    CountryID INT,
	FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE NO ACTION,
    PRIMARY KEY (ID)
);
--rollback DROP TABLE Warehouses;

--changeset mate.acamemy:4 labels:0.0.1
CREATE TABLE ProductInventory (
    ID INT,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE NO ACTION,
    WarehouseAmount INT,
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE NO ACTION,
    PRIMARY KEY (ID)
);
--rollback DROP TABLE ProductInventory;

-- Version 0.0.2: add application users to the existing ShopDB schema.
-- The author and numeric ID together uniquely identify this changeset.
--changeset mate.acamemy:5 labels:0.0.2
CREATE TABLE Users (
    ID INT AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PRIMARY KEY (ID)
);
-- Reverting to 0.0.1 removes everything introduced in this changeset.
--rollback DROP TABLE Users;

-- Version 0.0.3: speed up searches and filtering by a user's email.
-- This is intentionally a separate changeset so the index can be rolled
-- back without deleting the Users table or its data.
--changeset mate.acamemy:6 labels:0.0.3
CREATE INDEX Email ON Users (Email);
-- Reverting to 0.0.2 removes only the index created above.
--rollback DROP INDEX Email ON Users;
