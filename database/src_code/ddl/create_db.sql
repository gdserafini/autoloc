-- Active: 1705494485158@@127.0.0.1@3306@autoloc_db
/*
    Este arquivo contem apenas scripts de criação de tabelas,
    os relacionamentos e tabela de log estão em seus respectivos
    arquivos
*/

CREATE TABLE customer_table (
    customer_id INT PRIMARY KEY NOT NULL,
    email VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    UNIQUE (email, cpf, customer_id),
    /*
        Verificações básicas dos dados do cliente - len/regex 
        A verificação da data de nascimento está na pasta de triggers
    */
    CONSTRAINT check_cpf_len CHECK(LENGTH(cpf) = 11),
    CONSTRAINT check_cpf_digits CHECK(cpf REGEXP '[0-9]+$'),
    CONSTRAINT check_email CHECK(
        email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$')
);
