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

--changeset yourName:create-users-table labels:0.0.2
--comment Створює таблицю Users з ID, FirstName, LastName та Email.
CREATE TABLE Users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE NOT NULL
);

--rollback DROP TABLE Users;

--changeset yourName:add-email-index-to-users labels:0.0.3
--comment Створює індекс на полі Email у таблиці Users.
CREATE INDEX IDX_Users_Email ON Users (Email);

--rollback DROP INDEX IDX_Users_Email ON Users;
