#0
CREATE SCHEMA cjms;
use cjms;

CREATE TABLE planets(
	id	INT	Primary Key AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE spaceports(
	id	INT Primary Key AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	planet_id INT
);

CREATE TABLE spaceships(
	id	INT Primary Key AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	manufacturer VARCHAR(30) NOT NULL,
	light_speed_rate INT DEFAULT 0
);

CREATE TABLE colonists(
	id	INT Primary Key AUTO_INCREMENT,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	ucn	CHAR(10) UNIQUE NOT NULL,
	birth_date DATE NOT NULL
);

CREATE TABLE journeys(
	id	INT	Primary Key AUTO_INCREMENT,
	journey_start DATETIME NOT NULL,
	journey_end	DATETIME NOT NULL,
	purpose	ENUM('Medical', 'Technical', 'Educational', 'Military') NOT NULL,
	destination_spaceport_id INT,
	spaceship_id	INT
);


CREATE TABLE travel_cards(
	id	INT	Primary Key AUTO_INCREMENT,
	card_number	CHAR(10) Unique NOT NULL,
	job_during_journey	ENUM( 'Pilot', 'Engineer', 'Trooper', 'Cleaner', 'Cook') NOT NULL,
	colonist_id	INT,
	journey_id	INT
);


ALTER TABLE spaceports
ADD Constraint fk_spaceports_planets
FOREIGN KEY spaceports(planet_id)
REFERENCES planets(id);

ALTER TABLE journeys
ADD Constraint fk_journeys_spaceports
FOREIGN KEY journeys(destination_spaceport_id)
REFERENCES spaceports(id);

ALTER TABLE journeys
ADD Constraint fk_journeys_spaceships
FOREIGN KEY journeys(spaceship_id)
REFERENCES spaceships(id);

ALTER TABLE travel_cards
ADD Constraint fk_travel_cards_colonists
FOREIGN KEY travel_cards(colonist_id)
REFERENCES colonists(id);

ALTER TABLE travel_cards
ADD Constraint fk_travel_cards_journeys
FOREIGN KEY travel_cards(journey_id)
REFERENCES journeys(id);




#1
insert into travel_cards(card_number, job_during_journey , journey_id)
VALUES (
CASE WHEN (colonist_id>95)
THEN(
	(SELECT

		(CASE
			WHEN (year(c.birth_date)<1980)
		THEN
			(concat(
				year(c.birth_date), 
				RIGHT(c.birth_date, 2), 
				LEFT(ucn, 4)
				)
			)	
		ELSE
			(concat(
				year(c.birth_date), 
				SUBSTRING(c.birth_date, 6,2), 
				RIGHT(ucn, 4)
				)
			)
		END) AS `sss`
    FROM colonists as c
    ),
    
    (SELECT
		(CASE
			WHEN (c.id/2=0)
		THEN
			'Pilot'
		WHEN (c.id/3=0)
		THEN
			'Cook'
		ELSE
			'Engineer'
		END) AS `sss1`
    FROM colonists as c
    ),
    left(c.ucn,1)
    
    )
END);












#2
UPDATE journeys 
	SET `purpose`= (CASE 
						WHEN id % 2 = 0 THEN 'Medical' 
						WHEN id % 3 = 0 THEN 'Technical' 
						WHEN id % 5 = 0 THEN 'Educational' 
						WHEN id % 7 = 0 THEN 'Military' 
						ELSE `purpose`
						END);

#3
DELETE FROM colonists
WHERE id NOT IN (SELECT tr.colonist_id
                   FROM travel_cards tr);



#4
SELECT card_number, job_during_journey
FROM travel_cards
ORDER BY card_number;


#5
SELECT id, concat(first_name, ' ' , last_name) as full_name, ucn
FROM colonists
ORDER BY first_name, last_name, id;

#6
SELECT id, journey_start, journey_end
FROM journeys
WHERE purpose = 'Military'
ORDER BY journey_start;

#7
SELECT c.id, concat(c.first_name, ' ' , c.last_name) as full_name
FROM colonists c
JOIN travel_cards t
ON t.colonist_id = c.id
WHERE t.job_during_journey = 'Pilot'
ORDER BY c.id;

#8
SELECT count(tr.journey_id) as count
FROM journeys as j
join travel_cards as tr
ON tr.journey_id = j.id
WHERE j.purpose = 'Technical';

#9
SELECT sh.name, sp.name
FROM spaceships sh
JOIN journeys as j
ON j.spaceship_id = sh.id
JOIN spaceports as sp
ON j.destination_spaceport_id = sp.id
ORDER BY sh.light_speed_rate DESC
Limit 1;

#10
SELECT Distinct sp.name , sp.manufacturer
FROM colonists as c
JOIN travel_cards as tr
ON tr.colonist_id = c.id
JOIN journeys as j
on tr.journey_id = j.id
join spaceships as sp
ON j.spaceship_id = sp.id
WHERE year(c.birth_date)>1989 AND tr.job_during_journey Like 'Pilot'
ORDER BY sp.name;

#11
SELECT pl.name as `planet_name`, sp.name as `spaceport_name`
FROM journeys as j
JOIN spaceports as sp
ON j.destination_spaceport_id = sp.id
JOIN planets as pl
ON sp.planet_id = pl.id
WHERE j.purpose = 'Educational'
ORDER BY spaceport_name DESC;

#12


#13
SELECT 	jr.id, 
		pl.name as planet_name, 
		sp.name as spaceport_name,
        jr.purpose
FROM 
	(
    SELECT j.id, j.purpose,j.destination_spaceport_id, timestampdiff(SECOND, j.journey_start, j.journey_end) as vreme
	From journeys as j
    ORDER BY vreme
    LIMIT 1
	) as jr
    JOIN journeys as j
    ON j.id = jr.id
    JOIN spaceports as sp
	ON sp.id = j.destination_spaceport_id
	JOIN planets as pl
	ON pl.id=sp.planet_id
    LIMIT 1;

#14
SELECT mtr.job_during_journey as job_name
FROM
	(
    SELECT tr.job_during_journey, count(tr.id), timestampdiff(SECOND, j.journey_start, j.journey_end) as vreme
    FROM travel_cards as tr
    JOIN journeys as j
	ON j.id=tr.journey_id
    GROUP BY tr.job_during_journey
	ORDER BY vreme, tr.job_during_journey
	LIMIT 1
    ) as mtr;

#15
DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet(planet_name VARCHAR (30))
RETURNS INT
BEGIN
    DECLARE result INT;
    
    SET result := 0;
    SET airportcount := 0;
    SET planet_id = p.id;
    
    
    

    
    WHILE (current_index <= word_lenght) DO 
		if(set_of_letters NOT LIKE (concat('%', substr(word, current_index,1), '%'))) THEN
			SET result := 0;
		END IF;
        
        SET current_index := current_index + 1;
    END WHILE;
RETURN result;
END $$

DELIMITER ;

SELECT p.name, udf_count_colonists_by_destination_planet(‘Otroyphus’) AS count
FROM planets AS p
WHERE p.name = ‘Otroyphus’;




