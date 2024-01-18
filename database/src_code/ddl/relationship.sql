
/*
    Criação das CONSTRAINTs para relacionamento das tabelas
    -Atenção para a integridade referencial 
    -estão setadas na forma mais lógica para o domínio do negócio
*/

ALTER TABLE car_table 
ADD CONSTRAINT fk_car_table_relat
    FOREIGN KEY (fk_model_id)
    REFERENCES model_table (model_id)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE;
 
ALTER TABLE telephone_table
ADD CONSTRAINT fk_telephone_table_relat
    FOREIGN KEY (fk_customer_id)
    REFERENCES customer_table (customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE; 

ALTER TABLE rent_table 
ADD CONSTRAINT fk_rent_table_relat
    FOREIGN KEY (fk_employee_id)
    REFERENCES employee_table (employee_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE rent_table ADD 
CONSTRAINT fk_rent_table_relat2
    FOREIGN KEY (fk_car_id)
    REFERENCES car_table (car_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;
 
ALTER TABLE rent_table ADD 
CONSTRAINT fk_rent_table_relat3
    FOREIGN KEY (fk_customer_id)
    REFERENCES customer_table (customer_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;