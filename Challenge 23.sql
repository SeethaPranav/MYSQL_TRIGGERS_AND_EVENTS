USE SCHOOL;

CREATE TABLE Teachers (
    T_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    T_Name VARCHAR(50) NOT NULL,
    T_Subject VARCHAR(50) NOT NULL,
    Experience INT NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO teachers (T_Name, T_Subject, Experience, Salary) VALUES
('Anil Kumar', 'Mathematics', 7, 65000.00),
('Lalitha Nair', 'Science', 9, 70000.00),
('Ravi Menon', 'English', 5, 55000.00),
('Sreelatha Pillai', 'History', 12, 72000.00),
('Vijayakumar R', 'Geography', 6, 60000.00),
('Geetha Ramesh', 'Biology', 8, 68000.00),
('Mohan Raj', 'Physics', 10, 75000.00),
('Suneetha Varma', 'Chemistry', 4, 53000.00);

SELECT * FROM Teachers;

#1.Create a before insert trigger named before_insert_teacher that will raise an error 
#“salary cannot be negative” if the salary inserted to the table is less than zero. 
DELIMITER $$
CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON Teachers FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END $$
DELIMITER ;

INSERT INTO Teachers (T_Name, T_Subject, Experience, Salary) VALUES
('Anil Kumar', 'Mathematics', 7, -65000.00);


#2. Create an after insert trigger named after_insert_teacher 
#that inserts a row with teacher_id,action, timestamp to a table called teacher_log 
#when a new entry gets inserted to the teacher table. 
#tecaher_id -> column of teacher table, action -> the trigger action, timestamp -> time at
# which the new row has got inserted. 
CREATE TABLE Teacher_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Teacher_id INT NOT NULL,
    L_action VARCHAR(50) NOT NULL,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
    
DROP TABLE Teacher_log;
DELIMITER $$
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON Teachers FOR EACH ROW
BEGIN
    INSERT INTO Teacher_log (Teacher_id, L_action,log_timestamp) VALUES (NEW.T_ID, 'INSERT',NOW());
END $$
DELIMITER ;

INSERT INTO Teachers(T_Name,T_Subject,Experience,Salary) VALUES ('Ishan krishna','Biology',13,55000.00);
INSERT INTO Teachers(T_Name,T_Subject,Experience,Salary) VALUES ('Sooraj Nair','IT',11,98000.00);
SELECT * FROM Teacher_log;
DROP TRIGGER IF EXISTS after_insert_teacher;

#3. Create a before delete trigger that will raise an error when you try to delete a row that has 
#experience greater than 10 years. 
DELIMITER $$
CREATE TRIGGER before_delete_teacher
BEFORE DELETE ON Teachers FOR EACH ROW
BEGIN
    IF OLD.Experience > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete teacher with more than 10 years of experience';
    END IF;
END $$
DELIMITER ;

DELETE FROM Teachers WHERE T_ID = 14; 

#4. Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.
DELIMITER $$
CREATE TRIGGER after_delete_teacher
AFTER DELETE ON Teachers FOR EACH ROW
BEGIN
    INSERT INTO Teacher_log (Teacher_id, L_action,log_timestamp) VALUES (OLD.T_ID, 'DELETE',NOW());
END $$
DELIMITER ;

DROP TRIGGER IF exists after_delete_teacher;
DELETE FROM Teachers WHERE T_ID = 7; 
SELECT * FROM TEACHERS;
SELECT * FROM Teacher_log;
INSERT INTO Teachers(T_Name,T_Subject,Experience,Salary) VALUES ('Soumya Nair','IT',1,30000.00);


