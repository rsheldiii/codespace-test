-- Example SQL queries for the new school schema

-- Select all schools
SELECT * FROM schools;

-- Select all people
SELECT person_id, first_name, last_name FROM people;

-- Insert a sample subject (uncomment to run)
-- INSERT INTO subjects (subject_id, subject) VALUES (1, 'Mathematics');

-- Find people associated with a specific school_id (replace 1 with an actual ID)
-- SELECT p.first_name, p.last_name, s.school_name 
-- FROM people p
-- JOIN schools s ON p.school_id = s.school_id
-- WHERE p.school_id = 1; 