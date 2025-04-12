create table student (
	id serial primary key,
	fname text not null,
	lname text not null,
	registration_date date not null,
	email text unique not null
);

create table teacher(
	id serial primary key,
	fname text not null,
	lname text not null,
	email text unique not null,
	experience float not null,
	rating float
);

create table course(
	id serial primary key,
	name text not null,
	description text,
	price float not null,
	teacher_id int not null references teacher(id),
	creation_date date not null
);

create table lesson(
	id serial primary key,
	name text not null,
	description text,
	course_id text not null,
	number_of_lesson float not null
);



-- Промежуточная таблица для связи "многие ко многим" между студентами и курсами
CREATE TABLE student_course (
    student_id INT NOT NULL,             
    course_id INT NOT NULL,              
    PRIMARY KEY (student_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE
);

-- Промежуточная таблица для связи "многие ко многим" между студентами и уроками (если требуется)
CREATE TABLE student_lesson (
    student_id INT NOT NULL,             
    lesson_id INT NOT NULL,              
    PRIMARY KEY (student_id, lesson_id), 
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE
);


