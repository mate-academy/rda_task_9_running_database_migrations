--changeset mate.academy:5 labels:0.0.2
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255)
);

--rollback DROP TABLE Users;


--changeset mate.academy:6 labels:0.0.3
CREATE INDEX Email ON Users(email);

--rollback DROP INDEX Email ON Users;