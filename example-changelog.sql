--changeset mate.acamemy:5 labels:0.0.2
CREATE TABLE Users (
    ID INT AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    PRIMARY KEY (ID)
);
--rollback DROP TABLE Users;

--changeset mate.acamemy:6 labels:0.0.3
CREATE INDEX Email ON Users(Email);
--rollback DROP INDEX Email ON Users;