DROP DATABASE IF EXISTS accounting_system;
CREATE DATABASE accounting_system;
USE accounting_system;

CREATE TABLE positions(
	id INT PRIMARY KEY AUTO_INCREMENT,
    position_name VARCHAR(100) NOT NULL,
    position_description VARCHAR(255) NOT NULL
);
CREATE TABLE employees(
	id INT PRIMARY KEY AUTO_INCREMENT,
    position_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    FOREIGN KEY (position_id) REFERENCES positions(id)
);
CREATE TABLE salary_history(
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10, 2) NOT NULL,
    new_salary DECIMAL(10, 2) NOT NULL,
    change_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
CREATE TABLE employment_history(
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_position_id INT NOT NULL,
    new_position_id INT NOT NULL,
    change_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (old_position_id) REFERENCES positions(id),
    FOREIGN KEY (new_position_id) REFERENCES positions(id)
);
CREATE TABLE payroll(
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
CREATE TABLE bonuses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    bonus_amount DECIMAL(10,2) NOT NULL,
    bonus_reason VARCHAR(255),
    bonus_date DATE NOT NULL,
    approved_by VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
CREATE TABLE expenses(
	id INT PRIMARY KEY AUTO_INCREMENT,
    expense_type VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    expense_date DATE NOT NULL
);
CREATE TABLE accounts(
	id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(255) NOT NULL,
    account_type VARCHAR(255) NOT NULL,
    parent_account_id INT NULL,
    CONSTRAINT FOREIGN KEY (parent_account_id) REFERENCES accounts(id)
);
CREATE TABLE accounting_entries(
	entry_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    entry_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);
CREATE TABLE currency_rates(
	id INT PRIMARY KEY AUTO_INCREMENT,
    currency_code VARCHAR(50) NOT NULL,
    exchange_rate DECIMAL(10, 4) NOT NULL,
    rate_date DATE NOT NULL
);
CREATE TABLE depreciation(
	id INT PRIMARY KEY AUTO_INCREMENT,
    as_set_name VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL,
    depreciation_amount DECIMAL(10,2) NOT NULL
);
CREATE TABLE reports(
	id INT PRIMARY KEY AUTO_INCREMENT,
    report_type VARCHAR(100) NOT NULL,
    report_description TEXT NULL,
    generated_by VARCHAR(100) NOT NULL,
    generated_date DATE NOT NULL,
    report_status ENUM('Draft', 'Final', 'Archived') NOT NULL DEFAULT 'Draft'
);

ALTER TABLE expenses ADD COLUMN account_id INT,
ADD FOREIGN KEY (account_id) REFERENCES accounts(id);

INSERT INTO positions (position_name, position_description) VALUES
('Accountant', 'Handles financial records and transactions'),
('HR Manager', 'Manages employee relations and hiring processes'),
('Software Engineer', 'Develops and maintains software solutions'),
('Marketing Manager', 'Oversees marketing campaigns and branding'),
('Sales Manager', 'Leads sales strategy and team'),
('IT Support', 'Maintains IT infrastructure and user support'),
('Chief Financial Officer (CFO)', 'Oversees all financial aspects of the company'),
('Customer Service Representative', 'Handles customer queries and complaints'),
('Operations Manager', 'Manages daily operations and workflow'),
('Logistics Coordinator', 'Handles supply chain and deliveries');


INSERT INTO employees (position_id, first_name, last_name, hire_date, salary, phone, email, address) VALUES
(1, 'Ivan', 'Petrov', '2021-03-15', 6000.00, '+359888111111', 'ivan.petrov@example.com', 'Sofia'),
(1, 'Diana', 'Nikolova', '2022-05-10', 5800.00, '+359888111112', 'diana.nikolova@example.com', 'Plovdiv'),
(1, 'Stefan', 'Ivanov', '2023-01-01', 6200.00, '+359888111113', 'stefan.ivanov@example.com', 'Varna'),
(2, 'Maria', 'Ivanova', '2019-07-22', 5500.00, '+359888222222', 'maria.ivanova@example.com', 'Burgas'),
(2, 'Hristo', 'Nikolov', '2023-01-25', 5800.00, '+359888555555', 'hristo.nikolov@example.com', 'Ruse'),
(2, 'Viktoria', 'Hristova', '2023-07-19', 5300.00, '+359888999999', 'viktoria.hristova@example.com', 'Stara Zagora'),
(3, 'Georgi', 'Dimitrov', '2020-05-10', 6500.00, '+359888333333', 'georgi.dimitrov@example.com', 'Sofia'),
(3, 'Katerina', 'Petrova', '2021-09-15', 6500.00, '+359888444444', 'katerina.petrova@example.com', 'Plovdiv'),
(4, 'Elena', 'Stoyanova', '2022-02-18', 5800.00, '+359888444444', 'elena.stoyanova@example.com', 'Varna'),
(4, 'Dimitar', 'Todorov', '2020-11-28', 5600.00, '+359888000000', 'dimitar.todorov@example.com', 'Burgas'),
(5, 'Anna', 'Georgieva', '2018-09-05', 4800.00, '+359888666666', 'anna.georgieva@example.com', 'Sofia'),
(5, 'Petar', 'Vasilev', '2017-06-12', 7300.00, '+359888777777', 'petar.vasilev@example.com', 'Plovdiv'),
(6, 'Stefan', 'Kolev', '2016-12-03', 7500.00, '+359888888888', 'stefan.kolev@example.com', 'Varna'),
(6, 'Mihail', 'Simeonov', '2021-01-01', 7500.00, '+359888999998', 'mihail.simeonov@example.com', 'Sofia'),
(7, 'Hristo', 'Nikolov', '2023-01-25', 6200.00, '+359888555555', 'hristo.nikolov@example.com', 'Ruse'),
(7, 'Todor', 'Tanev', '2022-08-14', 6300.00, '+359888444447', 'todor.tanev@example.com', 'Burgas');


INSERT INTO salary_history (employee_id, old_salary, new_salary, change_date) VALUES
(1, 5000.00, 6000.00, '2023-06-01'),
(2, 5200.00, 5500.00, '2023-07-15'),
(3, 5200.00, 5500.00, '2023-07-15'),
(4, 5200.00, 5500.00, '2023-07-15'),
(5, 5800.00, 6500.00, '2024-01-10'),
(6, 5500.00, 5800.00, '2023-08-25'),
(7, 5500.00, 5800.00, '2023-08-25'),
(8, 5500.00, 5800.00, '2023-08-25'),
(9, 5900.00, 6200.00, '2023-10-05'),
(10, 4600.00, 4800.00, '2022-12-12');


INSERT INTO payroll (employee_id, payment_date, amount) VALUES
(1, '2024-03-01', 6000.00),
(2, '2024-03-01', 5500.00),
(3, '2024-03-01', 6500.00),
(4, '2024-03-01', 5800.00),
(5, '2024-03-01', 6200.00),
(6, '2024-03-01', 4800.00),
(7, '2024-03-01', 7300.00),
(8, '2024-03-01', 7500.00),
(9, '2024-03-01', 5300.00),
(10, '2024-03-01', 5600.00);


INSERT INTO bonuses (employee_id, bonus_amount, bonus_reason, bonus_date, approved_by) VALUES
(2, 750.00, 'Exceptional customer feedback', '2024-04-03', 'HR Director'),
(4, 650.00, 'Completed project ahead of schedule', '2024-04-06', 'Manager'),
(5, 800.00, 'High efficiency in operations', '2024-04-07', 'Team Lead'),
(7, 900.00, 'Excellent client retention', '2024-04-10', 'Sales Director'),
(8, 550.00, 'Provided training to new hires', '2024-04-12', 'HR Manager'),
(10, 750.00, 'Led successful marketing campaign', '2024-04-15', 'Marketing Head');


INSERT INTO expenses (expense_type, amount, expense_date) VALUES
('Office Rent', 2500.00, '2024-02-01'),
('Electricity', 500.00, '2024-02-05'),
('Water', 100.00, '2024-02-07'),
('Internet', 200.00, '2024-02-10'),
('Office Supplies', 750.00, '2024-02-12'),
('Travel Expenses', 1300.00, '2024-02-15'),
('Marketing', 3000.00, '2024-02-20'),
('Training', 1200.00, '2024-02-25'),
('Insurance', 2200.00, '2024-02-28'),
('Legal Fees', 1800.00, '2024-03-01');


INSERT INTO currency_rates (currency_code, exchange_rate, rate_date) VALUES
('USD', 1.85, '2024-03-20'),
('EUR', 1.95, '2024-03-20'),
('GBP', 2.25, '2024-03-20'),
('JPY', 0.014, '2024-03-20'),
('AUD', 1.30, '2024-03-20'),
('CAD', 1.42, '2024-03-20'),
('CHF', 2.10, '2024-03-20');

INSERT INTO reports (report_type, report_description, generated_by, generated_date, report_status) VALUES
('Financial Statement', 'Comprehensive financial overview of the company for Q1 2024', 'John Doe', '2024-03-15', 'Final'),
('Payroll Report', 'Detailed payroll data including salaries, taxes, and benefits', 'Jane Smith', '2024-03-16', 'Final'),
('Expense Report', 'Analysis of company expenses for the last fiscal month', 'Robert Brown', '2024-03-17', 'Draft'),
('Income Statement', 'Revenue and expense breakdown for financial forecasting', 'Emily Davis', '2024-03-19', 'Final'),
('Tax Report', 'Tax obligations and deductions for the latest tax period', 'Michael Wilson', '2024-03-20', 'Draft'),
('Cash Flow Report', 'Incoming and outgoing cash movements for operational analysis', 'Sophia Martinez', '2024-03-21', 'Final'),
('Audit Report', 'Internal audit findings and compliance summary', 'Olivia Taylor', '2024-03-23', 'Archived'),
('Operational Report', 'Evaluation of daily business operations and efficiency', 'James White', '2024-03-24', 'Draft');


-- 2
SELECT * FROM employees 
WHERE salary > 7000.00;

-- 3
SELECT position_name AS PositionName, COUNT(employees.id) AS EmployeesCOUNT
FROM employees 
JOIN positions ON employees.position_id = positions.id
GROUP BY position_name;

-- 4
SELECT employees.first_name, employees.last_name, employees.salary, positions.position_name
FROM employees JOIN positions ON employees.position_id = positions.id
WHERE positions.position_name = 'Software Engineer';

-- 5
SELECT 
	employees.first_name, 
    employees.last_name, 
    employees.salary, 
    salary_history.old_salary,
    salary_history.new_salary,
    salary_history.change_date
FROM employees
LEFT OUTER JOIN salary_history ON employees.id = salary_history.employee_id;

-- 6
SELECT employees.first_name, employees.last_name, employees.salary
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT AVG(salary) FROM employees;

-- 7
SELECT positions.position_name AS PositionName, SUM(employees.salary) AS TotalSalaryPerPosition
FROM employees
JOIN positions ON employees.position_id = positions.id
GROUP BY positions.position_name
ORDER BY PositionName
LIMIT 7;

-- 8

DROP TRIGGER IF EXISTS after_salary_update;
USE accounting_system;

DELIMITER $$

CREATE TRIGGER after_salary_update 
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
	IF OLD.salary != NEW.salary THEN
		INSERT INTO salary_history(employee_id, old_salary, new_salary, change_date)
		VALUES (OLD.id, OLD.salary, NEW.salary, CURRENT_DATE());
	END IF;
END $$ 
DELIMITER ;

SELECT * FROM employees;
SELECT * FROM salary_history;
UPDATE employees SET salary = 6400 WHERE id = 10;

-- 9
-- 9. Създайте процедура, в която демонстрирате използване на курсор.

-- CREATE TABLE salary_reports(
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
--     employee_id INT,
--     first_name VARCHAR(255),
--     last_name VARCHAR(255),
--     salary DECIMAL(10, 2),
--     report_date DATE
-- );


-- DROP PROCEDURE IF EXISTS salary_report;

-- DELIMITER $$

-- CREATE PROCEDURE salary_report()
-- BEGIN 
-- 	DECLARE finished INT DEFAULT 0;
--     DECLARE employee_id INT;
--     DECLARE first_name VARCHAR(255);
--     DECLARE last_name VARCHAR(255);
--     DECLARE employee_salary DECIMAL(10, 2);
--     
--     DECLARE reportCursor CURSOR FOR
-- 		SELECT id, first_name, last_name, salary
--         FROM employees
--         WHERE salary > 5000;
--         
-- 	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
--     
--     OPEN reportCursor;

-- 	read_loop: LOOP
-- 		FETCH reportCursor INTO employee_id, first_name, last_name, employee_salary;
--         
-- 		IF finished THEN 
-- 			LEAVE read_loop;
-- 		END IF;
--         
-- 		INSERT INTO salary_reports (employee_id, first_name, last_name, salary, report_date)
--         VALUES (employee_id, first_name, last_name, employee_salary, CURRENT_DATE());
--     END LOOP;
--     
--     CLOSE reportCursor;
-- END $$

-- DELIMITER ;


-- CALL salary_report();

-- second procedure

-- DROP PROCEDURE IF EXISTS bonus_candidates;

-- DELIMITER $$

-- CREATE PROCEDURE bonus_candidates()
-- BEGIN
--     DECLARE finished INT DEFAULT 0;
--     DECLARE employee_id INT;
--     DECLARE employee_salary DECIMAL(10, 2);
--     DECLARE employee_name VARCHAR(255);
--     DECLARE final_amount DECIMAL(10, 2);
--     DECLARE has_error INT DEFAULT 0;

--     DECLARE bonus_cursor CURSOR FOR
--         SELECT id, salary, first_name
--         FROM employees;

--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
--     
-- 	BEGIN
-- 		SET has_error = 1;
-- 		ROLLBACK;
--     END;
--     
--     START TRANSACTION;
--     
--     OPEN bonus_cursor;

--     read_loop: LOOP
--         FETCH bonus_cursor INTO employee_id, employee_salary, employee_name;

--         IF finished THEN
--             LEAVE read_loop;
--         END IF;

-- 		IF employee_salary > 6000 THEN
-- 			SET final_amount = employee_salary * 1.10;
-- 		ELSE 
-- 			SET final_amount = employee_salary * 1.05;
-- 		END IF;
--         
--         INSERT INTO bonuses (
--             employee_id, bonus_amount, bonus_date
--         )
--         VALUES (
--             employee_id, 
--             final_amount,
--             CURRENT_DATE()
--         );

--     END LOOP;

--     CLOSE bonus_cursor;
--     
--     IF has_error = 0 THEN
-- 		COMMIT;
-- 	END IF;
--     
-- END $$

-- DELIMITER ;


-- CALL bonus_candidates();

-- 

DROP PROCEDURE IF EXISTS calculate_employee_bonuses;

DELIMITER $$

CREATE PROCEDURE calculate_employee_bonuses(IN p_bonus_date DATE)
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE employee_id INT;
    DECLARE employee_salary DECIMAL(10, 2);
    DECLARE employee_first_name VARCHAR(255);
    DECLARE employee_last_name VARCHAR(255);
    DECLARE final_amount DECIMAL(10, 2);
    DECLARE has_error INT DEFAULT 0;

    DECLARE bonus_cursor CURSOR FOR
        SELECT id, salary, first_name, last_name
        FROM employees;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'SQL EXCEPTION';
    
    BEGIN
        SET has_error = 1;
        ROLLBACK;
    END;

    CREATE TEMPORARY TABLE temp_bonus_report (
        employee_id INT,
        employee_first_name VARCHAR(255),
        employee_last_name VARCHAR(255),
        bonus_amount DECIMAL(10, 2)
    );

    START TRANSACTION;

    OPEN bonus_cursor;

    read_loop: LOOP
        FETCH bonus_cursor INTO employee_id, employee_salary, employee_first_name, employee_last_name;

        IF finished THEN
            LEAVE read_loop;
        END IF;

        IF employee_salary > 6000 THEN
            SET final_amount = employee_salary * 0.10;
        ELSE
            SET final_amount = employee_salary * 0.05;
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM bonuses 
            WHERE employee_id = employee_id 
              AND bonus_date = p_bonus_date
        ) THEN
            INSERT INTO temp_bonus_report (employee_id, employee_first_name, employee_last_name, bonus_amount)
            VALUES (employee_id, employee_first_name, employee_last_name, final_amount);

            INSERT INTO bonuses (employee_id, bonus_amount, bonus_date)
            VALUES (employee_id, final_amount, p_bonus_date);
        END IF;

    END LOOP;

    CLOSE bonus_cursor;

    IF has_error = 0 THEN
        COMMIT;
    END IF;
    
    SELECT * FROM temp_bonus_report;

END $$

DELIMITER ;


CALL calculate_employee_bonuses('2025-04-23');






