-- ================================================
-- QUICK SETUP: Smart UIM LMS Database
-- Script ini untuk import cepat (minimal data)
-- ================================================

-- DROP DATABASE IF EXISTS smart_uim;
CREATE DATABASE IF NOT EXISTS smart_uim CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_uim;

-- Users Table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  role ENUM('admin', 'lecturer', 'student') NOT NULL DEFAULT 'student',
  nim_nip VARCHAR(20) NULL,
  program_studi VARCHAR(100) NULL,
  semester INT(2) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default users (password: "password")
INSERT INTO users (username, email, password, full_name, role, nim_nip, program_studi, semester) VALUES
('admin', 'admin@uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'admin', 'ADM001', 'System', NULL),
('dosen1', 'dosen1@uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dr. Ahmad Fauzi, M.Kom', 'lecturer', 'NIP123456', 'Teknik Informatika', NULL),
('2022020100078', 'syaiful@student.uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Moh. Syaiful Anam', 'student', '2022020100078', 'Teknik Informatika', 7);

-- Courses Table
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  id INT(11) NOT NULL AUTO_INCREMENT,
  code VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  description TEXT NULL,
  credits INT(2) NOT NULL DEFAULT 3,
  semester INT(2) NOT NULL,
  lecturer_id INT(11) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (lecturer_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO courses (code, name, description, credits, semester, lecturer_id) VALUES
('TIF701', 'Pemrograman Mobile', 'Pengembangan aplikasi mobile dengan Flutter', 3, 7, 2),
('TIF702', 'Sistem Basis Data Lanjut', 'Database lanjutan dan NoSQL', 3, 7, 2);

-- Enrollments Table
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
  id INT(11) NOT NULL AUTO_INCREMENT,
  student_id INT(11) NOT NULL,
  course_id INT(11) NOT NULL,
  enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('active', 'completed', 'dropped') NOT NULL DEFAULT 'active',
  PRIMARY KEY (id),
  UNIQUE KEY unique_enrollment (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO enrollments (student_id, course_id, status) VALUES
(3, 1, 'active'),
(3, 2, 'active');

SELECT 'Database Smart UIM berhasil dibuat!' AS Status;
SELECT * FROM users;
SELECT * FROM courses;
