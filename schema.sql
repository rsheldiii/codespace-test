-- 1) Create and switch to our schema
-- Note: The database 'mydatabase' is already created by the devcontainer feature.
-- We will use that instead of creating a new 'system' database.
USE `mydatabase`;

-- 2) Turn off FK checks (allows us to declare cyclical FKs)
SET FOREIGN_KEY_CHECKS = 0;

-- 3) CORE TABLES

-- SCHOOLS
CREATE TABLE `schools` (
  `school_id`     INT          NOT NULL,
  `school_name`   VARCHAR(35),
  `address`       VARCHAR(80),
  `city`          VARCHAR(15),
  `region`        VARCHAR(15),
  `postal_code`   VARCHAR(10),
  `country`       VARCHAR(15),
  `principal_id`  INT,
  PRIMARY KEY (`school_id`)
  -- FK constraint added after principals table is created
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- SUBJECTS
CREATE TABLE `subjects` (
  `subject_id`  INT          NOT NULL,
  `subject`     VARCHAR(60),
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- PEOPLE
CREATE TABLE `people` (
  `person_id`    INT          NOT NULL,
  `school_id`    INT,
  `first_name`   VARCHAR(10),
  `last_name`    VARCHAR(20),
  `birth_date`   DATE,
  `address`      VARCHAR(80),
  `city`         VARCHAR(15),
  `region`       VARCHAR(15),
  `postal_code`  VARCHAR(10),
  `country`      VARCHAR(15),
  PRIMARY KEY (`person_id`),
  CONSTRAINT `people_school_fk`
    FOREIGN KEY (`school_id`)
    REFERENCES `schools` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- PRINCIPALS
CREATE TABLE `principals` (
  `principal_id` INT          NOT NULL,
  `person_id`    INT,
  `salary`       DECIMAL(12,2),
  PRIMARY KEY (`principal_id`),
  CONSTRAINT `principals_person_fk`
    FOREIGN KEY (`person_id`)
    REFERENCES `people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add the missing FK constraint to schools now that principals exists
ALTER TABLE `schools`
ADD CONSTRAINT `school_principal_fk`
  FOREIGN KEY (`principal_id`)
  REFERENCES `principals` (`principal_id`);

-- STUDENTS
CREATE TABLE `students` (
  `student_id`   INT          NOT NULL,
  `person_id`    INT,
  `grade_level`  INT,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `students_person_fk`
    FOREIGN KEY (`person_id`)
    REFERENCES `people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- TEACHERS
CREATE TABLE `teachers` (
  `teacher_id`   INT          NOT NULL,
  `person_id`    INT,
  `subject_id`   INT,
  `salary`       DECIMAL(12,2),
  PRIMARY KEY (`teacher_id`),
  CONSTRAINT `teachers_person_fk`
    FOREIGN KEY (`person_id`)
    REFERENCES `people` (`person_id`),
  CONSTRAINT `teachers_subject_fk`
    FOREIGN KEY (`subject_id`)
    REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CLASSROOMS
CREATE TABLE `classrooms` (
  `classroom_id` INT          NOT NULL,
  `teacher_id`   INT,
  `subject_id`   INT,
  `semester`     VARCHAR(6),
  `year`         INT,
  PRIMARY KEY (`classroom_id`),
  CONSTRAINT `classrooms_teacher_fk`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `teachers` (`teacher_id`),
  CONSTRAINT `classrooms_subject_fk`
    FOREIGN KEY (`subject_id`)
    REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CLASSROOM_STUDENTS
CREATE TABLE `classroom_students` (
  `classroom_student_id` INT   NOT NULL,
  `classroom_id`         INT,
  `student_id`           INT,
  `grade`                INT,
  PRIMARY KEY (`classroom_student_id`),
  CONSTRAINT `classroom_students_classroom_fk`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `classrooms` (`classroom_id`),
  CONSTRAINT `classroom_students_student_fk`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) Turn FK checks back on
SET FOREIGN_KEY_CHECKS = 1;

-- Note: You will likely want to add INSERT statements here or in a separate seed file
-- to populate these tables with data. 