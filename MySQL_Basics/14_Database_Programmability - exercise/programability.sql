

#3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (input_str VARCHAR(50))
BEGIN
	DECLARE town_wildcard VARCHAR(50);
    SET town_wildcard := concat(input_str, '%');
    
    SELECT t.name
    FROM towns t
    WHERE lower(t.name) LIKE lower(town_wildcard)
    ORDER BY t.name;
END $$

DELIMITER ;

CALL usp_get_towns_starting_with ('b');



#7
SET GLOBAL log_bin_trust_function_creators =1;

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
BEGIN
	DECLARE word_lenght INT(11);
    DECLARE result BIT;
    DECLARE current_index INT(11);
    
    SET result := 1;
    SET word_lenght := char_length(word);
    SET current_index :=1;
    
    WHILE (current_index <= word_lenght) DO 
		if(set_of_letters NOT LIKE (concat('%', substr(word, current_index,1), '%'))) THEN
			SET result := 0;
		END IF;
        
        SET current_index := current_index + 1;
    END WHILE;
RETURN result;
END $$

DELIMITER ;
SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');













#15
CREATE TABLE logs(
log_id INT(11) PRIMARY KEY AUTO_INCREMENT,
account_id INT(11),
old_sum DECIMAL(19,4),
new_sum DECIMAL(19,4)
);


DELIMITER $$
CREATE trigger tr_logs
AFTER UPDATE 
ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO logs(account_id, old_sum, new_sum)
    VALUES (
		OLD.id,
        OLD.balance,
        NEW.balance
    );
END $$

DELIMITER ;

UPDATE accounts
SET balance = balance+10
WHERE id=1;

SELECT * FROM logs;