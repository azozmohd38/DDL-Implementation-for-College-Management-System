CREATE DATABASE CollegeManagementDB;
GO

USE CollegeManagementDB;
GO

CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name NVARCHAR(100)
);

CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Mobile_no VARCHAR(20),
    Department_id INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name NVARCHAR(100),
    City NVARCHAR(100),
    State NVARCHAR(100),
    Address NVARCHAR(200),
    Pin_code VARCHAR(20),
    No_of_seats INT
);

CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name NVARCHAR(100),
    L_name NVARCHAR(100),
    Name NVARCHAR(200),
    Phone_no VARCHAR(20),
    DOB DATE,
    Department_id INT NULL,
    Hostel_id INT NULL,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);

CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    [Course-name] NVARCHAR(100),
    Duration NVARCHAR(50),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name NVARCHAR(100)
);

CREATE TABLE Exams (
    Exam_code INT PRIMARY KEY,
    [Date] DATE,
    [Time] TIME,
    Room NVARCHAR(50),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

CREATE TABLE FacultyStudent (
    F_id INT NOT NULL,
    S_id INT NOT NULL,
    PRIMARY KEY (F_id, S_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id)
);

CREATE TABLE FacultySubject (
    F_id INT NOT NULL,
    Subject_id INT NOT NULL,
    PRIMARY KEY (F_id, Subject_id),
    FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

CREATE TABLE StudentCourse (
    S_id INT NOT NULL,
    Course_id INT NOT NULL,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);

CREATE TABLE StudentSubject (
    S_id INT NOT NULL,
    Subject_id INT NOT NULL,
    PRIMARY KEY (S_id, Subject_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);

CREATE TABLE StudentExam (
    S_id INT NOT NULL,
    Exam_code INT NOT NULL,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exams(Exam_code)
);
