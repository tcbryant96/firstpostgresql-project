--DDL's
CREATE TABLE address(
	address_id serial PRIMARY KEY,
	address varchar(50),
	state varchar(20),
	city varchar(25),
	zipcode integer,
	phone_number varchar(25),
	update_ timestamp DEFAULT current_timestamp
);

SELECT*
FROM address;

CREATE TABLE salesperson(
	employee_id serial PRIMARY KEY,
	first_name varchar(25),
	last_name varchar(25),
	address_id integer NOT NULL,
	FOREIGN KEY(address_id) REFERENCES address(address_id)
);

select*
FROM salesperson;

CREATE TABLE mechanics(
	employee_id serial PRIMARY KEY,
	first_name varchar(25),
	last_name varchar(25),
	address_id integer NOT NULL,
	FOREIGN KEY (address_id) REFERENCES address(address_id)
);

SELECT *
FROM mechanics

CREATE TABLE customer(
	customer_id serial PRIMARY KEY,
	first_name varchar(25),
	last_name varchar(25),
	address_id integer,
	FOREIGN KEY (customer_id) REFERENCES address(address_id)
);

SELECT *
FROM customer;

CREATE TABLE invoice(
	invoice_id serial PRIMARY KEY,
	customer_id integer,
	amount numeric(10,2),
	description TEXT,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE service(
	service_id serial PRIMARY KEY,
	customer_id integer,
	invoice_id integer,
	amount NUMERIC (5,2),
	details TEXT,
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
	);
	
SELECT *
FROM service;

CREATE TABLE service_mechanic(
	service_id integer,
	employee_id integer,
	FOREIGN KEY (service_id) REFERENCES service(service_id),
	FOREIGN KEY (employee_id) REFERENCES mechanics(employee_id)
);

CREATE TABLE car(
	car_id serial PRIMARY KEY,
	make varchar(25),
	model varchar(25),
	amount numeric(10,2)
);


CREATE TABLE car_sale(
	sale_id serial PRIMARY KEY,
	employee_id integer,
	customer_id integer,
	car_id integer,
	invoice_id integer,
	FOREIGN KEY (employee_id) REFERENCES salesperson(employee_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

--DML's
ALTER TABLE car
ADD COLUMN color varchar(25);

SELECT*
FROM car;

INSERT INTO car(make, model, amount, color)
VALUES('Toyota', '4Runner', 42995.00, 'Black');

INSERT INTO car(make, model, amount, color)
VALUES('Hyundai', 'Elantra SE', 16590.99, 'Red');

INSERT INTO car(make, model, amount, color)
VALUES('Honda', 'Odyssey Elite', 20223.99, 'Black');

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('123 fake Street', 'Kentucky', 'Louisville', 40219, '(111) 234-3645');

SELECT *
FROM address;

ALTER TABLE address 
ALTER column zipcode TYPE varchar(10);

UPDATE address
	SET zipcode = '40219'
	WHERE address_id = 1;

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('5555 newberg road', 'Tennessee', 'Nashville', '23234', '(202) 444-7777');

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('9798 anotheraddress road', 'California', 'Los Angeles', '98789', '(143) 467-7789');

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('24332 herewegoagain avenue', 'Kentucky', 'Louisville', '45765', '(234) 544-6565');

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('8989 yes street', 'Kentucky', 'Louisville', '34333', '(222) 4343-6555');

INSERT INTO address(address, state, city, zipcode, phone_number)
VALUES ('7869 hello road', 'California', 'Las Vegas', '48458', '(454) 555-5555');

INSERT INTO salesperson(first_name, last_name, address_id)
VALUES ('Micheal', 'Scott', 1);

INSERT INTO salesperson(first_name, last_name, address_id)
VALUES ('Pam', 'pamalamadimdam', 4);

SELECT*
FROM salesperson;

INSERT INTO mechanics(first_name, last_name, address_id)
VALUES ('Mike', 'Davis', 3);

SELECT*
FROM mechanics;

INSERT INTO mechanics(first_name, last_name, address_id)
VALUES ('Tom', 'Holland', 5);

SELECT*
FROM customer;

INSERT INTO customer(first_name, last_name, address_id)
VALUES ('Denzel', 'Washington', 6);

ALTER TABLE customer 
ADD FOREIGN KEY (address_id) REFERENCES address(address_id);

DELETE FROM customer 
	WHERE customer_id = 3;

INSERT INTO customer(first_name, last_name, address_id)
VALUES ('Mike', 'Myers', 2);

SELECT *
FROM car;

INSERT INTO invoice(customer_id, amount, description)
values(1, 17129, 'Customer bought car' );

SELECT *
FROM invoice;

INSERT INTO invoice(customer_id, amount, description)
VALUES(4, 43760.54, 'Customer bought car');

INSERT INTO car_sale(employee_id, customer_id, car_id, invoice_id)
VALUES(1, 1, 2, 1);

SELECT*
FROM car_sale;

INSERT INTO car_sale(employee_id, customer_id, car_id, invoice_id)
VALUES(2, 4, 3, 2);

INSERT INTO invoice(customer_id, amount, description)
VALUES(1, 69.99, 'Oil Change, premium oil');

INSERT INTO invoice(customer_id, amount, description)
values(4, 220.45, 'Tune up');

SELECT * FROM invoice;

ALTER TABLE  service
ADD COLUMN car_id integer;

ALTER TABLE service 
ADD FOREIGN KEY (car_id) REFERENCES car (car_id);

ALTER TABLE service 
ADD COLUMN update_ timestamp DEFAULT current_timestamp;

SELECT *
FROM service;

INSERT INTO service(customer_id, invoice_id, amount, details, car_id)
VALUES(4, 4, 220.45, 'Customer requested tune up, x y and z was done', 3);

INSERT INTO service(customer_id, invoice_id, amount, details, car_id)
values(1, 3, 69.99, 'Customer wanted premium oil change, brake fluid and window fluid topped off, informed customer air filter was dirty', 2);

SELECT *
FROM mechanics;

INSERT INTO service_mechanic (service_id, employee_id)
values(1, 1);

INSERT INTO service_mechanic (service_id, employee_id)
values(1, 2);

INSERT INTO service_mechanic (service_id, employee_id)
values(2, 1);

SELECT *
FROM service_mechanic;