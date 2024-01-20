
/*
    Funções para calculo de diferença de tempo
*/
CREATE FUNCTION get_customer_age(id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE customer_birth DATE;
    DECLARE customer_age INT;
    SELECT birth_date 
        INTO customer_birth
        FROM customer_table 
        WHERE customer_id = id;
    SET customer_age = YEAR(CURDATE()) - YEAR(customer_birth);
    IF MONTH(CURDATE()) < MONTH(customer_birth) OR
            (MONTH(CURDATE()) = MONTH(customer_birth) AND 
                DAY(CURDATE()) < DAY(customer_birth)) THEN
        SET customer_age = customer_age - 1;
    END IF;
    RETURN customer_age;
END;

/*
    Sumarização dos dados referentes a locação
*/
CREATE PROCEDURE print_rent_info()
BEGIN
    SELECT 
        rt.value AS 'Valor',
        TIMESTAMPDIFF(HOUR, rt.start, rt.end_time) AS 'Tempo locado',
        rt.kms_driven AS 'KMs rodados',
        et.name AS 'Funcionário',
        mt.model_name AS 'Modelo',
        cut.name AS 'Cliente',
        CONCAT("(", tt.ddd, ") ", tt.number) AS 'Contato',
        insurance_type AS 'Tipo de seguro'
    FROM rent_table AS rt
        INNER JOIN employee_table AS et
            ON rt.fk_employee_id = et.employee_id
        INNER JOIN car_table AS ct
            ON rt.fk_car_id = ct.car_id
        INNER JOIN model_table AS mt
            ON ct.fk_model_id = mt.model_id
        INNER JOIN customer_table AS cut
            ON rt.fk_customer_id = cut.customer_id
        INNER JOIN telephone_table AS tt
            ON cut.customer_id = tt.fk_customer_id;
END;
