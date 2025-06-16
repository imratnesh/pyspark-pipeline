CREATE SCHEMA futurexschema;


CREATE TABLE futurexschema.futurex_course_catalog
(
    course_id integer NOT NULL,
    course_name character varying COLLATE pg_catalog."default" NOT NULL,
    author_name character varying COLLATE pg_catalog."default" NOT NULL,
    course_section json NOT NULL,
    creation_date date NOT NULL,
    CONSTRAINT futurex_course_catalog_pkey PRIMARY KEY (course_id)
)

- - ================Insert Queries========	

INSERT INTO futurexschema.futurex_course_catalog(
	course_id, course_name, author_name, course_section, creation_date)
	VALUES (2, 'Hadoop Spark', 'FutureXskill', '{"section": 1,"title": "Hadoop"}', '2020-01-13');
	
INSERT INTO futurexschema.futurex_course_catalog(
	course_id, course_name, author_name, course_section, creation_date)
	VALUES (1, 'Spring Boot Microservices', 'FutureXskill', '{"section": 1,"title": "Microservices"}', '2020-02-20');

SELECT * from futurexschema.futurex_course_catalog;

SELECT course_id, course_name, author_name, course_section, creation_date
FROM futureschema.futurex_course_catalog;