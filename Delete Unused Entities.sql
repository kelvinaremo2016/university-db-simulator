/*This file contains the code that deleted some tables from the database to reduce 
to a reasonable size for practice */

USE university_db;

-- Deleting departments where courses are hard to find online
SET SQL_SAFE_UPDATES = 0
-- 1. School of Medicine
DELETE FROM department 
WHERE department_name 
IN ('Department of Child Health and Paedetrics',
'Department of Critical Care and Anaesthesiology',
'Department of Pathology',
'Department of Obstetrics and Gynaecology',
'Department of Rehabilitative Sciences',
'Department of Internal Medicine and Therapeutics'
);

-- 2. School of Pharmacy
DELETE FROM department 
WHERE department_name 
IN ('Departmet of Pharmacology and Pharmacognosy');

-- Deleting some parts of the database since it's too big
DELETE FROM department 
WHERE department_name 
IN ('Departmet of Pharmacology and Pharmacognosy');

-- Deleting departments without courses 
DELETE d
FROM department d
LEFT JOIN course c
 ON d.department_id = c.department_id
WHERE c.course_code IS NULL;

-- Deleting schools without departments
DELETE s
FROM school s
LEFT JOIN department d
 ON s.school_id = d.school_id
WHERE department_id IS NULL;

-- Deleting colleges without schools
DELETE c
FROM college c
LEFT JOIN school s
 ON c.college_id = s.college_id
WHERE school_id IS NULL;

-- Calling Colleges, Schools, Departments and Courses
SELECT c. college_name AS College,
		s.school_name AS School,
        d.department_name AS Department,
        m.course_name AS Course
FROM college c
LEFT JOIN school s
 ON c.college_id = s.college_id
LEFT JOIN department d
 ON s.school_id = d.school_id
LEFT JOIN course m
 ON d.department_id = m.department_id;

  