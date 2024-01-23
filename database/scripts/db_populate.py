import mysql.connector
import json
from typing import Any
import random as rd
import string as st

CUSTOMERS_SIZE = 1000
TELEPHONES_SIZE = 1500
MODELS_SIZE = 10
CARS_SIZE = 100
EMPLOYEES_SIZE = 25
RENTS_SIZE = 2500

def get_json_file(path: str, file_name: str) -> dict:
    try:
        with open(f'{path}/{file_name}') as config_file:
            return json.load(config_file)
    except Exception as ex:
        raise Exception(f'File error: {ex}')

def insert_customer_random_data(cursor: Any) -> None:
    try:
        with open('database/scripts/data/customers_name.txt', 'r') as names_file:
            names = [n.strip() for n in names_file.readlines()]
        with open('database/scripts/data/customers_surname.txt', 'r') as surnames_file:
            surnames = [sn.strip() for sn in surnames_file.readlines()]
        for id in range(CUSTOMERS_SIZE):
            customer_name = names[rd.randint(0,len(names)-1)]
            customer_surname = surnames[rd.randint(0,len(surnames)-1)]
            cursor.execute(
                f"""INSERT INTO 
                customer_table(customer_id, email, cpf, name, birth_date) 
                VALUES({id+2}, 'e{str(id+2)}@email.com', 
                    '{str(id+2).zfill(11)}', '{customer_name} {customer_surname}', '2000-01-01'
                );"""
            )
    except Exception as ex:
        raise Exception(f'File error: {ex}')
    
def insert_telephones(cursor: Any) -> None:
    try:
        numberpt1 = 0
        numberpt2 = 0
        fk_id = 2
        for id in range(TELEPHONES_SIZE):
            numberpt1 += 1 if numberpt1 + 1 <= 99999 else 0
            numberpt2 += 1 if numberpt2 + 1 <= 9999 else 0
            fk_id += 1 if fk_id + 1 <= 1001 else 0
            tel_number = f'{str(numberpt1).zfill(5)}-{str(numberpt2).zfill(4)}'
            cursor.execute(
                f"""INSERT INTO 
                telephone_table(telephone_id, number, fk_customer_id, ddd) 
                VALUES({id+1}, '{tel_number}', {fk_id}, '012');"""
            )
    except Exception as ex:
        raise Exception(f'File error: {ex}')
    
def insert_models(cursor: Any) -> None:
    with open('database/scripts/data/models.txt') as models_file:
        models = [model.strip() for model in models_file.readlines()]
    motorization = ['2.0 l4 turbo', '3.0 l6 turbo', '4.0 v8 biturbo']
    for i in range(MODELS_SIZE):
        motor = motorization[rd.randint(0,2)]
        cursor.execute(
            f"""
                INSERT INTO model_table(model_id, brand, model_name, motorization)
                VALUES ({i+1}, '{models[i].split()[0]}', '{models[i]}', '{motor}')
            """
        )
        print(f'Inserted: {i}')

def get_100_chassis() -> list:
    chassis_set = set()
    for i in range(CARS_SIZE):
        chassis_set.add(f'AA00AAA00AA{str(i).zfill(3)}AAA')
    return list(chassis_set)
        

def insert_cars(cursor: Any) -> None:
    model_id = 1
    years = ['2020', '2021', '2022', '2023']
    color = ['Black', 'White', 'Grey']
    chassis = get_100_chassis()
    try:
        for i in range(CARS_SIZE):
            model_id += 1 if model_id + 1 <= 10 else 0
            cursor.execute(
                f"""
                    INSERT INTO car_table(
                        car_id, plate, mileage_km, 
                        year, fk_model_id, color, 
                        chassis, active
                    )
                    VALUES(
                        {i+1}, '{'AAA' + str(i+1).zfill(4)}', {(i+1)*100}, 
                        '{years[rd.randint(0,3)]}', {model_id}, '{color[rd.randint(0,2)]}',
                        '{chassis[i]}', {1}
                    )
                """
            )
    except Exception as ex:
        raise Exception(f'File error: {ex}')

