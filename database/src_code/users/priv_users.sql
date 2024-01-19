
USE autoloc_db;

CREATE USER 'analytics@localhost' IDENTIFIED BY '@4n4lyt1cs';
GRANT SELECT ON *. * TO 'analytics@localhost';
FLUSH PRIVILEGES;