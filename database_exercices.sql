---11 Cereri SQL

--1. Sa se afiseze numarul comenzii, cantitatea, numele cafenelei, pretul comenzii, numele categoriei, si numele paharului 
--bauturilor comandate din toate cafenelele, sortate dupa numele cafenelelor, numele bauturilor.
SELECT order_id, quantity, cafe_name, p.price * o.quantity "PRET", category_name, glass_type, glass_material
FROM orders o
INNER JOIN products p
        ON p.product_id = o.product_id
INNER JOIN cafes cf
        ON cf.cafe_id = p.cafe_id
INNER JOIN drinks d
        ON p.product_id = d.product_id
LEFT JOIN  categories c
       ON  d.category_id = c.category_id
LEFT JOIN  glasses g
       ON  d.glass_id = g.glass_id
ORDER by cafe_name, p.product_name;

--2.Sa se afi?eze numele, data angajarii, salariul si o coloana reprezentand salariul dupa ce se aplica o marire, astfel: 
--pentru salaria?ii angaja?i in marite cresterea este de 20%, pentru cei angajati în aprilie cresterea este de 10%, iar
--pentru salariatii angajati dupa luna mai nu se modifica, pentru toti angajatii care au salariul initial mai mare de 2000.
-- 2  rezolvari DECODE si CASE

--a)Rezolvarea DECODE
SELECT last_name || ' ' || first_name "Nume", hire_date, salary "Salariu initial", 
       salary * DECODE(to_char(hire_date, 'MM'), 3, 1.2, 4, 1.1, 1) "Salariu_marit_DECODE"
FROM employees
WHERE salary > 2000
ORDER BY 2;

--b)Rezolvarea CASE
SELECT last_name || ' ' || first_name "Nume", hire_date, salary "Salariu initial", 
       CASE WHEN to_char(hire_date, 'MM') = 3 THEN salary * 1.2
            WHEN to_char(hire_date, 'MM') = 4 THEN salary * 1.1
            ELSE salary
       END "Salariu_marit_CASE"
FROM employees
WHERE salary > 2000
ORDER BY 2;

--3.Sa se afiseze informatii despre salariatii care castiga mai bine decat cea mai mica medie reala a salariilor pe job-uri in 
-- fromatul urmator: "Angajatul <name> este condus de {<manager_id> | nimeni}. 
SELECT last_name || ' ' || first_name || ' este condus de ' || nvl(to_char(manager_id), 'nimeni')  "Informatii angajat" 
FROM employees
WHERE salary > (SELECT MIN(emp. media_reala)
                FROM (SELECT job_id, AVG(salary) media_reala
                      FROM (SELECT job_id, salary
                            FROM employees)
                GROUP BY job_id) emp);

--4.Sa se afiseze angajatii care au salariul mai mare decat media tututor angajatilor din data de baza si a caror prenume 
--se termina intr-o vocala.
WITH emp(medie_sal) as
     (SELECT AVG(salary)
      FROM employees)
SELECT last_name || ' ' || first_name "Nume angajat", salary
FROM employees, emp
WHERE salary > medie_sal 
  AND (LOWER(first_name) LIKE '%a' 
    OR LOWER(first_name) LIKE '%e' 
    OR LOWER(first_name) LIKE '%i' 
    OR LOWER(first_name) LIKE '%o' 
    OR LOWER(first_name) LIKE '%u');

--5.Sa se afiseze comenzile care se afla in pahare tip 'teacup' sau 'coffecup'
/*
SELECT *
FROM orders
WHERE product_id IN (SELECT product_id FROM products
                     WHERE product_id IN (SELECT product_id FROM drinks
                                          WHERE glass_id IN (SELECT glass_id FROM glasses
                                                             WHERE UPPER(glass_type) LIKE 'TEACUP' 
                                                                OR UPPER(glass_type) LIKE 'COFFEECUP')));
*/                                                               
SELECT *
FROM orders o
WHERE product_id IN (SELECT product_id FROM products p 
                     WHERE o.product_id = p.product_id
                       AND product_id IN (SELECT product_id FROM drinks d
                                          WHERE p.product_id = d.product_id
                                            AND glass_id IN (SELECT glass_id FROM glasses g
                                                             WHERE UPPER(glass_type) LIKE 'TEACUP' 
                                                                OR UPPER(glass_type) LIKE 'COFFEECUP'
                                                                AND d.glass_id = g.glass_id)));

--6.Sa se afiseze toti salariatii care au fost angajati luna trecuta.
SELECT *
FROM employees
WHERE to_char(hire_date, 'MM') LIKE (SELECT to_char(add_months(sysdate, -1), 'MM')
                                     FROM dual);

--7.Sa se afiseze numarul cafenelelor din fiecare oras sub forma "In orasul <city> se afla count<location_id> cafenele."
SELECT 'In orasul ' || city || ' se afla ' || COUNT(location_id) || ' cafenele.' "Informatii"
FROM locations
WHERE location_id IN (SELECT location_id FROM cafes)
GROUP BY city
HAVING COUNT(location_id) = 3
ORDER BY city;


---12. Operatii de actualizare

--1.Sa se mareasca cu 10% salariile angajatilor din cafeneaua cu id 101.
UPDATE employees
SET salary = salary * 1.1
WHERE cafe_id = 101;

--2.Sa se actualizeze salariul maxim din tabelul jobs.
UPDATE jobs
SET max_salary = (SELECT MAX(salary)
                  FROM employees e
                  WHERE jobs.job_id = e.job_id);

--3.Sa se adauge o noua coloana 'amount' in tabelul bills care sa contina suma totala a bonului.
ALTER TABLE bills
ADD amount NUMBER(3);

UPDATE bills 
SET amount = (SELECT SUM(p.price * o.quantity) "amount"
              FROM orders o
              INNER JOIN products p
                      ON p.product_id = o.product_id
              WHERE bills.bill_id = o.bill_id
              GROUP BY o.bill_id);

--verificare
SELECT *
FROM bills;

--4.Sa se moifice data de la bonul cu ID 100 cu data curenta
--a)
UPDATE bills
SET data_bill = (SELECT sysdate
                 FROM dual)
WHERE bill_id = 100;

--b)
UPDATE bills
SET data_bill = sysdate
WHERE bill_id = 100;

/*

SELECT bill_id, SUM(p.price * o.quantity) "amount"
FROM orders o
INNER JOIN products p
        ON p.product_id = o.product_id
GROUP BY o.bill_id;
*/


---17.Afisati numele clientilor care au cumparat cel putin un americano in cel mai scump bon al clientului.
SELECT last_name || ' ' || first_name "Nume clienti"
FROM customers c
JOIN bills b 
  ON b.customer_id = c.customer_id
JOIN orders o
  ON b.bill_id = o.bill_id
JOIN products p
  ON p.product_id = o.product_id
WHERE LOWER(product_name) LIKE 'americano'
  AND b.amount = (SELECT MAX(amount)
                  FROM bills b1
                  WHERE b1.customer_id = c.customer_id);

/*
SELECT b.bill_id, b.data_bill, order_id, product_name, c.last_name, amount
FROM bills b
INNER JOIN orders o ON o.bill_id = b.bill_id
INNER JOIN products p ON p.product_id = o.product_id
inner join customers c on b.customer_id = c.customer_id
order by last_name DESC, amount desc;
*/
