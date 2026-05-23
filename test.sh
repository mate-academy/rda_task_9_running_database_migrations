#!/bin/bash

### Initial setup phase
echo "INFO: Starting a MySQL database server for tests"
docker network create -d bridge test-network || true
docker run --name mysql --network=test-network --hostname mysql  \
-e MYSQL_ROOT_PASSWORD=P@ssw0rd -v $(pwd):/scripts -d mysql:8.0-debian

echo "INFO: Wainting for database server to initialize"
sleep 25

echo "INFO: Creating a database for test"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/1-create-database.sql'

### v0.0.1
echo "INFO: Running the database migration 0.0.1"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase --changelog-file=task.sql update --labels="0.0.1"

echo "INFO: Tagging a database version (0.0.1)"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase tag 0.0.1

echo "INFO: Running the tests for database schema version 0.0.1"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/2-test-0.0.1.sql' > log.txt
# Виправлений рядок за порадою Люка:
errors=$(cat log.txt | grep "^Error" | grep -v "Error: Users table is not present in the database" || true)
if [ -n "$errors" ]; then echo $errors && exit 1; fi

### v0.0.2 deployment
echo "INFO: Running the database migration 0.0.2"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase --changelog-file=task.sql update --labels="0.0.2"

echo "INFO: Tagging a database version (0.0.2)"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase tag 0.0.2

echo "INFO: Running the tests for database schema version 0.0.2"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/3-test-0.0.2.sql' > log.txt
errors=$(cat log.txt | grep "^Error" || true)
if [ -n "$errors" ]; then echo $errors && exit 1; fi

### v0.0.3 deployment
echo "INFO: Running the database migration 0.0.3"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase --changelog-file=task.sql update --labels="0.0.3"

echo "INFO: Tagging a database version (0.0.3)"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase tag 0.0.3

echo "INFO: Running the tests for database schema version 0.0.3"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/3-test-0.0.3.sql' > log.txt
errors=$(cat log.txt | grep "^Error" || true)
if [ -n "$errors" ]; then echo $errors && exit 1; fi

### rollback to v0.0.2
echo "INFO: rolling back to database version 0.0.2"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase --changelog-file=task.sql rollback 0.0.2

echo "INFO: Running the tests for database schema version 0.0.2"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/3-test-0.0.2.sql' > log.txt
errors=$(cat log.txt | grep "^Error" || true)
if [ -n "$errors" ]; then echo $errors && exit 1; fi

### rollback to v0.0.1
echo "INFO: rolling back to database version 0.0.1"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase --changelog-file=task.sql rollback 0.0.1

echo "INFO: Running the tests for database schema version 0.0.1"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/2-test-0.0.1.sql' > log.txt
# Виправлений рядок за порадою Люка (при відкаті до v0.0.1):
errors=$(cat log.txt | grep "^Error" | grep -v "Error: Users table is not present in the database" || true)
if [ -n "$errors" ]; then echo $errors && exit 1; fi

echo "SUCCESS: All migrations and rollbacks passed successfully!"
