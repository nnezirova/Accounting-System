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