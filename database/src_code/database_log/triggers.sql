-- Active: 1705494485158@@127.0.0.1@3306@autoloc_db

USE autoloc_db;

/*
    Triggers para inserção de dados na tabela rent_log_table
    -Válidas para INSERT, UPDATE e DELETE -> visando alterações
    -na tabela rent_table
*/

CREATE TRIGGER rent_log_insert
AFTER INSERT ON rent_table
FOR EACH ROW
BEGIN
    INSERT INTO rent_log_table(
        operation, date, username,
        new_rent_id, new_value, new_start,
        new_end_time, new_kms_driven, new_fk_employee_id,
        new_fk_car_id, new_fk_customer_id, new_insurance_type
    )
    VALUES(
        'INSERT', NOW(), CURRENT_USER(),
        NEW.rent_id, NEW.value, NEW.start,
        NEW.end_time, NEW.kms_driven, NEW.fk_employee_id,
        NEW.fk_car_id, NEW.fk_customer_id, NEW.insurance_type
    );
END;

CREATE TRIGGER rent_log_delete
AFTER DELETE ON rent_table
FOR EACH ROW
BEGIN
    INSERT INTO rent_log_table(
        operation, date, username,
        new_rent_id, new_value, new_start,
        new_end_time, new_kms_driven, new_fk_employee_id,
        new_fk_car_id, new_fk_customer_id, new_insurance_type
    )
    VALUES(
        'DELETE', NOW(), CURRENT_USER(),
        OLD.rent_id, OLD.value, OLD.start,
        OLD.end_time, OLD.kms_driven, OLD.fk_employee_id,
        OLD.fk_car_id, OLD.fk_customer_id, OLD.insurance_type
    );
END;

CREATE TRIGGER rent_log_update
AFTER UPDATE ON rent_table
FOR EACH ROW
BEGIN
    INSERT INTO rent_log_table(
        operation, date, username,
        old_rent_id, old_value, old_start,
        old_end_time, old_kms_driven, old_fk_employee_id,
        old_fk_car_id, old_fk_customer_id, old_insurance_type,
        new_rent_id, new_value, new_start,
        new_end_time, new_kms_driven, new_fk_employee_id,
        new_fk_car_id, new_fk_customer_id, new_insurance_type
    )
    VALUES(
        'UPDATE', NOW(), CURRENT_USER(),
        NEW.rent_id, NEW.value, NEW.start,
        NEW.end_time, NEW.kms_driven, NEW.fk_employee_id,
        NEW.fk_car_id, NEW.fk_customer_id, NEW.insurance_type,
        OLD.rent_id, OLD.value, OLD.start,
        OLD.end_time, OLD.kms_driven, OLD.fk_employee_id,
        OLD.fk_car_id, OLD.fk_customer_id, OLD.insurance_type
    );
END;
