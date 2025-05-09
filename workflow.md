# 📚 Online Bookstore Management System

## 1. 🧑‍💻 User Flow

### a. Registration
-a. Registration
- User visits the registration page.
Enters name, email, password, phone number, and user type (job seeker or employer).
System:
Validates input.
Hashes password securely.
Stores user in the Users table with role job_seeker or employer.

b. Login
User logs in with email and password.
System verifies credentials and starts a session.

c. Browsing Jobs (Job Seekers)
Job seekers can:
View list of available job postings.
Search/filter by job title, location, company, or category.
View job details.

d. Applying for Jobs
Job seekers can:
Upload or select a saved resume.
Submit a job application with a message.
View status of past applications.
---

### 2. 🛠️ Admin/Employer Flow
a. Job Posting (Employers)
Employers can:
Create, edit, or delete job postings.
Set title, description, requirements, salary, and category.
View applicants for each job.

b. Application Management
Employers can:
View all applications for their jobs.
Filter by job or applicant.
Update application status (e.g., shortlisted, rejected, hired).
---

### 3. 📏 Rules & Validations
Users must register and log in to apply or post jobs.
Applications must be tied to a resume and job.
Only employers can post jobs.
Only job seekers can apply.
Passwords are securely hashed.
Job categories must be from a predefined list.
---


## 4. 🗄️ Database Schema (SQL)



```sql


CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('job_seeker', 'employer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE JobCategories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL
);

    CREATE TABLE Jobs (
        id INT PRIMARY KEY AUTO_INCREMENT,
        employer_id INT,
        title VARCHAR(255),
        description TEXT,
        requirements TEXT,
        salary VARCHAR(50),
        category_id INT,
        location VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (employer_id) REFERENCES Users(id),
        FOREIGN KEY (category_id) REFERENCES JobCategories(id)
    );

CREATE TABLE Resumes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    resume_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Applications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    user_id INT,
    resume_id INT,
    cover_letter TEXT,
    status ENUM('applied', 'shortlisted', 'rejected', 'hired') DEFAULT 'applied',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES Jobs(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (resume_id) REFERENCES Resumes(id)
);
