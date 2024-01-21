import mysql.connector
import json
from typing import Any
import random as rd

CUSTOMERS_SIZE = 1000
TELEPHONES_SIZE = 1500

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

def main():
    connection: Any = mysql.connector \
        .connect(**get_json_file('database/scripts','db_config.json'))
    cursor: Any = connection.cursor()
    try:
        cursor.execute("SET NAMES 'utf8';")
        #insert_customer_random_data(cursor)
        #insert_telephones(cursor)
    except mysql.connector.Error as error:
        print(f'DB error: {error}')
    finally:
        connection.commit()
        cursor.close()
        connection.close()

if __name__ == '__main__':
    main()
