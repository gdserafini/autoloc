-- Active: 1705494485158@@127.0.0.1@3306@autoloc_db

/*
    Tabela de log
    -Registros de todas as 4 principais operações de dados
    -referentes a reserversa de veículos com todos seus
    -atributos (old/new)
*/

USE autoloc_db;

CREATE TABLE rent_log_table(
    log_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    operation CHAR(6) NOT NULL,
    date DATETIME NOT NULL,
    username VARCHAR(25) NOT NULL,
    old_rent_id INT,
    new_rent_id INT,
    old_value FLOAT(8,2),
    new_value FLOAT(8,2),
    old_start DATETIME,
    new_start DATETIME,
    old_end_time DATETIME,
    new_end_time DATETIME,
    old_kms_driven INT,
    new_kms_driven INT,
    old_fk_employee_id INT,
    new_fk_employee_id INT,
    old_fk_car_id INT,
    new_fk_car_id INT,
    old_fk_customer_id INT,
    new_fk_customer_id INT,
    old_insurance_type VARCHAR(8),
    new_insurance_type VARCHAR(8),
    /*
        Neste caso há apenas a constraint de regex da operação
        -Pois a operação é definida no insert do trigger de log
        -A verificação do username não se faz necessária
    */
    CONSTRAINT check_operation_value CHECK(
        operation REGEXP '^(SELECT|INSERT|UPDATE|DELETE)$'
    )
);