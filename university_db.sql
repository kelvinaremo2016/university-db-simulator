# creating the database
create database university_db;
use university_db;

-- 1. University Table
create table University (
university_id int primary key auto_increment,
university_name varchar(255) not null 
);

insert into University (university_id, university_name)
values 
(4326501,"Jomo Kenyatta University"),
(4326502, "Mount Kenya University"),
(4326503,"Kenyatta University"),
(4326504,"United States International University");

-- 2 Colleges Table 
create table College (
college_id int primary key, 
college_name varchar(255) not null,
university_id int not null,
foreign key (university_id) references University (university_id)
);

-- 21 JKUAT Colleges
insert into College (college_id,college_name,university_id)
values
(432650101,"College of Pure and Applied Sciences (COPAS)",4326501),
(432650102,"College of Health Sciences (COHES)",4326501),
(432650103,"College of Engineering Technology (COETEC)",4326501),
(432650104,"College of Human Resource Development (COHRED)",4326501),
(4326501,"College of Agriculture and Natural Resources (COANRE)",4326501);

set sql_safe_updates=0;
update College
set college_id=432650105
where college_name="College of Agriculture and Natural Resources (COANRE)";

-- 3 Schools Table
create table School (
school_id int(255) primary key,
school_name varchar(255) not null,
college_id int not null,
foreign key(college_id) references College(college_id)
);

# 31 COPAS Schools
insert into School (school_id,school_name,college_id)
values
(10101,"School of Biological Sciences (SBS)",432650101),
(10102,"School of Mathematical and Physical Sciences (SMPS)",432650101),
(43265010103,"School of Computing and Information Technology (SCIT)",432650101);

update School
set school_id= 10103
where school_id=43265010103;

# 32 COHES Schools
insert into School (school_id,school_name,college_id)
values
(10201,"School of Nursing",432650102),
(10202,"School of Medicine",432650102),
(10203,"School of Pharmacy",432650102),
(10204,"School of Public Health",432650102),
(10205,"School of Biomedical Sciences",432650102);

# 33 COETEC Schools
insert into School (school_id,school_name,college_id)
values 
(10301,"School of Architecture and Building Sciences (SABS)",432650103),
(10302,"School of Mechanical, Manufacturing & Materials Engineering (SoMMME)",432650103),
(10303,"School of Electrical, Electronic and Information Engineering (SEEIE)",432650103),
(10304,"School of Civil, Environmental and Geospatial Engineering (SCEGE)",432650103),
(10305,"School of Biosystems and Environmental Engineering (SoBEE)",432650103),
(10306,"Centre for Sustainable Materials, Research and Technology (SMARTEC)",432650103);

# 34 COHRED Schools
insert into School (school_id,school_name,college_id)
values
(10401,"School of Business",432650104),
(10402,"School of Entrepreneurship, Procurement and Management",432650104),
(10403,"School of Communication and Development Studies",432650104);

# 35 COANRE Schools
insert into School (school_id,school_name,college_id)
values 
(10501,"School of Agriculture and Environmental Sciences (SOAES)",432650105),
(10502,"School of Food and Nutrition Sciences (SOFNUS)",432650105),
(10503,"School of Natural Resources and Animal Sciences (SONRAS)",432650105);

-- we ran into an error. looks like the college_id is not what we think it is so correcting...

set sql_safe_updates=0;
update College
set college_id=432650105
where college_name="College of Agriculture and Natural Resources (COANRE)";

-- 4 Deparments Table
create table Department (
department_id int primary key,
department_name varchar(255) not null,
school_id int not null,
foreign key(school_id) references School(school_id)
);

# 41 COPAS School of Biological Sciences Departments
insert into Department (department_id,department_name,school_id)
values
(1010101,"Department of Botany",10101),
(1010102,"Department of Zoology",10101);

# 42 COPAS School of Mathematical and Physical Sciences (SMPS) Departments
insert into Department (department_id,department_name,school_id)
values
(1010201,"Department of Pure and Applied Mathematics (PAM)",10102),
(1010202,"Department of Statistics and Acturial Sciences (STACS)",10102),
(1010203,"Department of Chemistry",10102),
(1010204,"Department of Physics",10102);

#updating typo in Actuarial
update Department 
set department_name="Department of Statistics and Actuarial Sciences (STACS)"
where department_name="Department of Statistics and Acturial Sciences (STACS)";

