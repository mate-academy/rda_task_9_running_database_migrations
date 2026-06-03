# RDA Task 9 - Running Database Migrations

## Status: In Progress

## What is done

- Added changeset `mate.acamemy:5 labels:0.0.2` to `task.sql` — creates `Users` table with columns `ID`, `FirstName`, `LastName`, `Email`
- Added changeset `mate.acamemy:6 labels:0.0.3` to `task.sql` — creates `Email` index on `Users.Email`
- Both changesets have rollback procedures defined

## File location

`~/devlab-dir/mysql_mate/rda_task_9_running_database_migrations/task.sql`

## Where I stopped

Testing with Docker + Liquibase. Last error:

```
Access denied for user 'root'@'172.17.0.2' (using password: YES)
```

MySQL is denying the connection from the Docker container IP `172.17.0.2`.

## Next step

Grant MySQL access to root from the Docker network IP:

```sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.0.2' IDENTIFIED BY 'P@ssw0rd';
```

Then re-run the Liquibase update command:

```
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    liquibase/liquibase liquibase \
    --changelog-file=task.sql \
    --url=jdbc:mysql://192.168.1.120:3306/ShopDB \
    --username=root \
    --password=P@ssw0rd \
    update --labels="0.0.1"
```

Then repeat for `0.0.2` and `0.0.3`, tagging after each step.
