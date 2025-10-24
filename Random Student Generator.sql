USE university_db;
SET sql_safe_updates = 0;

-- ====================================================
-- insert_students.sql
-- Auto-generate 650 students, admission years 2021-2024
-- Inserts into table `student` (student_reg_no PRIMARY KEY)
-- ====================================================

-- 1) Temporary name pools
DROP TEMPORARY TABLE IF EXISTS male_first_names;
CREATE TEMPORARY TABLE male_first_names (name VARCHAR(50));
INSERT INTO male_first_names (name) VALUES
('John'),('James'),('David'),('Joseph'),('Peter'),('Paul'),('Michael'),('Robert'),
('William'),('Richard'),('Stephen'),('Thomas'),('Charles'),('Daniel'),('Brian'),
('Kevin'),('Eric'),('Anthony'),('Mark'),('Simon'),('Andrew'),('Patrick'),('George'),
('Edward'),('Martin'),('Samuel'),('Isaac'),('Victor'),('Kennedy'),('Dennis'),
('Benjamin'),('Collins'),('Evans'),('Francis'),('Gabriel'),('Henry'),('Ian'),
('Jacob'),('Kelvin'),('Luke'),('Moses'),('Nathan'),('Oscar'),('Philip'),('Ronald'),
('Steve'),('Tony'),('Vincent'),('Wycliffe');

DROP TEMPORARY TABLE IF EXISTS female_first_names;
CREATE TEMPORARY TABLE female_first_names (name VARCHAR(50));
INSERT INTO female_first_names (name) VALUES
('Mary'),('Grace'),('Sarah'),('Joyce'),('Esther'),('Ann'),('Jane'),('Alice'),
('Margaret'),('Elizabeth'),('Ruth'),('Mercy'),('Faith'),('Hope'),('Charity'),
('Catherine'),('Lucy'),('Rose'),('Susan'),('Nancy'),('Dorcas'),('Beatrice'),
('Irene'),('Monica'),('Patricia'),('Agnes'),('Christine'),('Diana'),('Eunice'),
('Florence'),('Hannah'),('Jackline'),('Karen'),('Linda'),('Martha'),('Naomi'),
('Priscilla'),('Rachel'),('Sandra'),('Teresa'),('Ursula'),('Veronica'),('Winnie'),
('Zipporah'),('Brenda'),('Caroline'),('Deborah'),('Edith');

DROP TEMPORARY TABLE IF EXISTS last_names;
CREATE TEMPORARY TABLE last_names (name VARCHAR(50));
INSERT INTO last_names (name) VALUES
('Mwangi'),('Maina'),('Kariuki'),('Kamau'),('Njoroge'),('Kibet'),('Kipchoge'),
('Omondi'),('Otieno'),('Odhiambo'),('Ochieng'),('Okoth'),('Nyong''o'),('Kenyatta'),
('Odinga'),('Ruto'),('Musalia'),('Wetangula'),('Kalonzo'),('Saitoti'),
('Kiptanui'),('Korir'),('Langat'),('Chebet'),('Jepkosgei'),('Kiprop'),('Kiplagat'),
('Kosgei'),('Rotich'),('Sang'),('Mutai'),('Kipruto'),('Soi'),('Komen'),('Ngeny'),
('Biwott'),('Tanui'),('Keter'),('Kipketer'),('Limuru'),('Nyambura'),('Wanjiru'),
('Wairimu'),('Wambui'),('Nyaguthii'),('Akinyi'),('Atieno'),('Achieng'),('Adhiambo'),
('Anyango');

-- 2) Temporary storage for generated students
DROP TEMPORARY TABLE IF EXISTS temp_students;
CREATE TEMPORARY TABLE temp_students (
  student_reg_no VARCHAR(30),
  student_name VARCHAR(255),
  gender ENUM('Male','Female'),
  date_of_birth DATE,
  course_code VARCHAR(10)
);

-- 3) Helper function: random DOB for ages 18-25
DELIMITER //
DROP FUNCTION IF EXISTS random_dob_student//
CREATE FUNCTION random_dob_student() RETURNS DATE
DETERMINISTIC
BEGIN
  DECLARE age INT;
  DECLARE dob DATE;
  SET age = FLOOR(18 + RAND() * 8); -- 18..25 inclusive
  SET dob = DATE_SUB(CURDATE(), INTERVAL age YEAR);
  SET dob = DATE_SUB(dob, INTERVAL FLOOR(RAND() * 365) DAY);
  RETURN dob;
END//
DELIMITER ;

