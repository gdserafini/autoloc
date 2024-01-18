-- Active: 1705494485158@@127.0.0.1@3306@autoloc_db

/*
    Triggers para validação de dados 
    e regras de negócios mais simples
*/

CREATE TRIGGER check_birth_date_insert
BEFORE INSERT ON customer_table
FOR EACH ROW
BEGIN
    IF NEW.birth_date NOT BETWEEN '1900-01-01' AND (CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data Inválida.';
    END IF;
END;

CREATE TRIGGER check_birth_date_update
BEFORE UPDATE ON customer_table
FOR EACH ROW
BEGIN
    IF NEW.birth_date NOT BETWEEN '1900-01-01' AND (CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data Inválida.';
    END IF;
END;
