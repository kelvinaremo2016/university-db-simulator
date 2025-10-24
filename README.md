# University MySQL Database Project

This project models a realistic university structure using MySQL, inspired by JKUAT’s hierarchy of colleges, schools, departments, and courses. It includes data for 65 programs and 650 students with realistic names and registration numbers.I designed it for practicing MySQL skills, including database design, data manipulation, and complex querying. 

## Project Structure

- **university_db.sql**  
  Defines the main schema, including tables for universities, colleges, schools, departments, courses, and students. Includes sample data for each entity.

- **College of Health Sciences (COHES).sql**  
  Adds additional courses and departments for the College of Health Sciences, including Nursing, Medicine, and Pharmacy.

- **Random Student Generator.sql**  
  SQL scripts and stored procedures to auto-generate 650 student records with randomized names, genders, birth dates, and course assignments.

- **Query File.sql**  
  Contains a wide variety of SELECT queries, ranging from simple counts to advanced joins, aggregations, and usage of SQL functions. Useful for learning and demonstrating SQL query skills.

- **Delete Unused Entities.sql**  
  Cleans up the database by removing unused or sample entities for a more focused dataset.

## Features

- **Relational Structure:**  
  - Universities, Colleges, Schools, Departments, Courses, and Students with foreign key relationships.
- **Sample Data:**  
  - Inserted data for real-world simulation.
- **Random Student Generator:**  
  - Generates diverse student data for testing queries.
- **Practice Queries:**  
  - Ready-to-use examples for learning SQL querying, aggregation, and joining.
- **Data Cleanup:**  
  - Scripts to remove unused or irrelevant entities.

## How to Use

1. **Set Up MySQL**  
   Make sure you have MySQL installed on your system.

2. **Run the Main Schema**
   - Import `university_db.sql` to create tables and insert initial data.

3. **Add More Data**
   - Run `College of Health Sciences (COHES).sql` to extend the database.

4. **Generate Students**
   - Run `Random Student Generator.sql` to fill the student table with randomized data.

5. **Practice SQL**
   - Use `Query File.sql` to try a variety of queries and understand database relationships.

6. **Cleanup (Optional)**
   - Use `Delete Unused Entities.sql` to remove unnecessary records.

## Example Queries

- Count total students and students by gender.
- List courses, departments, and enrollments.
- Advanced analytics: age distributions, top departments, admissions per year.

## License

This project is provided for educational and practice purposes. Feel free to fork and modify for learning, assignments, or portfolio projects.

---

**Contributed by:** kelvinaremo2016
