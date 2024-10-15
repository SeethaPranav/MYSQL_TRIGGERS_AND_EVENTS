# MYSQL_TRIGGERS_AND_EVENTS
This repository explores triggers and events in SQL, detailing their functionality for automating tasks and enforcing business rules within the database to ensure data integrity and consistency.

1. Create a before insert trigger named before_insert_teacher that will raise an error 
“salary cannot be negative” if the salary inserted to the table is less than zero.

DELIMITER $$

CREATE TRIGGER before_insert_teacher

BEFORE INSERT ON Teachers FOR EACH ROW

BEGIN
           
IF NEW.Salary < 0 THEN
          
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
             
END IF;
        
END $$
       
DELIMITER ;

INSERT INTO Teachers (T_Name, T_Subject, Experience, Salary) VALUES('Anil Kumar', 'Mathematics', 7, -65000.00); 

![image](https://github.com/user-attachments/assets/b216e31c-abe2-4e6c-8cde-09ce240d3776)

2.Create an after insert trigger named after_insert_teacher that inserts a row with teacher_id,action, timestamp to a table called teacher_log when a new entry gets inserted to the teacher table. teacher_id -> column of teacher table, action -> the trigger action, timestamp -> time at which the new row has got inserted.

CREATE TABLE Teacher_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Teacher_id INT NOT NULL,
    L_action VARCHAR(50) NOT NULL,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Teacher_id) REFERENCES Teachers(T_ID)
);

DELIMITER $$

CREATE TRIGGER after_insert_teacher

AFTER INSERT ON Teachers FOR EACH ROW

BEGIN

  INSERT INTO Teacher_log (Teacher_id, L_action, log_timestamp) VALUES (NEW.T_ID, 'INSERT',NOW());
  
END $$

DELIMITER ;

INSERT INTO Teachers(T_Name,T_Subject,Experience,Salary) VALUES ('Diya krishna','Biology',3,55000.00);

![image](https://github.com/user-attachments/assets/9491914a-5dac-42e2-b88e-7bd80804471f)

3. Create a before delete trigger that will raise an error when you try to delete a row that has experience greater than 10 years.

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

![image](https://github.com/user-attachments/assets/10bfd21c-f3f0-4a3e-b6a8-375ba647b58b)

4. Create an after delete trigger that will insert a row to teacher_log table when that row is deleted from teacher table.
   
DELIMITER $$

CREATE TRIGGER after_delete_teacher

AFTER DELETE ON Teachers FOR EACH ROW

BEGIN

  INSERT INTO Teacher_log (Teacher_id, L_action,log_timestamp) VALUES (OLD.T_ID, 'DELETE',NOW());
  
END $$

DELIMITER ;

DELETE FROM Teachers WHERE T_ID = 7;

SELECT * FROM Teacher_log;

![image](https://github.com/user-attachments/assets/8c07621f-7fd4-49a1-be98-6fd9102b7061)








