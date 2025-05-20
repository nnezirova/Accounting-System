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