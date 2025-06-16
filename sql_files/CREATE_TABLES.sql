-- SQL commands to create required schemas and tables for the pipeline
-- psql -U postgres -d postgres -h 127.0.0.1 -f CREATE_TABLES.sql
-- Create schema futurexschema if not exists
CREATE SCHEMA IF NOT EXISTS futurexschema;

-- Create table futurexschema.futurex_course_catalog
CREATE TABLE IF NOT EXISTS futurexschema.futurex_course_catalog (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create schema fxxcoursedb if not exists
CREATE SCHEMA IF NOT EXISTS fxxcoursedb;