# 43 COPAS School of Computing and Information Technology (SCIT) Departments
insert into Department (department_id,department_name,school_id)
values
(1010301,"Department of Computing",10103),
(1010302,"Department of Information Technology",10103);

#44 COHES School of Nursing Departments
insert into Department (department_id,department_name,school_id)
values
(1020101,"Department of General Nursing",10201),
(1020102,"Department of Midwifery",10201),
(1020103,"Department of Community Health Nursing",10201),
(1020104,"Department of Nursing Education,Leadership,Management & Research",10201);

#45 COHES School of Medicine Departments
insert into Department (department_id,department_name,school_id)
values
(1020201,"Department of Child Health and Paedetrics",10202),
(1020202,"Department of Clinical Medicine",10202),
(1020203,"Department of Critical Care and Anaesthesiology",10202),
(1020204,"Department of Human Anatomy",10202),
(1020205,"Department of Pathology",10202),
(1020206,"Department of Internal Medicine and Therapeutics",10202),
(1020207,"Department of Medical Physiology",10202),
(1020208,"Department of Obstetrics and Gynaecology",10202),
(1020209,"Department of Psychiatry",10202),
(1020210, "Department of Radiology,Imaging and Radiotherapy",10202),
(1020211,"Department of Rehabilitative Sciences",10202),
(1020212,"Department of Surgery",10202);

-- 5 Courses Table
create table Course (
course_code varchar(6) primary key,
course_name varchar(255) not null,
department_id int not null,
foreign key(department_id) references Department(department_id)
);

#51 Courses in the Department of Botany
insert into Course(course_code,course_name,department_id)
values
("BOT101","Bachelor of Science in Microbiology",1010101),
("BOT102","Bachelor of Science in Biotechnology",1010101),
("BOT103","Bachelor of Science in Plant Ecology and Environmental Science",1010101),
("BOT104", "Bachelor of Science in Plant Pathology",1010101);

#52 Courses in the Department of Zoology
insert into Course (course_code,course_name,department_id)
values
("ZOL101","Bachelor of Science in Zoology",1010102),
("ZOL102","Bachelor of Science in Applied Biology",1010102),
("ZOL103","Bachelor of Science in Environmental Science",1010102),
("ZOL104","Bachelor of Science in Fisheries and Aqualculture Sciences",1010102),
("ZOL105","Bachelor of Science in Genomic Science",1010102);

#53 Courses in the Department of Pure and Applied Mathematics 

INSERT INTO Course (course_code, course_name, department_id)
VALUES
("PAM101", "Bachelor of Science in Mathematics and Computer Science", 1010201),
("PAM102", "Bachelor of Science in Industrial Mathematics", 1010201),
("PAM103", "Master of Science in Applied Mathematics", 1010201),
("PAM104", "Master of Science in Pure Mathematics", 1010201);

#54 Courses in the Department of Statistics and Actural Sciences
insert into Course (course_code,course_name,department_id)
values 
("SCM221","Bachelor of Science in Actuarial Science",1010202),
("SCM222","Bachelor of Science in Financial Engineering",1010202),
("SCM223","Bachelor of Science in Statistics",1010202),
("SCM224","Bachelor of Science in Biostatistics",1010202),
("SCM225","Bachelor of Science in Operations Research",1010202);

#55 Courses in the Department of Chemistry
#altering table to accomodate the long course codes in the department
alter table Course modify course_code varchar(10);

insert into Course (course_code,course_name,department_id)
values
("SCH3200","Bachelor of Science in Analytical Chemistry",1010203),
("SCH3201","Bachelor of Science in Industrial Chemistry",1010203),
("SCH3202","Bachelor of Science in Chemistry",1010203);

#56 Courses in the Department Physics
insert into Course (course_code,course_name,department_id)
values
("SCP221","Bachelor of Science in Physics",1010204),
("SCP222","Bachelor of Science in Control and Instrumentation",1010204),
("SCP223","Bachelor of Science in Geophysics",1010204),
("SCP224","Bachelor of Science in Renewable Energy and Environmental Physics",1010204);

#57 Courses in the Department of Computing
insert into Course (course_code,course_name,department_id)
values
("00223","Bachelor of Science in Computer Science",1010301),
("00224","Bachelor of Science in Computer Technology",1010301),
("ICS2302","Master of Science in Software Engineering",1010301),
("ICS2303","Master of Science in Computer Systems",1010301),
("ICS2304","Master of Science in Artificial Intelligence",1010301);

