-- Table: Users (Job Seekers & Employers) 
CREATE DATABASE db_batch6_oja;
use db_batch6_oja;
CREATE TABLE Users (
user_id INT PRIMARY KEY AUTO_INCREMENT,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL, password VARCHAR(255) NOT NULL,
role ENUM('job_seeker', 'employer', 'admin') NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP );
-- Table: Companies
CREATE TABLE Companies (
company_id INT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL,
company_name VARCHAR(150) NOT NULL,
industry VARCHAR(100), location VARCHAR(150), website VARCHAR(255),
FOREIGN KEY (user_id) REFERENCES Users(user_id) );
-- Table: Job_Postings
CREATE TABLE Job_Postings (
job_id INT PRIMARY KEY AUTO_INCREMENT,
company_id INT NOT NULL,
title VARCHAR(100) NOT NULL, description TEXT NOT NULL,
location VARCHAR(150),
salary_range VARCHAR(50),
job_type ENUM('full_time', 'part_time', 'internship', 'contract') NOT NULL, posted_date DATE DEFAULT CURRENT_DATE,
FOREIGN KEY (company_id) REFERENCES Companies(company_id) );
-- Table: Applications
CREATE TABLE Applications (
application_id INT PRIMARY KEY AUTO_INCREMENT,
job_id INT NOT NULL,
user_id INT NOT NULL,    resume TEXT NOT NULL, cover_letter TEXT,
status ENUM('submitted', 'reviewed', 'interview', 'rejected', 'accepted') DEFAULT 'submitted', application_date DATE DEFAULT CURRENT_DATE,
FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id), FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Table: Interviews
CREATE TABLE Interviews (
interview_id INT PRIMARY KEY AUTO_INCREMENT, application_id INT NOT NULL,
scheduled_date DATETIME NOT NULL,
interview_mode ENUM('online', 'in_person') NOT NULL, notes TEXT,
FOREIGN KEY (application_id) REFERENCES Applications(application_id) );
-- Table: Messages (Optional Communication Between User & Employer) 

CREATE TABLE Messages (
message_id INT PRIMARY KEY AUTO_INCREMENT,
sender_id INT NOT NULL,   receiver_id INT NOT NULL, content TEXT NOT NULL,
sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (sender_id) REFERENCES Users(user_id),  FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);
