-- Create Database
CREATE DATABASE StudentDB;
USE StudentDB;

-- Create Tables
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert Data
INSERT INTO Students VALUES
(1, 'Aman', 20, 'Delhi'),
(2, 'Riya', 21, 'Mumbai'),
(3, 'Karan', 19, 'Delhi'),
(4, 'Neha', 22, 'Pune');

INSERT INTO Courses VALUES
(101, 'SQL', 'Mr. Sharma'),
(102, 'Python', 'Ms. Kapoor'),
(103, 'Excel', 'Mr. Mehta');

INSERT INTO Enrollments VALUES
(1, 1, 101, 85),
(2, 2, 102, 90),
(3, 3, 101, 78),
(4, 4, 103, 88),
(5, 1, 102, 92);

-- Queries

-- 1. View all students
SELECT * FROM Students;

-- 2. Students from Delhi
SELECT * FROM Students WHERE city = 'Delhi';

-- 3. Join query
SELECT s.name, c.course_name, e.marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 4. Average marks per course
SELECT course_id, AVG(marks) AS avg_marks
FROM Enrollments
GROUP BY course_id;

-- 5. Top marks
SELECT s.name, e.marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
ORDER BY e.marks DESC;

-- 6. Students scoring above average
SELECT name FROM Students
WHERE student_id IN (
    SELECT student_id FROM Enrollments
    WHERE marks > (SELECT AVG(marks) FROM Enrollments)
);
