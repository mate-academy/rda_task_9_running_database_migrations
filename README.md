# Database Migrations

Database migration tools can be beneficial when dealing with the deployment of database schema changes. The best way to learn schema migration is to practice it!

In this task, you will work with the same old `ShopDB` database for the online store. The development team has already started using Liquibase for database schema migrations. The database changelog is stored in the `task.sql` file. The initial version of the database (labeled `0.0.1`) has the following tables:

- `Countries`, which has the following columns: `ID` and `Name`. 
- `Products`, which has the following columns: `ID` and `Name`. 
- `Warehouses`, which has the following columns: `ID`, `Name`, `Address` and `CountryID`
- `ProductInventory`, which has the following columns: `ID`, `ProductID`, `WarehouseAmount`, and `WarehouseID`. 

## Prerequisites

1. Install and configure a MySQL database server on a Virtual Machine and connect to it with the MySQL client.
2. Fork this repository.
3. Install Docker on your computer.

## Requirements

In this task, you need to develop 2 new changesets for the `ShopDB` database changelog:

- The first changeset should create a `Users` table, which has the following columns: `ID`, `FirstName`, `LastName`, and `Email`. The changeset should have a new unique ID (just as the rest of the existing changesets in the changelog) and `0.0.2` label. 
- The second changeset should create an `Email` index for the `Email` field in the `Users` table. This changeset should have the `0.0.3` label. 

Both changesets should have a rollback procedure defined.  

## How to Test Yourself

Just in case you want to test your script on your database before submitting a pull request, you can do it by performing the following actions: 

1. Drop the `ShopDB` database using the `DROP DATABASE ShopDB;` statement if you already have it on your database server.
2. Create an empty `ShopDB` database on your database server.
3. Run the initial schema migration for the `ShopDB` database with Liquibase using Docker on your computer: 

```
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase update --labels="0.0.1 
```

Make sure to run the command in the folder where the repository is cloned. If you are running the script on Windows, replace `$(pwd)` with the full path of the cloned repository. 

Replace `<db username>`, `<db password>`, and `<db host>` with values for your database server before running the command. 

4. Tag the database with the initial version, so you will be able to rollback any new changesets: 

```
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase tag 0.0.1
```

5. Use commands described in steps 3 and 4 to update the database to versions `0.0.2` and `0.0.3` you will create while working on this task. 
6. Test rollback of the changeset by reverting the state of the database to a tag: 

```
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase rollback <tag name>
```

Replace `<tag name>` with the tag version you want to rollback to, for example, `0.0.2` or `0.0.1`.
