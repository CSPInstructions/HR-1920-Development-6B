--------------
--  CREATE  --
--------------

-- Start by creating a table that stores student information
-- The primary key defines the value that makes a single entry unique
-- Not null makes sure that data isn't left empty on creation
CREATE TABLE Student (
    StudentId VARCHAR(7) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- The same thing shall be done for a table that stores school
CREATE TABLE School (
    SchoolId SERIAL PRIMARY KEY,
    SchoolName VARCHAR(100) NOT NULL
);

-- One of the relations that we can make between tables is a many-to-many
-- In this case we're saying: a student can go to multiple schools and a 
-- school has multiple students
-- REFERENCES creates a foreign key for the relation
-- We combine two values in this table to create a COMPOSITE PRIMARY KEY
CREATE TABLE StudentSchool (
    StudentId VARCHAR(7) REFERENCES Student(StudentId),
    SchoolId SERIAL REFERENCES School(SchoolId),
    PRIMARY KEY(StudentId, SchoolId)  
);


--------------
--  INSERT  --
--------------

-- Getting data into the database is the first step into this course
-- The student database shall be filled with three entries
-- We tell SQL the order in which the information shall be given
-- Followed by the actual values
INSERT INTO Student (studentid, studentname)
VALUES ('0925379', 'Wesley van Schaijk');

INSERT INTO Student (studentid, studentname)
VALUES ('0925380', 'Jimmy Kijas');

INSERT INTO Student (studentid, studentname)
VALUES ('0925381', 'Fabian van de Berg');

-- When we declare a SERIAL type in Postgres, this will be filled automatically
-- We combine multiple INSERT statements into one by
-- seperating the values with comma's
INSERT INTO school (schoolname)
VALUES ('Hogeschool Rotterdam'), ('Stedelijk Dalton Lyceum');

-- Because we created the foreign key constraints, existing values have to be entered
-- For now: look them up in the other tables
INSERT INTO studentschool (studentid, schoolid) 
VALUES ('0925379', 1), ('0925380', 1), ('0925381', 2);


--------------
--  SELECT  --
--------------

-- SELECT allows us to get information that's stored in the database
-- The * tells the database to return the data from all columns
-- In this case, we select information from the school table.
SELECT *
FROM school;

-- Instead, we could get only the columns we're interested in
SELECT Studentname
FROM student;

-- WHERE allows us to get specific entries from the database
-- The selection is performed based on a given condition
SELECT Studentname
FROM student
WHERE StudentId = '0925379';

-- LIKE allows us to make a more complicated condition
-- The % sign means that any (number of) character can replace it
-- We can give the columns that are returned to us custom names using AS
SELECT Studentname AS Name
FROM student
WHERE StudentName LIKE '%van%';

-- Combining the different elements of SQL allows us to create 
-- very complicated queries
SELECT st.studentname as Name, sc.schoolname as School
FROM student st, school sc, studentschool ss
WHERE st.studentid = ss.studentid
AND sc.schoolid = ss.schoolid
ORDER BY schoolname;


--------------
--  VIEWS   --
--------------

-- A view allows us to store complicated queries as function for easy access
-- Let's take the last example from the previous chapter and create a view
CREATE VIEW StudentWithSchools AS
    SELECT st.studentname as Name, sc.schoolname as School
    FROM student st, school sc, studentschool ss
    WHERE st.studentid = ss.studentid
    AND sc.schoolid = ss.schoolid
    ORDER BY schoolname;

-- After creating the view, we can get the result of the query as if
-- the view was a normal table in our database
SELECT *
FROM studentwithschools;


--------------
-- RESEARCH --
--------------

-- 1. Some databases follow other rules, find them for your favorite database
-- 2. Try to make some tables and apply UNION
-- 3. Think of some complicated conditions and try to create their queries