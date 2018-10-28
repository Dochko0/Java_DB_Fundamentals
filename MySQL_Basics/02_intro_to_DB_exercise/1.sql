CREATE schema minions;
USE minions;

create table minions(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT(11)    
);

CREATE TABLE towns(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
);

DROP TABLE minions,towns;

use pesho_db;

SELECT * FROM people;

CREATE TABLE users(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB(900),
    last_login_time DATETIME,
    is_deleted BIT
);

INSERT INTO users(username, password, profile_picture, last_login_time, is_deleted) 
	VALUES
		('Pesho', '123',NULL, date(now()), 1),
		('Gosho', '123', NULL, date(now()), 0),
		('Krum', '123', NULL, date(now()), 1),
		('Asia', '123', NULL, date(now()), 0),
		('Ani', '123', NULL, date(now()), 1);



DROP TABLE users;

SELECT *FROM users;

ALTER TABLE users
MODIFY COLUMN id INT(11);

ALTER TABLE users
DROP PRIMARY KEY;

ALTER TABLE users
ADD PRIMARY KEY (id, username);

ALTER TABLE users
CHANGE COLUMN `last_login_time` last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;


ALTER TABLE users 
MODIFY id BIGINT NOT NULL;

ALTER TABLE users 
DROP PRIMARY KEY;

ALTER TABLE users 
ADD CONSTRAINT pk_users PRIMARY KEY(id);

ALTER TABLE users 
ADD CONSTRAINT pk_username UNIQUE (username);

CREATE SCHEMA movies;
USE movies;

CREATE TABLE directors(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT
);
INSERT INTO directors (id, director_name, notes)
	VALUES
		(1, 'name1', 'aaa'),
		(2, 'name2', 'aaa'),
		(3, 'name3', 'aaa'),
		(4, 'name4', 'aaa'),
		(5, 'name5', 'aaa');
        
CREATE TABLE genres(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT
);
INSERT INTO genres (id, genre_name, notes)
	VALUES
		(1, 'genre1', 'aaa'),
		(2, 'genre2', 'aaa'),
		(3, 'genre3', 'aaa'),
		(4, 'genre4', 'aaa'),
		(5, 'genre5', 'aaa');
        
CREATE TABLE categories(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT
);
INSERT INTO categories (id, category_name, notes)
	VALUES
		(1, 'category1', 'aaa'),
		(2, 'category2', 'aaa'),
		(3, 'category3', 'aaa'),
		(4, 'category4', 'aaa'),
		(5, 'category5', 'aaa');

CREATE TABLE movies(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT(11) NOT NULL,
    copyright_year YEAR,
    length TIME,
    genre_id INT(11) NOT NULL,
    category_id INT(11) NOT NULL,
    rating DOUBLE(2,1),
    notes TEXT
);
INSERT INTO movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
	VALUES
		(1, 'title1', 2, 1910, '01:00:02', 2, 2, 1.1, 'bbb'),
		(2, 'title2', 1, 1911, '02:00:01', 1, 1, 1.2, 'bbb'),
		(3, 'title3', 4, 1912, '01:20:01', 4, 4, 1.3, 'bbb'),
		(4, 'title4', 3, 1913, '01:00:21', 3, 3, 1.4, 'bbb'),
        (5, 'title5', 5, 1914, '01:03:01', 5, 5, 1.5, 'bbb');

ALTER TABLE movies
ADD CONSTRAINT fk_movies_director FOREIGN KEY(director_id) REFERENCES directors(id);

ALTER TABLE movies
ADD CONSTRAINT fk_movies_genre FOREIGN KEY(genre_id) REFERENCES genres(id);

ALTER TABLE movies
ADD CONSTRAINT fk_movies_category FOREIGN KEY(category_id) REFERENCES categories(id);

SELECT * FROM movies;


CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories(
	id INT(11) AUTO_INCREMENT not null PRIMARY KEY,
    category VARCHAR(50) not NULL,
    daily_rate DOUBLE(3,1) NOT NULL,
    weekly_rate DOUBLE(3,1) NOT NULL,
    monthly_rate DOUBLE(3,1) NOT NULL,
    weekend_rate DOUBLE(3,1) NOT NULL
);

