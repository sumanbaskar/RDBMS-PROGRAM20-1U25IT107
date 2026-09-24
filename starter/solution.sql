CREATE OR REPLACE FUNCTION log_employee_insert()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Employee inserted: %', NEW.emp_name;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3. Drop existing trigger if present and create the AFTER INSERT trigger
DROP TRIGGER IF EXISTS trg_employee_after_insert ON Employee;

CREATE TRIGGER trg_employee_after_insert
AFTER INSERT ON Employee
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();
