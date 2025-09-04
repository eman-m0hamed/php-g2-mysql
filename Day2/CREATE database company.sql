-- DDL command

drop database if exists company;
CREATE database company;
use company;
CREATE table employee(
    ssn int not null PRIMARY key,
    name varchar(255) not null,
    email varchar(255) not null UNIQUE,
    gender enum('male', 'female') not null default 'male',
    birth_date date null,
    salary decimal(10,2) not null default 0,
    city varchar(255) not null,
    street varchar(255) null,
    department_num int null,
    manager_ssn int null
	
);

CREATE TABLE department(
    number int not null primary key AUTO_INCREMENT,
    name varchar(255) not null,
    manager_ssn int null,
    CONSTRAINT department_manager_fk FOREIGN KEY(manager_ssn) REFERENCES employee(ssn)
    on DELETE set null
    on UPDATE CASCADE
);


create table department_location(
    id int primary key AUTO_INCREMENT, 
    dep_num int not null,
    location varchar(255) not null,
	CONSTRAINT location_department_fk FOREIGN KEY(dep_num) REFERENCES department(number)
    on DELETE CASCADE
    on UPDATE CASCADE

);

create table project (
	number int PRIMARY key AUTO_INCREMENT,
    loaction varchar(255) not null,
    dep_num int not null,
    CONSTRAINT project_department_fk FOREIGN KEY(dep_num) REFERENCES department(number)
    on DELETE CASCADE
    on UPDATE CASCADE
);

create table project_employee(
	project_num int not null,
	employee_ssn int not null,
    PRIMARY key(project_num, employee_ssn),
    CONSTRAINT employee_fk FOREIGN KEY(employee_ssn) REFERENCES employee(ssn)
    on DELETE CASCADE
    on UPDATE CASCADE,
    CONSTRAINT project_fk FOREIGN KEY(project_num) REFERENCES project(number)
    on DELETE CASCADE
    on UPDATE CASCADE
);

alter table employee
    add CONSTRAINT emp_department_fk FOREIGN KEY(department_num) 
        REFERENCES department(number) 
        on DELETE set null
        on UPDATE CASCADE,

    add CONSTRAINT emp_manager_fk FOREIGN KEY(manager_ssn) 
        REFERENCES employee(ssn)
        on DELETE set null
        on UPDATE CASCADE
;



alter table department
drop CONSTRAINT department_manager_fk;

ALTER TABLE department
add CONSTRAINT department_manager_fk FOREIGN key (manager_ssn) 
REFERENCES employee(ssn)
on DELETE set null
on UPDATE CASCADE;


-- inserting data
-- Insert Employees (no department assigned yet)
INSERT INTO employee (ssn, name, email, gender, birth_date, salary, city, street, department_num, manager_ssn) VALUES
(101, 'Ali Hassan', 'ali.hassan@example.com', 'male', '1990-05-12', 5000.00, 'Cairo', 'Street 1', NULL, NULL),
(102, 'Sara Ahmed', 'sara.ahmed@example.com', 'female', '1992-07-22', 6000.00, 'Giza', 'Street 2', NULL, NULL),
(103, 'Omar Khaled', 'omar.khaled@example.com', 'male', '1988-03-15', 7000.00, 'Alexandria', 'Street 3', NULL, NULL),
(104, 'Mona Samir', 'mona.samir@example.com', 'female', '1995-11-10', 5500.00, 'Cairo', 'Street 4', NULL, NULL),
(105, 'Ahmed Tarek', 'ahmed.tarek@example.com', 'male', '1991-01-25', 8000.00, 'Cairo', 'Street 5', NULL, NULL),
(106, 'Laila Nabil', 'laila.nabil@example.com', 'female', '1993-09-14', 6500.00, 'Giza', 'Street 6', NULL, NULL),
(107, 'Mostafa Yasser', 'mostafa.yasser@example.com', 'male', '1987-12-02', 7200.00, 'Alexandria', 'Street 7', NULL, NULL),
(108, 'Nour Hany', 'nour.hany@example.com', 'female', '1996-06-30', 5800.00, 'Cairo', 'Street 8', NULL, NULL),
(109, 'Mahmoud Adel', 'mahmoud.adel@example.com', 'male', '1994-04-18', 6900.00, 'Cairo', 'Street 9', NULL, NULL),
(110, 'Yasmin Fathy', 'yasmin.fathy@example.com', 'female', '1997-02-12', 5400.00, 'Giza', 'Street 10', NULL, NULL);

-- Insert Departments (assign some managers)
INSERT INTO department (name, manager_ssn) VALUES
('HR', 101),
('IT', 102),
('Finance', 103),
('Marketing', 104),
('Sales', 105),
('Logistics', 106),
('Production', 107),
('Research', 108),
('Support', 109),
('Legal', 110);

-- Insert Department Locations
INSERT INTO department_location (dep_num, location) VALUES
-- HR Dept (1) → 3 locations
(1, 'Cairo'),
(1, 'Giza'),
(1, 'Alexandria'),

-- IT Dept (2) → 2 locations
(2, 'Giza'),
(2, 'Cairo'),

-- Finance Dept (3) → 3 locations
(3, 'Alexandria'),
(3, 'Cairo'),
(3, 'Giza'),

-- Marketing Dept (4) → 1 location
(4, 'Cairo'),
-- Sales Dept (5) → 3 locations
(5, 'Cairo'),
(5, 'Alexandria'),
(5, 'Mansoura'),

-- Logistics Dept (6) → 1 locations
(6, 'Giza'),

-- Production Dept (7) → 3 locations
(7, 'Alexandria'),
(7, 'Giza'),
(7, 'Cairo'),

-- Research Dept (8) → 2 locations
(8, 'Cairo'),
(8, 'Alexandria'),

-- Support Dept (9) → 2 locations
(9, 'Giza'),
(9, 'Cairo'),

-- Legal Dept (10) → 3 locations
(10, 'Cairo'),
(10, 'Alexandria'),
(10, 'Ismailia');


-- Insert Projects
INSERT INTO project (loaction, dep_num) VALUES
('Cairo', 1),
('Giza', 2),
('Alexandria', 3),
('Cairo', 4),
('Cairo', 5),
('Giza', 6),
('Alexandria', 7),
('Cairo', 8),
('Giza', 9),
('Cairo', 10);

-- Insert Project Employees
INSERT INTO project_employee (project_num, employee_ssn) VALUES
(1, 101),
(1, 102),
(2, 103),
(2, 104),
(3, 105),
(3, 106),
(4, 107),
(4, 108),
(5, 109),
(5, 110),
(6, 101),
(7, 102),
(8, 103),
(9, 104),
(10, 105);

-- Update employees with departments and managers
UPDATE employee SET department_num = 1, manager_ssn = 101 WHERE ssn IN (101,102);
UPDATE employee SET department_num = 2, manager_ssn = 102 WHERE ssn IN (103,104);
UPDATE employee SET department_num = 3, manager_ssn = 103 WHERE ssn IN (105,106);
UPDATE employee SET department_num = 4, manager_ssn = 104 WHERE ssn IN (107,108);
UPDATE employee SET department_num = 5, manager_ssn = 105 WHERE ssn IN (109,110);

