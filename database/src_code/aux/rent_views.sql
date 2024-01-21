
/* consulta armazenada dos clientes -> tabela virtual (query) */
CREATE VIEW customer_view AS 
SELECT 
    ct.name AS 'Nome',
    COUNT(rt.fk_customer_id) AS 'Número de locações',
    SUM(rt.value) AS 'Valor total (R$)',
    AVG(TIMESTAMPDIFF(HOUR, rt.start, rt.end_time)) 
        AS 'Tempo médio de locação'
FROM rent_table AS rt
INNER JOIN customer_table as ct
    ON ct.customer_id = rt.fk_customer_id
GROUP BY ct.name 
ORDER BY `Valor total (R$)` DESC;

SELECT * FROM customer_view;

CALL print_rent_info();
