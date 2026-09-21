
IF DB_ID(N'CollegeManagementDB') IS NULL CREATE DATABASE CollegeManagementDB;
GO
USE CollegeManagementDB;
GO

CREATE TABLE Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Hostel (
    HostelID INT IDENTITY(1,1) PRIMARY KEY,
    HostelName NVARCHAR(100) NOT NULL UNIQUE,
    NumberOfSeats INT NOT NULL CHECK (NumberOfSeats >= 0)
);

CREATE TABLE Course (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(120) NOT NULL UNIQUE,
    DurationMonths INT NOT NULL CHECK (DurationMonths > 0),
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Course_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Faculty (
    FacultyID INT IDENTITY(1,1) PRIMARY KEY,
    FacultyName NVARCHAR(120) NOT NULL,
    MobileNumber VARCHAR(20) NULL,
    Salary DECIMAL(12,2) NOT NULL CHECK (Salary >= 0),
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Faculty_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

CREATE TABLE Student (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(60) NOT NULL,
    LastName NVARCHAR(60) NOT NULL,
    DOB DATE NOT NULL,
    PhoneNumber VARCHAR(20) NULL,
    DepartmentID INT NOT NULL,
    HostelID INT NULL,
    CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID),
    CONSTRAINT FK_Student_Hostel FOREIGN KEY (HostelID)
        REFERENCES Hostel(HostelID)
);

CREATE TABLE Subject (
    SubjectID INT IDENTITY(1,1) PRIMARY KEY,
    SubjectName NVARCHAR(120) NOT NULL UNIQUE,
    CourseID INT NOT NULL,
    CONSTRAINT FK_Subject_Course FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

CREATE TABLE StudentCourse (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT PK_StudentCourse PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT FK_StudentCourse_Student FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_StudentCourse_Course FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

CREATE TABLE FacultySubject (
    FacultyID INT NOT NULL,
    SubjectID INT NOT NULL,
    CONSTRAINT PK_FacultySubject PRIMARY KEY (FacultyID, SubjectID),
    CONSTRAINT FK_FacultySubject_Faculty FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID),
    CONSTRAINT FK_FacultySubject_Subject FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
);

CREATE TABLE StudentSubject (
    StudentID INT NOT NULL,
    SubjectID INT NOT NULL,
    CONSTRAINT PK_StudentSubject PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT FK_StudentSubject_Student FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    CONSTRAINT FK_StudentSubject_Subject FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
);

CREATE TABLE Exam (
    ExamCode INT IDENTITY(1,1) PRIMARY KEY,
    SubjectID INT NOT NULL,
    ExamDate DATE NOT NULL,
    ExamTime TIME NOT NULL,
    Room NVARCHAR(30) NOT NULL,
    CONSTRAINT FK_Exam_Subject FOREIGN KEY (SubjectID)
        REFERENCES Subject(SubjectID)
);

GO
CREATE OR ALTER VIEW StudentWithAge AS
SELECT StudentID, FirstName, LastName, DOB,
       DATEDIFF(YEAR, DOB, GETDATE())
       - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, DOB, GETDATE()), DOB) > CAST(GETDATE() AS DATE)
              THEN 1 ELSE 0 END AS Age
FROM Student;
GO


