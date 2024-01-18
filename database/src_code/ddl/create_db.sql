
/*
    Este arquivo contem apenas scripts de criação de tabelas,
    os relacionamentos e tabela de log estão em seus respectivos
    arquivos
*/

CREATE DATABASE autoloc_db
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE autoloc_db;

CREATE TABLE customer_table (
    customer_id INT PRIMARY KEY NOT NULL,
    email VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    UNIQUE (email, cpf, customer_id),
    /*
        Verificações básicas dos dados do cliente -> regex 
        A verificação da data de nascimento está na pasta de triggers
    */
    CONSTRAINT check_cpf_digits CHECK(cpf REGEXP '^[0-9]{11}$'),
    CONSTRAINT check_email CHECK(
        email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$'
    )
);

/*
    A partir deste ponto as constraints 
    seguem o mesmo "padrão" -> valores e regex
    -Verificações relacionadas a data e periodos de tempo
    -Estão no arquivo específicos para triggers
*/

CREATE TABLE car_table (
    car_id INT PRIMARY KEY NOT NULL,
    plate VARCHAR(7) NOT NULL,
    mileage_km INT NOT NULL,
    year YEAR NOT NULL,
    fk_model_id INT NOT NULL,
    color VARCHAR(25) NOT NULL,
    chassis VARCHAR(17) NOT NULL,
    active BOOLEAN NOT NULL,
    UNIQUE (car_id, plate, chassis),
    CONSTRAINT check_plate_format CHECK(
        plate REGEXP '^[A-Za-z]{3}-[0-9]{4}$|^[A-Za-z]{3}[0-9][A-Za-z][0-9]{2}$'
    ),
    CONSTRAINT check_mileage_value CHECK(mileage_km >= 0),
    CONSTRAINT check_chassis_format CHECK(
        chassis REGEXP '^[A-HJ-NPR-Z0-9]{17}$'
    )
);

CREATE TABLE model_table (
    model_id INT PRIMARY KEY NOT NULL,
    brand VARCHAR(25) NOT NULL,
    model_name VARCHAR(25) NOT NULL,
    motorization VARCHAR(25) NOT NULL,
    UNIQUE (model_name, model_id),
    CONSTRAINT check_motorization_format CHECK(
        motorization REGEXP '^[0-9]+\.[A-Za-z][0-9] [A-Za-z]+$'
    )
);

CREATE TABLE employee_table (
    employee_id INT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(25) NOT NULL,
    active BOOLEAN NOT NULL,
    UNIQUE (employee_id, name)
);

CREATE TABLE telephone_table (
    telephone_id INT PRIMARY KEY NOT NULL,
    number VARCHAR(10) NOT NULL,
    fk_customer_id INT NOT NULL,
    ddd VARCHAR(3) NOT NULL,
    UNIQUE (telephone_id, number),
    CONSTRAINT check_number_format CHECK(
        number REGEXP '^[0-9]{5}-[0-9]{4}$'
    ),
    CONSTRAINT check_ddd_format CHECK(ddd REGEXP '^0[0-9]{2}$')
);

CREATE TABLE rent_table (
    rent_id INT PRIMARY KEY UNIQUE NOT NULL,
    value FLOAT(8,2) NOT NULL,
    start DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    kms_driven INT NOT NULL,
    fk_employee_id INT,
    fk_car_id INT,
    fk_customer_id INT,
    insurance_type VARCHAR(8) NOT NULL,
    CONSTRAINT check_value CHECK(value >= 0),
    CONSTRAINT check_insurance_type_options CHECK(
        insurance_type REGEXP '^(silver|gold|platinum)$'
    )
);
