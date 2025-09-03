-- DDL command
CREATE database company;
use company;
CREATE table employee(
    ssn int not null PRIMARY key,
    name varchar(255) not null,
    gender enum('male', 'female') not null default 'male',
    birth_date date null,
    salary decimal(3,2) not null default 0,
    city varchar(255) not null,
    street varchar(255) null,
    department_num int not null,
    manager_ssn int not null
	
);

CREATE TABLE department(
    number int not null primary key AUTO_INCREMENT,
    name varchar(255) not null,
    manager_ssn int null,
    CONSTRAINT department_manager_fk FOREIGN KEY(manager_ssn) REFERENCES employee(ssn)
);


create table department_location(
    id int primary key AUTO_INCREMENT, 
    dep_num int not null,
    location varchar(255) not null,
	CONSTRAINT location_department_fk FOREIGN KEY(dep_num) REFERENCES department(number)

);

create table project (
	number int PRIMARY key AUTO_INCREMENT,
    loaction varchar(255) not null,
    dep_num int not null,
    CONSTRAINT project_department_fk FOREIGN KEY(dep_num) REFERENCES department(number)
);

create table project_employee(
	project_num int not null,
	employee_ssn int not null,
    PRIMARY key(project_num, employee_ssn),
    CONSTRAINT employee_fk FOREIGN KEY(employee_ssn) REFERENCES employee(ssn),
    CONSTRAINT project_fk FOREIGN KEY(project_num) REFERENCES project(number)
);

alter table employee
    add CONSTRAINT emp_department_fk FOREIGN KEY(department_num) 
       REFERENCES department(number),

    add CONSTRAINT emp_manager_fk FOREIGN KEY(manager_ssn) 
        REFERENCES employee(ssn),

     add COLUMN email varchar(255) not null UNIQUE,          
     MODIFY column salary int not null default 0,
     drop column street
;



alter table department
drop CONSTRAINT department_manager_fk;

ALTER TABLE department
add CONSTRAINT department_manager_fk FOREIGN key (manager_ssn) 
REFERENCES employee(ssn)
on DELETE set null
on UPDATE CASCADE;



alter table employee
drop CONSTRAINT emp_department_fk;

ALTER TABLE employee
 add CONSTRAINT emp_department_fk FOREIGN KEY(department_num) 
REFERENCES department(number)
on DELETE CASCADE
on UPDATE CASCADE;


-- DML Command

insert into employee (ssn, name, email, birth_date, gender, city, department_num) 
values(10, 'eman', 'eman@gmail.com', '2000/10/10', 'female', 'cairo', 2 ),
(15, 'eman', 'emanmohamd@gmail.com', '2000/10/1', 'female', 'giza', 7 );

update department set manager_ssn=10 where number=3;

update department set manager_ssn=20 where manager_ssn is null;


update employee set salary= salary*0.10 + salary, department_num=3  where salary<1000;

delete from employee;  -- remove all data from table

delete from employee where manager_ssn is null and salary<1000; 

select * from department; --  select all column and all data
SELECT * FROM `department` where manager_ssn in (10, 20, 15, 30);
SELECT * FROM `department` where manager_ssn BETWEEN 10 and 20;

SELECT * FROM `employee` where email like "%gmail%";
select count(number) from department where manager_ssn is null;
SELECT min(salary) FROM `employee`;
SELECT * FROM `department` order by name desc;