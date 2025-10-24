USE university_db;
# a) Basic Queries

-- 1 Counting all students
SELECT COUNT(*) FROM student AS TotalStudents;

-- 2 Counting students by gender
SELECT gender, COUNT(*) AS Total 
FROM student GROUP BY gender;

-- 3  Students admitted in the last two years i.e. 2023 and 2024
SELECT student_name, student_reg_no 
FROM student
WHERE student_reg_no LIKE "%2023%" OR student_reg_no LIKE '%2024%';

-- 4 Counting the number of admissions during the two years
SELECT COUNT(*)
FROM student 
WHERE student_reg_no LIKE '%2023' OR student_reg_no LIKE '%2024%';

-- 5 Students 20 years or younger
SELECT student_name,
	student_reg_no, 
	TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS Age 
FROM student 
WHERE TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) <=20;

-- 6  Counting the number of courses offered at the university
SELECT COUNT(*) FROM course;

-- 7 Showing all the courses offered by the university
SELECT* FROM course;

-- 8 Showing all diploma and Masters courses
SELECT * FROM course 
WHERE course_name LIKE "Diploma%" OR course_name LIKE "Master%";

# b) Sorting, Limiting and Aggregating

-- 1 Top 10 Courses with the highest number of students
SELECT course_code, COUNT(*) AS Total
FROM student
GROUP BY course_code
ORDER BY Total DESC
LIMIT 10;
-- 2 Average Student Age at JKUAT
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()))) FROM student;
-- 3 Top 10 Oldest Students
SELECT student_name, TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS Age
FROM student
ORDER BY Age DESC
LIMIT 10;

# c) Joins

-- 1 Listing students with respective departments and course
SELECT s.student_name, c.course_name, d.department_name
FROM student s
LEFT JOIN course c 
ON s.course_code = c.course_code
LEFT JOIN department d
ON c.department_id = d.department_id;

-- 2 Showing the number of students in each department
SELECT d.department_name, COUNT(s.student_name) AS Total
FROM student s
LEFT JOIN course c ON s.course_code = c.course_code
LEFT JOIN department d ON c.department_id = d.department_id
GROUP BY department_name
ORDER BY Total DESC;

-- 3 Showing the number of students in each school
SELECT sc.school_name,COUNT(s.student_name) AS TotalStudents
FROM student s
LEFT JOIN course c ON s.course_code = c.course_code
LEFT JOIN department d ON c.department_id = d.department_id
LEFT JOIN school sc ON d.school_id = sc.school_id
GROUP BY school_name
ORDER BY TotalStudents DESC;

-- 4 Showing courses with no students enrolled
SELECT c.course_code, c.course_name
FROM student s
LEFT JOIN course c ON c.course_code = s.course_code
WHERE c.course_code IS NULL;

-- 5 Showing departments with no courses
SELECT d.department_id, department_name
FROM student s
LEFT JOIN course c ON c.course_code = s.course_code
LEFT JOIN department d ON d.department_id = c.department_id
WHERE c.course_code IS NULL;

# d) Intermediate SQL Functions: CASE, IN , EXISTS, ANY, HAVING

-- 1 Listing students enrolled in a course that has "Mathematics" in its name
SELECT student_reg_no, student_name
FROM student 
WHERE course_code IN (
	SELECT course_code 
	FROM course WHERE course_name LIKE "%Mathematics%");
        
        /*OR*/

SELECT student_reg_no,student_name
FROM student 
WHERE course_code = ANY (SELECT course_code FROM course WHERE course_name LIKE "%Mathematics%");

             /*OR*/
             
SELECT student_reg_no, student_name
FROM student 
WHERE EXISTS (
	SELECT course_code 
	FROM course WHERE course_name LIKE "%Mathematics%");

-- 2 Comparing the ratio of Male and Female students per course

SELECT c.course_name,
	SUM(CASE WHEN s.gender = "Male" THEN 1 ELSE 0 END) AS Males,
	SUM(CASE WHEN s.gender = "Female" THEN 1 ELSE 0 END) AS Females
FROM student s 
JOIN course c ON c.course_code = s.course_code
GROUP BY course_name;

-- 3 Comparing the age ratios of students across courses
SELECT course_name,
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) =18 THEN 1 ELSE 0 END) AS "18",
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) =19 THEN 1 ELSE 0 END) AS "19",
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) =20 THEN 1 ELSE 0 END) AS "20",
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) =21 THEN 1 ELSE 0 END) AS "21",
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) =22 THEN 1 ELSE 0 END) AS "22",
SUM(CASE WHEN (TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE())) >22 THEN 1 ELSE 0 END) AS OlderThan22
FROM student s 
JOIN course c ON c.course_code = s.course_code
GROUP BY course_name;

-- 4 Listing all students older than 23 years taking bachelors and diploma course
SELECT student_reg_no, 
	student_name,  
    TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS Age
FROM student
WHERE EXISTS (
	SELECT course_code FROM course 
	WHERE course_name LIKE "%Bachelor%" OR "%Diploma%")
AND TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) >=23
ORDER BY Age DESC;

-- 5 Courses with at least 15 students
SELECT c.course_code, c.course_name, COUNT(s.student_reg_no) AS TotalStudents
FROM course c
INNER JOIN student s ON s.course_code = c.course_code 
GROUP BY c.course_code,c.course_name
HAVING TotalStudents>15
ORDER BY TotalStudents ASC;

#e More Advanced and Exciting Queries 😊
-- 1 Top 10 Departments in terms of student population
SELECT d.department_name, COUNT(s.student_reg_no) AS Total
FROM student s
JOIN course c ON c.`course_code` = s.`course_code` -- using backticks here to show off 😊
JOIN department d  ON d.`department_id` = c.`department_id` -- here too 😊
GROUP BY department_name
ORDER BY Total DESC
LIMIT 10;

-- 2 Bottom 3 Schools with the least students
SELECT sk.school_name,COUNT(s.student_reg_no) AS "Total Number of Students" -- using quotaion here to show it works too😎
FROM student s
JOIN course c ON c.course_code = s.course_code 
JOIN department d  ON d.department_id = c.department_id
JOIN school sk ON sk.school_id = d.school_id
GROUP BY  sk.school_name
ORDER BY "Total Number of Students" ASC
LIMIT 3;

-- 3 Courses Ranked by the proportion of female students
SELECT 
	c.course_code,
    c.course_name,
    SUM(CASE WHEN s.gender='Female' THEN 1 ELSE 0 END) AS No_of_Female_Students,
    COUNT(*) AS Total_Students,
	ROUND(SUM(CASE WHEN s.gender='Female' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS female_percentage
FROM student s
JOIN course c ON c.course_code = s.course_code
GROUP BY c.course_code, c.course_name
ORDER BY female_percentage DESC;
    
-- 4 Years Ranked by number of new admisions
SELECT
    RIGHT(student_reg_no, 4) AS "Year",
    COUNT(RIGHT(student_reg_no, 4)) AS Number_of_admissions
FROM student
GROUP BY  RIGHT(student_reg_no, 4)
ORDER BY Number_of_admissions;

-- 5 Course with student older than 24 years
SELECT 
	c.course_code, 
    c.course_name, 
    TIMESTAMPDIFF(Year,s.date_of_birth,CURDATE()) AS Age
FROM student s
JOIN course c ON c.course_code = s.course_code
WHERE TIMESTAMPDIFF(Year,s.date_of_birth,CURDATE()) > 24
ORDER BY Age ASC;

-- END

