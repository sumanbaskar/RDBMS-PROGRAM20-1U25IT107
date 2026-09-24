-- 1. Create the trigger function
CREATE OR REPLACE FUNCTION log_employee_insert()
RETURNS TRIGGER AS $$
BEGIN
    -- % is replaced dynamically by the inserted employee's name
    RAISE NOTICE 'Employee inserted: %', NEW.emp_name;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Create the AFTER INSERT trigger
DROP TRIGGER IF EXISTS trg_after_employee_insert ON Employee;

CREATE TRIGGER trg_after_employee_insert
AFTER INSERT ON Employee
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();