#58 Courses in the Department of Information Technology
insert into Course (course_code,course_name,department_id)
values
("ICS2110","Certificate in I.T",1010302),
("DIT0205","Diploma in I.T",1010302),
("SCT221","Bachelor of Science in Business Computing",1010302),
("SCT222","Bachelor of Science in Business Information Technology",1010302);

/* Continuing work on the project after a while after learning a bit more about MySQL */

USE university_db;
-- Pulling up Colleges and their respective schoools
SELECT c.college_name AS College, s.school_name AS School
FROM college c
INNER JOIN school s
 ON c.college_id = s.college_id;
 
 -- Entering data on missing departments
 -- 01 Departments in the School of Pharmacy
 
 INSERT INTO department (department_id,department_name,school_id)
 VALUES
 (1020301, "Department of Pharmaceutics",10203),
 (1020302,"Department of Pharmaceutical Chemistry",10203),
 (1020303,"Departmet of Pharmacology and Pharmacognosy",10203),
 
 -- 02 School of Public Health
(1020401, "Department of Environmental Health and Disease Control",10204),
(1020402,"Department of Pharmaceutical Chemistry",10204),
(1020403,"Departmet of Health Records and Information Management",10204),

-- 03 School of Biomedical Sciences
(1020501, "Medical Laboratory Sciences Department",10205),
(1020502,"Medical Microbiology Department",10205),
(1020503,"Biochemistry Department",10205),

-- School of School of Architecture and Building Sciences (SABS)
(1030101, "Department of Architecture",10301),
(1030102,"Department of Landscape Architecture",10301),
(1030103,"Department of Construction Management",10301),

-- School of Mechanical, Manufacturing & Materials Engineering (SoMMME)  10302
(1030201, "Department of Mechanical Engineering",10302),
(1030202,"Department of Mechatronic Engineering",10302),
(1030203,"Department of Marine Engineering & Maritime Operations",10302),
(1030204,"Department of Mining, Materials, and Petroleum Engineering",10302);

-- School of Electrical, Electronic and Information Engineering (SEEIE) ID 10303
INSERT INTO department (department_id,department_name,school_id)
 VALUES
 (1030301, "Department of Electronic and Computer Engineering (ECE)",10303),
 (1030302, "Department of Electrical and Electronic Engineering (EEE)",10303),
 (1030303, "Department of Telecommunication and Information Engineering (ITE)",10303),
 
 -- School of Civil, Environmental and Geospatial Engineering (SCEGE) ID 10304
 (1030401,"Department of Civil, Construction, and Environmental Engineering", 10304),
 (1030402, "Department of Geomatics and Geospatial Information Systems",10304),
 -- COHRED School of Business ID 10401
 (1040101,"Department of Business Administration",10401),
 (1040102, "Department of Entrepreneurship, Technology, Leadership and Management",10401),
 (1040103, "Department of Economics, Accounting and Finance",10401),
 (1040104, "Department of Procurement and Logistics",10401),
-- COHRED School of Communication and Development Studies ID 10403
(1040301, "Department of Media Technology and Applied Communication (MTAC)",10403),
(1040302,"Department of Development Studies (DDS)",10403),
(1040303,"Centre for Foreign Languages and Linguistics",10403),
-- COANRE School of School of Agriculture and Environmental Sciences (SOAES) ID 10501
(1050101, "Department of Horticulture and Food Security (HFS)",10501),
(1050102, "Department of Agricultural and Resoure Economics (DARE)",10501),
-- COANRE School of Food and Nutrition Sciences (SOFNUS) ID 10502
(1050201, "Department of Food Science and Technology",10502),
(1050202, "Department of Human Nutrition Science",10502),
-- COANRE School of Natural Resources and Animal Sciences (SONRAS) ID 10503
(1050301,"Department of Land Resource, Planning and Management",10503),
(1050302, "Department of Animal Sciences",10503);

-- Creating student table
CREATE TABLE student (
student_reg_no VARCHAR (20) PRIMARY KEY,
student_name VARCHAR(255) NOT NULL,
gender ENUM("Male","Female") NOT NULL,
date_of_birth DATE NOT NULL,
course_code VARCHAR (10) NOT NULL,
FOREIGN KEY(course_code) REFERENCES course(course_code)
);

