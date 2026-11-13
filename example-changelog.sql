--liquibase formatted sql

--changeset your.name:1 labels:example-label context:example-context
--comment: example comment
create table person (
    id int primary key auto_increment not null,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE person;

--changeset your.name:2 labels:example-label context:example-context
--comment: example comment
create table company (
    id int primary key auto_increment not null,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE company;

--changeset other.dev:3 labels:example-label context:example-context
--comment: example comment
alter table person add column country varchar(2)
--rollback ALTER TABLE person DROP COLUMN country;


--changeset other.dev:5 labels:0.0.2
create table Users (
    ID int primary key auto_increment not null,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Email varchar(50) not null
);
--rollback DROP TABLE Users;

--changeset other.dev:6 labels:0.0.3
CREATE INDEX Email ON Users (Email);
--rollback DROP INDEX Email ON Users;