-- 4) Stored procedure to generate exactly 650 students
DELIMITER //
DROP PROCEDURE IF EXISTS Generate650Students//
CREATE PROCEDURE Generate650Students()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE c_code VARCHAR(10);
  DECLARE c_name VARCHAR(255);
  DECLARE course_level VARCHAR(20);
  DECLARE students_to_add INT;
  DECLARE total_generated INT DEFAULT 0;
  DECLARE seq_num INT DEFAULT 1001; -- sequence used in reg number
  DECLARE adm_year INT;
  
  DECLARE course_cursor CURSOR FOR
    SELECT course_code, course_name FROM course;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  OPEN course_cursor;
  
  course_loop: LOOP
    FETCH course_cursor INTO c_code, c_name;
    IF done = 1 THEN
      LEAVE course_loop;
    END IF;
    
    -- determine course level by name heuristics
    IF c_name LIKE 'Bachelor%' THEN
      SET course_level = 'Bachelor';
      SET students_to_add = FLOOR(10 + RAND() * 11); -- 10..20
    ELSEIF c_name LIKE 'Master%' OR c_name LIKE 'MSc%' OR c_name LIKE 'Master of%' THEN
      SET course_level = 'Master';
      SET students_to_add = FLOOR(4 + RAND() * 7); -- 4..10
    ELSEIF c_name LIKE 'Ph.D%' OR c_name LIKE 'PhD%' OR c_name LIKE 'Doctor%' THEN
      SET course_level = 'PhD';
      SET students_to_add = FLOOR(3 + RAND() * 3); -- 3..5
    ELSEIF c_name LIKE 'Diploma%' THEN
      SET course_level = 'Diploma';
      SET students_to_add = FLOOR(4 + RAND() * 8); -- 4..11
    ELSEIF c_name LIKE 'Certificate%' THEN
      SET course_level = 'Certificate';
      SET students_to_add = FLOOR(3 + RAND() * 4); -- 3..6
    ELSE
      SET course_level = 'Other';
      SET students_to_add = FLOOR(3 + RAND() * 8); -- 3..10
    END IF;
    
    -- loop adding students for this course, but stop once we reach 650
    WHILE students_to_add > 0 AND total_generated < 650 DO
      -- random gender and pick name accordingly
      IF RAND() > 0.5 THEN
        SET @gender := 'Male';
        SELECT name INTO @first FROM male_first_names ORDER BY RAND() LIMIT 1;
      ELSE
        SET @gender := 'Female';
        SELECT name INTO @first FROM female_first_names ORDER BY RAND() LIMIT 1;
      END IF;
      SELECT name INTO @last FROM last_names ORDER BY RAND() LIMIT 1;
      SET @fullname := CONCAT(@first, ' ', @last);
      
      -- random dob
      SET @dob := random_dob_student();
      -- random admission year 2021..2024
      SET adm_year = 2021 + FLOOR(RAND() * 4);
      -- reg number
      SET @reg := CONCAT(c_code, '-', LPAD(seq_num,4,'0'), '/', adm_year);
      
      -- insert into temp
      INSERT INTO temp_students(student_reg_no, student_name, gender, date_of_birth, course_code)
      VALUES (@reg, @fullname, @gender, @dob, c_code);
      
      SET seq_num = seq_num + 1;
      SET total_generated = total_generated + 1;
      SET students_to_add = students_to_add - 1;
    END WHILE;
    
    -- if we've reached the required total, break out
    IF total_generated >= 650 THEN
      LEAVE course_loop;
    END IF;
    
  END LOOP;
  
  CLOSE course_cursor;
  
  -- If loop finished but total < 650 (e.g., too few courses), add random assignments from available courses
  IF total_generated < 650 THEN
    WHILE total_generated < 650 DO
      SELECT course_code INTO c_code FROM course ORDER BY RAND() LIMIT 1;
      IF RAND() > 0.5 THEN
        SET @gender := 'Male';
        SELECT name INTO @first FROM male_first_names ORDER BY RAND() LIMIT 1;
      ELSE
        SET @gender := 'Female';
        SELECT name INTO @first FROM female_first_names ORDER BY RAND() LIMIT 1;
      END IF;
      SELECT name INTO @last FROM last_names ORDER BY RAND() LIMIT 1;
      SET @fullname := CONCAT(@first, ' ', @last);
      SET @dob := random_dob_student();
      SET adm_year = 2021 + FLOOR(RAND() * 4);
      SET @reg := CONCAT(c_code, '-', LPAD(seq_num,4,'0'), '/', adm_year);
      
      INSERT INTO temp_students(student_reg_no, student_name, gender, date_of_birth, course_code)
      VALUES (@reg, @fullname, @gender, @dob, c_code);
      
      SET seq_num = seq_num + 1;
      SET total_generated = total_generated + 1;
    END WHILE;
  END IF;
  
END//
DELIMITER ;

-- 5) Run generator
CALL Generate650Students();

-- 6) Insert generated rows into actual student table
-- Note: if any student_reg_no already exists (PK conflict), those rows will fail.
INSERT INTO student (student_reg_no, student_name, gender, date_of_birth, course_code)
SELECT student_reg_no, student_name, gender, date_of_birth, course_code
FROM temp_students;

-- 7) Summary checks and samples
SELECT COUNT(*) AS total_students_now FROM student;

SELECT 
  c.course_code,
  c.course_name,
  COUNT(s.student_reg_no) AS students_in_course
FROM course c
LEFT JOIN student s ON c.course_code = s.course_code
GROUP BY c.course_code, c.course_name
ORDER BY students_in_course DESC
LIMIT 25;

SELECT student_reg_no, student_name, gender, date_of_birth, TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS age, course_code
FROM student
ORDER BY RAND()
LIMIT 20;

-- 8) Cleanup helper objects (keep temp tables dropped so they don't persist beyond session)
DROP TEMPORARY TABLE IF EXISTS male_first_names;
DROP TEMPORARY TABLE IF EXISTS female_first_names;
DROP TEMPORARY TABLE IF EXISTS last_names;
DROP TEMPORARY TABLE IF EXISTS temp_students;

-- Done.
