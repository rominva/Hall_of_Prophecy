-- 0) VERY FIRST THING
PRAGMA foreign_keys = ON;


-- 1) INSERTING data from CSV FILE
-- .mode csv
-- .import students.csv temp

-- Temporary table used only for CSV import (no constraints)
-- CREATE TABLE temp (
--     id TEXT,
--     student_name TEXT,
--     house TEXT,
--     head TEXT
-- );


-- 2) Check the data in temp table
SELECT * FROM temp ORDER BY student_name;

-- 3) Delete the Header titles from temp table
-- first CHECK THE DATA to make sure
SELECT student_name FROM temp
WHERE student_name = 'student_name';

-- second Delete
DELETE FROM temp
WHERE student_name = 'student_name';



-- 4) Recreate the tables with FOREIGN KEY & INSERT data from tempinto them
-- Create the houses table
CREATE TABLE houses (
    id INTEGER PRIMARY KEY,
    house_name TEXT NOT NULL UNIQUE
);

-- INSERT data from temp into houses table
INSERT INTO houses (house_name)
    SELECT DISTINCT house FROM temp;

-- Check the data in houses table
> SELECT * FROM houses;


-- Create the house_assignments TABLE for heads
CREATE TABLE house_assignments (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    house_id INTEGER,
    FOREIGN KEY (house_id) REFERENCES houses(id)
);

-- INSERT data FROM temp into house_assignments table
INSERT INTO house_assignments (name, house_id)
SELECT DISTINCT temp.head, houses.id FROM temp
JOIN houses ON temp.house = houses.house_name;

-- Check the data in house_assignments table
SELECT * FROM house_assignments;


-- create students table
CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    house_id INTEGER,
    FOREIGN KEY (house_id) REFERENCES houses(id)
);

-- INSERT data FROM temp into students table
INSERT INTO students (student_name, house_id)
SELECT DISTINCT temp.student_name, houses.id FROM temp
JOIN houses ON temp.house = houses.house_name;

-- Check the data in students table
SELECT * FROM students ORDER BY student_name;



-- 5) DROP the temperary table
DROP TABLE temp;
VACUUM;



-- 6) Check the FOREGN KEYS
PRAGMA foreign_key_check; -- (no output) ✔



-- 7) Create INDEX for FOREIGN KEYS
CREATE INDEX idx_house_assignments_house_id ON house_assignments(house_id);

CREATE INDEX idx_students_house_id ON students(house_id);