INSERT INTO categories(id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
	VALUES
		(1, 'van', 12.1, 10.1, 09.1, 55.1),
		(2, 'bus', 13.1, 11.1, 10.1, 85.1),
		(3, 'kupe', 14.1, 12.1, 22.1, 65.1);

CREATE TABLE cars(
	id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    plate_number INT,
    make VARCHAR(50),
    model VARCHAR(50),
    car_year INT(4) NOT NULL,
    category_id INT(11) NOT NULL,
    doors INT(1) NOT NULL,
    picture BLOB,
    car_condition ENUM('new' , 'used') NOT NULL,
    available BIT NOT NULL    
);
INSERT INTO cars(id, car_year, category_id, doors, car_condition, available)
	VALUES
		(1, 1900, 2, 4, 'new', 1),
		(2, 1901, 3, 5, 'used', 0),
		(3, 1902, 1, 6, 'new', 1);


CREATE TABLE employees(
	id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);
INSERT INTO employees(id, first_name, last_name)
	VALUES
		(1, 'Krum', 'Krumov'),
		(2, 'Ivan', 'Ivanov'),
		(3, 'Kiril', 'Kirilov');

CREATE TABLE customers(
	id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    driver_licence_number VARCHAR(50),
    full_name VARCHAR(50) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    zip_code INT(11),
    notes TEXT
);
INSERT INTO customers(id, full_name)
	VALUES
		(1, 'Nqkoi Nqkoi'),
		(2, 'Nikoi Nikoi'),
		(3, 'koi koi');

CREATE TABLE rental_orders(
	id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id int(11) not null,
    customer_id INT(11) not NULL,
    car_id INT(11) NOT NULL,
    car_condition ENUM('new', 'used') NOT NULL,
    tank_level INT(11),
    kilometrage_start INT(11),
    kilometrage_end INT(11),
    total_kilometrage INT,
    start_date INT,
    end_date INT,
    total_days INT,
    rate_applied TEXT,
    tax_rate INT,
    order_status BIT,
    notes TEXT
);
INSERT INTO rental_orders(id, employee_id, customer_id, car_id, car_condition)
	VALUES
		(1, 1, 1, 1, 'new'),
		(2, 2, 2, 2, 'used'),
		(3, 1, 1, 1, 'new');


CREATE DATABASE hotel;
USE hotel;

CREATE TABLE employees(
	id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);
INSERT INTO employees(id, first_name, last_name)
	VALUES
		(1, 'aaa', 'bbb'),
		(2, 'ccc', 'dd'),
		(3, 'eee', 'ggg');
        
CREATE TABLE customers(
	account_number INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50),
    emergency_name VARCHAR(50),
    emergency_number INT,
    notes TEXT
);
INSERT INTO customers(account_number, first_name, last_name)
	VALUES
		(1, 'aaa', 'bbb'),
		(2, 'ccc', 'dd'),
		(3, 'eee', 'ggg');


CREATE TABLE room_status(
	room_status VARCHAR(50) NOT NULL PRIMARY KEY,
    notes TEXT
);
INSERT INTO room_status(room_status)
	VALUES
		('da'),
		('maybe'),
		('ne');

CREATE TABLE room_types(
	room_type VARCHAR(50) NOT NULL PRIMARY KEY,
    notes TEXT
);
INSERT INTO room_types(room_type)
	VALUES
		('edno'),
		('dve'),
		('tri');

CREATE TABLE bed_types(
	bed_type VARCHAR(50) NOT NULL PRIMARY KEY,
    notes TEXT
);
INSERT INTO bed_types(bed_type)
	VALUES
		('edinicheno'),
		('spalnq'),
		('dve legla');

CREATE TABLE rooms(
	room_number INT NOT NULL PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    rate INT,
    room_status VARCHAR(50) NOT NULL,
    notes TEXT
);
INSERT INTO rooms(room_number, room_type, bed_type, room_status)
	VALUES
		(1, 'dno', 'edinichno', 'da'),
		(2, 'dve', 'dvoino', 'da'),
		(3, 'dve', 'dve legla', 'da');

CREATE TABLE payments(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id INT(11) NOT NULL,
    payment_date DATETIME,
    account_number INT(11) NOT NULL,
    first_date_occupied DATETIME,
    last_date_occupied DATETIME,
    total_days INT,
    amount_charged INT,
    tax_rate INT,
    tax_amount INT,
    payment_total INT,
    notes TEXT
);
INSERT INTO payments(id, employee_id, account_number)
	VALUES
		(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3);

CREATE TABLE occupancies(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id INT NOT NULL,
    date_occupied DATETIME,
    account_number INT(11),
    room_number INT,
    rate_applied VARCHAR(50),
    phone_charge TEXT,
    notes TEXT
);
INSERT INTO occupancies(id, employee_id)
	VALUES
		(1, 1),
		(2, 2),
		(3, 3);


CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE towns(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    

);














