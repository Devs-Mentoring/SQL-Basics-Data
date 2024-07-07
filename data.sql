DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Mentors;
DROP TABLE IF EXISTS TrainingMaterials;
DROP TABLE IF EXISTS Trainings;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Payrolls;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS TrainingsHistory;
DROP TABLE IF EXISTS Notes;
DROP TABLE IF EXISTS CustomersTrainings;
DROP TABLE IF EXISTS MentorsTrainings;

CREATE TABLE Mentors
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    surname TEXT,
    joining_date DATE,
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES Departments(id)
);
CREATE TABLE Customers
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    surname TEXT,
    joining_date DATE,
    gender TEXT,
    mentor_id INTEGER,
    FOREIGN KEY (mentor_id) REFERENCES Mentors(id)
);
CREATE TABLE TrainingMaterials
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    materials_link TEXT
);
CREATE TABLE Trainings
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    training_name TEXT,
    price DOUBLE,
    DURATION INTERVAL,
    training_material_id INTEGER,
    FOREIGN KEY (training_material_id) REFERENCES TrainingMaterials(id)
);
CREATE TABLE Invoices
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    date DATE,
    amount DOUBLE,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);
CREATE TABLE Payments
(
    id INTEGER PRIMARY KEY AUTOINCREMENT ,
    date DATE,
    amount DOUBLE,
    invoice_id INTEGER,
    FOREIGN KEY (invoice_id) REFERENCES Invoices(id)
);
CREATE TABLE Payrolls
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    amount DOUBLE,
    mentor_id INTEGER,
    FOREIGN KEY (mentor_id) REFERENCES Mentors(id)
);
CREATE TABLE Departments
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    city TEXT
);
CREATE TABLE TrainingsHistory
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_start DATE,
    date_end DATE,
    training_id INTEGER,
    customer_id INTEGER,
    mentor_id INTEGER,
    FOREIGN KEY (training_id) REFERENCES Trainings(id),
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (mentor_id) REFERENCES Mentors(id)
);
CREATE TABLE Notes
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE,
    content TEXT,
    trainings_history_id INTEGER,
    FOREIGN KEY (trainings_history_id) REFERENCES TrainingsHistory(id)
);
CREATE TABLE CustomersTrainings
(
    customer_id INT NOT NULL,
    training_id INT NOT NULL,
    PRIMARY KEY (customer_id, training_id),
    FOREIGN KEY (customer_id) REFERENCES Customers (id),
    FOREIGN KEY (training_id) REFERENCES Trainings (id)
);
CREATE TABLE MentorsTrainings
(
    mentor_id INT NOT NULL,
    training_id INT NOT NULL,
    PRIMARY KEY (mentor_id, training_id),
    FOREIGN KEY (mentor_id) REFERENCES Mentors (id),
    FOREIGN KEY (training_id) REFERENCES Trainings (id)
);
-- INSERTS
INSERT INTO
    Departments (name, city)
VALUES
    ('hr', 'Warszawa'),
    ('IT', 'Gdynia')
;
INSERT INTO
    Mentors (name, surname, joining_date, department_id)
VALUES
    ('John', 'Doe', '2023-01-15', 1),
    ('Jane', 'Smith', '2022-11-30', 2),
    ('Michael', 'Johnson', '2023-02-28', 1),
    ('Emily', 'Brown', '2022-10-20', 2)
;
INSERT INTO
    Payrolls (date, amount, mentor_id)
VALUES
    ('2024-01-25', 1000, 1),
    ('2024-02-24', 1500, 2),
    ('2024-03-01', 1000, 3),
    ('2024-03-14', 2000, 4),
    ('2024-05-25', 3000, 1)
;
INSERT INTO
    Customers(name, surname, joining_date, gender, mentor_id)
VALUES
    ('Alice', 'Johnson', '2021-05-10', 'female', 1),
    ('Bob', 'Smith', '2021-06-15', 'male', 2),
    ('Carol', 'Williams', '2022-04-20', 'female', 3),
    ('David', 'Brown', '2023-07-01', 'male', 1)
;
INSERT INTO
    Invoices(name, date, amount, customer_id)
VALUES
    ('FV/001', '2023-05-20', 1250.75, 1),
    ('FV/002', '2023-06-25', 1450.50, 2),
    ('FV/003', '2023-04-30', 1300.00, 3),
    ('FV/004', '2023-07-10', 1150.25, 1)
;
INSERT INTO
    Payments(date, amount, invoice_id)
VALUES
    ('2023-06-11', 1250.75, 1),
    ('2023-06-30', 1450.50, 2),
    ('2023-05-11', 700, 3),
    ('2023-08-11', 600, 3)
;
INSERT INTO
    TrainingMaterials(materials_link)
VALUES
    ('www.sample-url-1.com'),
    ('www.sample-url-2.com'),
    ('www.sample-url-3.com')
;
INSERT INTO
    Trainings(training_name, price, DURATION, training_material_id)
VALUES
    ('Advanced SQL', 199.99, '20 hours', 1),
    ('Data Analysis with Python', 299.99, '60 hours', 2),
    ('Machine Learning Basics', 399.99, '40 hours', 3)
;
INSERT INTO TrainingsHistory
    (date_start, date_end, training_id, customer_id, mentor_id)
