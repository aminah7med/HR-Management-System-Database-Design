DROP DATABASE IF EXISTS hr;
CREATE DATABASE hr;
USE hr;

CREATE TABLE department (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    DNAME VARCHAR(15) NOT NULL,
    MSRSSN INT,
    STARTDATE DATE
);

CREATE TABLE employee (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    SSN INT UNIQUE,
    BDATE DATE NOT NULL,
    SALARY INT NOT NULL,
    ADDRESS VARCHAR(50),
    FNAME VARCHAR(15),
    MINIT VARCHAR(10),
    LNAME VARCHAR(15),
    SEX VARCHAR(10),
    SUPR_ID INT,
    DEP_ID INT,
    
    CONSTRAINT employee_department 
        FOREIGN KEY (DEP_ID) 
        REFERENCES department(ID)
        ON UPDATE CASCADE 
        ON DELETE SET NULL,
        
    CONSTRAINT employee_manager 
        FOREIGN KEY (SUPR_ID) 
        REFERENCES employee(ID)
        ON UPDATE CASCADE 
        ON DELETE SET NULL
);

CREATE TABLE location (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    LOCATION_NAME VARCHAR(100) NOT NULL,
    CITY VARCHAR(50) NOT NULL
);
CREATE TABLE department_location (
    LOC_ID INT,
    DEP_ID INT,
    
    PRIMARY KEY (LOC_ID, DEP_ID),
    
    CONSTRAINT fk_dep
        FOREIGN KEY (DEP_ID)
        REFERENCES department(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
    CONSTRAINT fk_location
        FOREIGN KEY (LOC_ID)
        REFERENCES location(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE project (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    PROJECT_NAME VARCHAR(50),
    DEP_ID INT,
    LOC_ID INT,
    
    CONSTRAINT project_dep_loc
        FOREIGN KEY (LOC_ID, DEP_ID)
        REFERENCES department_location(LOC_ID, DEP_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE works_on (
    EMP_ID INT,
    PROJ_ID INT,
    HOUR_NUM INT,
    
    PRIMARY KEY (EMP_ID, PROJ_ID),
    
    CONSTRAINT workon_project_fk
        FOREIGN KEY (PROJ_ID)
        REFERENCES project(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
    CONSTRAINT workon_employee_fk
        FOREIGN KEY (EMP_ID)
        REFERENCES employee(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

