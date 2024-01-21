
/*
    Triggers para validação de dados 
    -Principalmente dados relacionados a datas e periodos de tempo
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

CREATE TRIGGER check_car_year_insert
BEFORE INSERT ON car_table
FOR EACH ROW 
BEGIN
    IF NEW.year NOT BETWEEN YEAR('1900-01-10') AND YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

CREATE TRIGGER check_car_year_update
BEFORE UPDATE ON car_table
FOR EACH ROW 
BEGIN
    IF NEW.year NOT BETWEEN YEAR('1900-01-10') AND YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

CREATE TRIGGER check_rent_start_insert
BEFORE INSERT ON rent_table
FOR EACH ROW 
BEGIN
    IF NEW.start NOT BETWEEN TIMESTAMP('1900-01-01') 
            AND (CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

CREATE TRIGGER check_rent_start_update
BEFORE UPDATE ON rent_table
FOR EACH ROW 
BEGIN
    IF NEW.start NOT BETWEEN TIMESTAMP('1900-01-01') 
            AND (CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

CREATE TRIGGER check_rent_end_time_insert
BEFORE INSERT ON rent_table
FOR EACH ROW 
BEGIN
    IF NEW.end_time NOT BETWEEN TIMESTAMP('1900-01-01') 
            AND (CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

CREATE TRIGGER check_rent_end_time_update
BEFORE UPDATE ON rent_table
FOR EACH ROW 
BEGIN
    IF NEW.end_time NOT BETWEEN TIMESTAMP('1900-01-01') 
            AND (CURRENT_TIMESTAMP()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ano inválido.'; 
    END IF;
END;

/*
    Trigger para a atualização automática da kilometragem do veículo
    após o retorno e a atualização na tabela rent_table
*/

CREATE TRIGGER update_car_mileage_km
AFTER UPDATE ON rent_table 
FOR EACH ROW 
BEGIN
    UPDATE car_table
    SET mileage_km = mileage_km + rent_table.kms_driven
    WHERE rent_table.fk_car_id = car_id;
END;