VALUES
    ('2023-01-15', '2023-01-20', 1, 1, 1),
    ('2023-02-01', '2023-02-05', 2, 2, 2),
    ('2023-03-10', '2023-03-15', 3, 3, 3),
    ('2023-04-01', '2023-04-05', 3, 1, 1)
;
INSERT INTO
    Notes(date, content, trainings_history_id)
VALUES
    ('2023-01-16', 'Day 1: Introduction to SQL and basic queries.', 1),
    ('2023-01-17', 'Day 2: Advanced SQL techniques.', 1),
    ('2023-02-02', 'Python basics and data analysis libraries.', 2),
    ('2023-02-03', 'Data visualization with Python.', 2),
    ('2023-03-11', 'Introduction to machine learning concepts.', 3),
    ('2023-03-12', 'Supervised vs unsupervised learning.', 3),
    ('2023-04-02', 'Setting up Django and creating models.', 1),
    ('2023-04-03', 'Django views and templates.', 3)
;
INSERT INTO
    CustomersTrainings(customer_id, training_id)
VALUES
    (1,1),
    (1,2),
    (2,2),
    (2,3),
    (3,1),
    (3,3)
;
INSERT INTO
    MentorsTrainings(mentor_id, training_id)
VALUES
    (1,1),
    (1,2),
    (2,2),
    (2,3),
    (3,1),
    (3,3)
;
-- -Wyświetl tylko tych uczniów, którzy dołączyli do mentoringu w 2021 roku
-- oraz oddzielnie tych uczniów, którzy dołączyli między czerwcem
-- a grudniem ubiegłego roku
-- (w celu pobrania aktualnego roku, wykorzystaj odpowiednią funkcję SQL).
SELECT
    *
FROM
    Customers
WHERE
    joining_date LIKE '2021%'
;
SELECT
    *
FROM
    Customers
WHERE
    joining_date
BETWEEN
    date('now', '-1 year', 'start of year', '+5 months')
AND
    date('now', '-1 year', 'start of year', '+11 months', 'start of month', '+0 days')
;
-- -Wyświetl wszystkie informacje o uczniach płci żeńskiej posortowanych rosnąco według imienia
SELECT
    *
FROM
    Customers
WHERE
    gender = 'female'
ORDER BY
    name
;
-- -Wybierz dowolny rekord z tabeli Customers i wyświetl przydzielonego do niego mentora.
-- z użyciem JOIN
SELECT
    *
FROM
    Customers AS c
INNER JOIN
    Mentors AS m
ON
    c.mentor_id = m.id
WHERE
    c.joining_date > '2023-01-01'
;
-- bez użycia JOIN
SELECT
    *
FROM
    Customers AS c,
    Mentors AS m
WHERE
    m.id = c.mentor_id AND
    c.joining_date > '2023-01-01'
;
-- Wyświetl imię, nazwisko oraz staż nauki każdego ucznia. Wyświetlaj dodatkowo napis:
-- “Klient specjalny”, jeśli staż ucznia jest większy równy niż 12 miesięcy,
-- “Normalny klient”, jeśli jest krótszy niż 12 miesięcy. Wykorzystaj CASE.
SELECT
    c.name,
    c.surname,
    CASE
       WHEN c.intership >= 12 THEN 'Klient specjalny'
       WHEN c.intership < 12 THEN 'Normalny klient'
    END AS status
FROM
(
    SELECT
        name,
        surname,
        (strftime('%Y', 'now') - strftime('%Y', joining_date)) * 12 +
        (strftime('%m', 'now') - strftime('%m', joining_date)) AS intership
    FROM
        Customers
    ) AS c
;
-- -Wyświetl podsumowanie w formie tabeli składającej się z imienia, nazwiska
-- oraz sumy wszystkich uiszczonych przez ucznia opłat pod kolumną “Całkowita zapłata”.
SELECT
    c.name,
    c.surname,
    SUM(p.amount) AS "Całkowita zapłata"
FROM
    Customers as c
INNER JOIN Invoices as i ON c.id = i.customer_id
INNER JOIN Payments as p ON i.id = p.invoice_id
GROUP BY
    c.name,
    c.surname
;
-- -Oblicz średnią arytmetyczną wszystkich uiszczonych wpłat z tabeli Payments dla wybranego ucznia
SELECT
    c.name,
    c.surname,
    AVG(p.amount) AS "srednia_wplat"
FROM
    Customers as c
INNER JOIN Invoices as i ON c.id = i.customer_id
INNER JOIN Payments as p ON i.id = p.invoice_id
WHERE
    c.name LIKE 'C%'
GROUP BY
    c.name,
    c.surname
;
-- -Wykonaj SELECT dla 3 dowolnych tabel i wyświetl je jako jedną tabelę przy użyciu UNION.
SELECT id, date, amount FROM Payrolls
UNION ALL
SELECT id, date, amount FROM Invoices
UNION ALL
SELECT id, date, amount FROM Payments
;
-- -Stwórz zapytanie, które wyłuska tabelę zestawiającą każdego klienta ze średnią wartością wszystkich płatności klientów (użyj tabeli CTE)
WITH avg_payments as (
    SELECT
    i.customer_id as c_id,
    avg(p.amount) as avg_customer_payments
FROM Invoices AS i
LEFT JOIN Payments AS p ON i.id = p.invoice_id
GROUP BY customer_id
)
SELECT
    c.id, c.name, c.surname, a.avg_customer_payments
FROM
    Customers AS c
INNER JOIN
    avg_payments AS a ON a.c_id = c.id
;
