-- 9

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