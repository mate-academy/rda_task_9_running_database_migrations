-- changeset yourname:create_initial_schema label:0.0.1
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseAmount INT,
    WarehouseID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE SET NULL
);

-- rollback DROP TABLE ProductInventory;
-- rollback DROP TABLE Warehouses;
-- rollback DROP TABLE Products;
-- rollback DROP TABLE Countries;


-- changeset yourname:create_users_table label:0.0.2
CREATE TABLE Users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- rollback DROP TABLE Users;


-- changeset yourname:create_email_index label:0.0.3
CREATE INDEX idx_email ON Users(Email);

-- rollback DROP INDEX idx_email ON Users;