def insert_employees(cursor: Any) -> None:
    try:
        with open('database/scripts/data/customers_name.txt', 'r') as names_file:
            names = [n.strip() for n in names_file.readlines()]
        with open('database/scripts/data/customers_surname.txt', 'r') as surnames_file:
            surnames = [sn.strip() for sn in surnames_file.readlines()]
        for i in range(EMPLOYEES_SIZE):
            name = f'{names[rd.randint(0,11)]} {surnames[rd.randint(0,5)]}'
            cursor.execute(
                f"""
                    INSERT INTO employee_table(
                        employee_id, name, position, active
                    )
                    VALUES({i+1}, '{name}', 'Seller', {1})
                """
            )
        print(f'Inserted: {i+1}')
    except Exception as ex:
        raise Exception(f'File error: {ex}')



###TODO -> REVISAR E FINALIZAR SCRIPT
def is_located(cursor: Any, car_id: int, date: str) -> bool:
    cursor.execute(
        f"""
            SELECT rent_id FROM rent_table 
            WHEN car_id = {car_id} AND {date} >= start AND {date} <= end_time
        """
    )
    return len(cursor.fetchall()) == 0
    
def increment_date(date: str, incr_h=0, incr_d=0) -> str:
    datetime_list = date.split()
    date = datetime_list[0].split('-')
    time = datetime_list[1].split(':')
    date[1] += incr_d
    time[1] += incr_h
    return f'{date[0]}-{date[1]}-{date[2]} {time[0]}:{time[1]}:{time[2]}'

def decremet_date(date: str, drec_h=0, decr_d=0) -> str:
    datetime_list = date.split()
    date = datetime_list[0].split('-')
    time = datetime_list[1].split(':')
    date[1] -= decr_d
    time[1] -= drec_h
    return f'{date[0]}-{date[1]}-{date[2]} {time[0]}:{time[1]}:{time[2]}'

def insert_rents(cursor: Any) -> None:
    date = '2023-01-00 00:00:00'
    steps_day = [1,2,3]
    counter = 0
    values = [1000, 2000, 3000]
    insurances = ['SILVER', 'GOLD', 'PLATINUM']
    while counter < 2500:
        car_id = rd.randint(1,CARS_SIZE)
        incr_step = steps_day[rd.randint(0,2)]
        date = increment_date(date, incr_d=incr_step)
        if is_located(cursor, car_id, date): 
            date = decremet_date(date, decr_d=incr_step)
            continue
        else:
            value = values[rd.randint(0,2)]
            cursor.execute(
                f"""
                    INSERT INTO rent_table(
                        rent_id, value, start, 
                        end_time, kms_driven, fk_employee_id,
                        fk_car_id, fk_customer_id, insurance_type
                    )
                    VALUES(
                        {counter+1}, {value}, {date},
                        {increment_date(date, incr_d=incr_step)}, {value}, 
                        {rd.randint(1,EMPLOYEES_SIZE)},
                        {rd.randint(1, CARS_SIZE)}, {rd.randint(1, CUSTOMERS_SIZE)}, 
                        {insurances[rd.randint(0,2)]}
                    )
                """
            )
            counter += 1
###



def main():
    try:
        connection: Any = mysql.connector \
            .connect(**get_json_file('database/scripts','db_config.json'))
        cursor: Any = connection.cursor()
        cursor.execute("SET NAMES 'utf8';")
        #insert_customer_random_data(cursor)
        #insert_telephones(cursor)
        #insert_models(cursor)
        #insert_cars(cursor)
        #insert_employees(cursor)
        

        
        ###
        #insert_rents(cursor)



    except mysql.connector.Error as error:
        print(f'DB error: {error}')
    finally:
        connection.commit()
        cursor.close()
        connection.close()

if __name__ == '__main__':
    main()
