-- ──────────────── SEED EXAMPLE DATA ────────────────

-- 1) Temporarily disable FKs so we can insert in any order
SET FOREIGN_KEY_CHECKS = 0;

-- 2) SCHOOLS (principal_id will point at the rows we insert below)
INSERT INTO `schools`
  (`school_id`, `school_name`,          `address`,            `city`,        `region`, `postal_code`, `country`, `principal_id`)
VALUES
  (1, 'Redwood High',      '123 Redwood Rd',    'Springfield', 'IL',     '62704',       'USA',    1),
  (2, 'Lakeside Elementary','456 Lake St',      'Shelbyville', 'IL',     '62565',       'USA',    2);

-- 3) PEOPLE
INSERT INTO `people`
  (`person_id`,`school_id`,`first_name`,`last_name`,`birth_date`,  `address`,           `city`,        `region`,`postal_code`,`country`)
VALUES
  -- Redwood High principals & staff
  (1, 1, 'John',  'Smith',  '1970-05-15', '123 Redwood Rd',    'Springfield','IL','62704','USA'),
  (3, 1, 'Alice', 'Brown',  '1980-10-10', '789 Oak Ave',       'Springfield','IL','62704','USA'),
  (4, 1, 'Bob',   'Davis',  '1975-02-28', '321 Pine Blvd',     'Springfield','IL','62704','USA'),
  (6, 1, 'Emily', 'Clark',  '2005-08-30', '987 Elm St',        'Springfield','IL','62704','USA'),
  (7, 1, 'Frank', 'Miller', '2006-12-01', '543 Maple Ln',      'Springfield','IL','62704','USA'),
  -- Lakeside Elementary principals & staff
  (2, 2, 'Mary',  'Johnson','1968-03-22', '456 Lake St',       'Shelbyville','IL','62565','USA'),
  (5, 2, 'Carol', 'Wilson', '1985-07-12', '654 Lakeview Dr',   'Shelbyville','IL','62565','USA'),
  (8, 2, 'Grace', 'Lee',    '2011-04-05', '210 Birch Rd',      'Shelbyville','IL','62565','USA'),
  (9, 2, 'Henry', 'Young',  '2010-11-20', '432 Cedar Ct',      'Shelbyville','IL','62565','USA');

-- 4) PRINCIPALS
INSERT INTO `principals`
  (`principal_id`,`person_id`,`salary`)
VALUES
  (1, 1, 95000.00),
  (2, 2, 85000.00);

-- 5) STUDENTS
INSERT INTO `students`
  (`student_id`,`person_id`,`grade_level`)
VALUES
  (1, 6, 11),   -- Emily Clark, Redwood
  (2, 7, 10),   -- Frank Miller,  Redwood
  (3, 8, 4),    -- Grace Lee,    Lakeside
  (4, 9, 5);    -- Henry Young,  Lakeside

-- 6) SUBJECTS
INSERT INTO `subjects`
  (`subject_id`,`subject`)
VALUES
  (1, 'Mathematics'),
  (2, 'English'),
  (3, 'Science');

-- 7) TEACHERS
INSERT INTO `teachers`
  (`teacher_id`,`person_id`,`subject_id`,`salary`)
VALUES
  (1, 3, 1, 60000.00),  -- Alice Brown teaches Math at Redwood
  (2, 4, 2, 58000.00),  -- Bob Davis   teaches English at Redwood
  (3, 5, 3, 61000.00);  -- Carol Wilson teaches Science at Lakeside

-- 8) CLASSROOMS
INSERT INTO `classrooms`
  (`classroom_id`,`teacher_id`,`subject_id`,`semester`,`year`)
VALUES
  (1, 1, 1, 'Fall',   2023),  -- Redwood Math
  (2, 2, 2, 'Spring', 2024),  -- Redwood English
  (3, 3, 3, 'Fall',   2023);  -- Lakeside Science

-- 9) CLASSROOM_STUDENTS
INSERT INTO `classroom_students`
  (`classroom_student_id`,`classroom_id`,`student_id`,`grade`)
VALUES
  -- Redwood Math class
  (1, 1, 1, 88),
  (2, 1, 2, 92),
  -- Redwood English class
  (3, 2, 1, 91),
  (4, 2, 2, 87),
  -- Lakeside Science class
  (5, 3, 3, 95),
  (6, 3, 4, 88);

-- 10) Re-enable FKs
SET FOREIGN_KEY_CHECKS = 1; 