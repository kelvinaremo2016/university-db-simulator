/* This SQL file contains additional courses
It details data entry for College of COHES*/

USE university_db;

-- Calling Department IDs for the COHES School of Nursing
SELECT d.department_name, d.department_id 
FROM department d
LEFT JOIN school s
ON d.school_id=s.school_id
WHERE school_name = "School of Nursing";

#1 Courses in the Department of General Nursing
INSERT INTO course(course_code,course_name,department_id)
VALUES 
("BSN111","Bachelor of Science in Nursing (Direct Entry)",1020101),
("BSN112","Bachelor of Science in Nursing (Upgrade RN-BScN )",1020101),
("MSN221","Master of Science in Nursing (Medical Surgical Nursing)", 1020101),
("MSN222","Master of Science in Nursing (Critical Care Nursing)", 1020101),
("MSN223","Master of Science in Nursing (Oncology and Palliative Care Nursing)",1020101),

# 2 Courses in the Department of Midwifery
("MSW111","Master of Science in Nursing (Midwifery & Reproductive Health)",1020102),
("PSM112", "Ph.D in Midwifery & Reproductive Health",1020102),

# 3 Courses in the Department of Community Health Nursing
("CHN111", "Master of Science in Nursing (Community Health Nursing)",1020103),

# 4 Coures in the Department of Nursing Education,Leadership,Management & Research
("NLM111","Master of Science in Nursing (Nursing Education)",1020104),
("NLM112","Master of Science in Nursing (Nursing Leadership and Management)",1020104);

-- Calling Department IDs for the COHES School of Medicine
SELECT d.department_name, d.department_id 
FROM department d
LEFT JOIN school s
ON d.school_id=s.school_id
WHERE school_name = "School of Medicine";

#1 Coures in the Department of Clinical Medicine

INSERT INTO course(course_code,course_name,department_id)
VALUES 
("DCM111", "Diploma in Clinical Medicine and Surgery",1020202),
("BCM111", "BSc Clinical Medicine and Community Health",1020202),
("MCN111","Master in Clinical Medicine (Oncology)",1020202),
("MCN112", "Master of Clinical Medicine (Child and Adolescent Health)",1020202),

#2 Courses in the Department of Human Anatomy
("MHA111","Master of Science in Human Anatomy",1020204),
("PHA111","Doctor of Philosophy (PhD) in Human Anatomy",1020204),

# 3 Courses in the Department of Medical Physiology
("MCP111","Master of Science (MSc) in Physiology",1020207),
("PCP111","Doctor of Philosophy (PhD) in Medical Physiology",1020207),

# 4 Courses in the Department of Psychiatry
("BCT111","Bachelor of Science in Psychiatry",1020209),
("BCT112","Bachelor of Science in Occupational Therapy",1020209),
("BCP113","Bachelor of Science in Physiotherapy",1020209),
("MCP223", "Master of Medicine in Psychiatry",1020209),

#5 Courses in the Department of Radiology,Imaging and Radiotherapy
("RIR111","Bachelor of Radiography",1020210),
("MIR111","Master of Medicine (M.Med) in Diagnostic Radiology",1020210),

#6 Courses in the Department of Surgery
("BIS111","Bachelor of Medicine and Bachelor of Surgery (MBChB)",1020212),
("MMS111","Master of Medicine (M.Med) in Surgery",1020212);

-- Calling Department IDs for the COHES School of Pharmacy
SELECT d.department_name, d.department_id 
FROM department d
LEFT JOIN school s
ON d.school_id=s.school_id
WHERE school_name = "School of Pharmacy";

# 1 Courses in the Department of Pharmaceutics
INSERT INTO course(course_code,course_name,department_id)
VALUES
("DPP111","Bachelor of Pharmacy",1020301),
("MPP11","Master of Science in Medicinal  Phytochemistry",1020301),
("PMC113","Master of Science in Pharmacology (Drug Design and Development)",1020301),
("PMC111","Doctor of Philosophy Medicinal Chemistry",1020301),
("PMC112","Doctor of Philosophy Medicinal  Phytochemistry",1020301);
