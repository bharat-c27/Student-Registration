use `mini-project`;

ALTER TABLE students
MODIFY COLUMN phone VARCHAR(10);
   
DROP TRIGGER IF EXISTS trg_validate_email_before_insert;

describe students;


-- email

DELIMITER //
CREATE TRIGGER trg_validate_email_before_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\.[a-zA-Z]{2,}$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format (Eg of email format : xyz@gmail.com)';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_validate_email_before_update
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\.[a-zA-Z]{2,}$' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format (Eg of email format : xyz@gmail.com)';
    END IF;
END;
//
DELIMITER ;


-- phone

DELIMITER //
CREATE TRIGGER check_phone_number_length_before_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN

	IF NEW.phone NOT REGEXP '^[0-9]{10}$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid phone number format. Phone number must be 10 digits.';
    END IF;

    IF CHAR_LENGTH(NEW.phone) != 10 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Phone number must be 10 digit';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_phone_number_length_before_update
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN

	IF NEW.phone NOT REGEXP '^[0-9]{10}$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid phone number format. Phone number must be 10 digits.';
    END IF;

    IF CHAR_LENGTH(NEW.phone) != 10 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Phone number must be 10 digit';
    END IF;
END;
//
DELIMITER ;


-- gender

DELIMITER //
CREATE TRIGGER trg_check_gender_before_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
    IF NEW.gender NOT IN ('male', 'female') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Enter gender male or female only';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_check_gender_before_update
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
    IF NEW.gender NOT IN ('male', 'female') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Enter gender male or female only';
    END IF;
END;
//
DELIMITER ;

-- constraints

UPDATE students
SET roll = 0 
WHERE roll IS NULL;

ALTER TABLE students
DROP CONSTRAINT check_email_format;

ALTER TABLE students
ADD CONSTRAINT check_phone_format CHECK (phone REGEXP '^[0-9]{10}$');

ALTER TABLE students
ADD CONSTRAINT chk_gender CHECK (gender IN ('male', 'female'));

ALTER TABLE students
ADD CONSTRAINT check_email_format CHECK (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\.[a-zA-Z]{2,}$');
