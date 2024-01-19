-- Active: 1705494485158@@127.0.0.1@3306@autoloc_db

USE autoloc_db;

CREATE USER 'analytics@localhost' IDENTIFIED BY '@4n4lyt1cs';
GRANT SELECT ON *. * TO 'analytics@localhost';
FLUSH PRIVILEGES;