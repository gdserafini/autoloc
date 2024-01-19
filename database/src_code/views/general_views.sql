/*
    Principais view relacionadas ao domínio de negócio
    -também algumas procedures
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
    SET customer_age = DATEDIFF(CURDATE(), customer_birth);
    RETURN customer_age;
END;

CREATE FUNCTION get_rent_time(id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE time_diff INT;
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    SELECT start, end_time 
        INTO start_time, end_time 
        FROM rent_table
        WHERE rent_id = id;
    SET time_diff = TIMESTAMPDIFF(SECOND, start_time, end_time);
    RETURN time_diff;
END;