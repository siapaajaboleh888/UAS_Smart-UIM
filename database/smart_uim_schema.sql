-- ================================================
-- DATABASE SCHEMA: Smart UIM LMS
-- Learning Management System - Universitas Islam Madura
-- Author: Moh. Syaiful Anam (2022020100078)
-- Date: 2025-12-15
-- ================================================

-- Hapus database jika sudah ada
DROP DATABASE IF EXISTS `smart_uim`;

-- Buat database baru
CREATE DATABASE `smart_uim` 
  DEFAULT CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

USE `smart_uim`;

-- ================================================
-- TABLE: users (Tabel Pengguna)
-- ================================================
CREATE TABLE `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `role` ENUM('admin', 'lecturer', 'student') NOT NULL DEFAULT 'student',
  `nim_nip` VARCHAR(20) NULL,
  `program_studi` VARCHAR(100) NULL,
  `semester` INT(2) NULL,
  `avatar_url` VARCHAR(255) NULL,
  `phone` VARCHAR(20) NULL,
  `address` TEXT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `last_login` DATETIME NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_role` (`role`),
  INDEX `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: courses (Tabel Mata Kuliah)
-- ================================================
CREATE TABLE `courses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(20) NOT NULL UNIQUE,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `credits` INT(2) NOT NULL DEFAULT 3,
  `semester` INT(2) NOT NULL,
  `lecturer_id` INT(11) NULL,
  `thumbnail_url` VARCHAR(255) NULL,
  `syllabus_url` VARCHAR(255) NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_code` (`code`),
  INDEX `idx_lecturer` (`lecturer_id`),
  FOREIGN KEY (`lecturer_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: enrollments (Tabel Pendaftaran Mahasiswa)
-- ================================================
CREATE TABLE `enrollments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `student_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  `enrolled_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('active', 'completed', 'dropped') NOT NULL DEFAULT 'active',
  `final_grade` DECIMAL(5,2) NULL,
  `grade_letter` VARCHAR(2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_enrollment` (`student_id`, `course_id`),
  INDEX `idx_student` (`student_id`),
  INDEX `idx_course` (`course_id`),
  FOREIGN KEY (`student_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: materials (Tabel Materi Pembelajaran)
-- ================================================
CREATE TABLE `materials` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_id` INT(11) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `type` ENUM('video', 'pdf', 'ppt', 'doc', 'link', 'other') NOT NULL,
  `file_url` VARCHAR(255) NULL,
  `external_url` VARCHAR(255) NULL,
  `order_index` INT(11) NOT NULL DEFAULT 0,
  `week` INT(2) NULL,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_course` (`course_id`),
  INDEX `idx_week` (`week`),
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: assignments (Tabel Tugas)
-- ================================================
CREATE TABLE `assignments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_id` INT(11) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `file_url` VARCHAR(255) NULL,
  `due_date` DATETIME NOT NULL,
  `max_score` INT(11) NOT NULL DEFAULT 100,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_course` (`course_id`),
  INDEX `idx_due_date` (`due_date`),
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: submissions (Tabel Pengumpulan Tugas)
-- ================================================
CREATE TABLE `submissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `assignment_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `file_url` VARCHAR(255) NULL,
  `notes` TEXT NULL,
  `score` DECIMAL(5,2) NULL,
  `feedback` TEXT NULL,
  `submitted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `graded_at` DATETIME NULL,
  `status` ENUM('submitted', 'late', 'graded', 'revision') NOT NULL DEFAULT 'submitted',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_submission` (`assignment_id`, `student_id`),
  INDEX `idx_assignment` (`assignment_id`),
  INDEX `idx_student` (`student_id`),
  FOREIGN KEY (`assignment_id`) REFERENCES `assignments`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`student_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: quizzes (Tabel Kuis)
-- ================================================
CREATE TABLE `quizzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_id` INT(11) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `duration_minutes` INT(11) NOT NULL DEFAULT 60,
  `max_attempts` INT(11) NOT NULL DEFAULT 1,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_course` (`course_id`),
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: announcements (Tabel Pengumuman)
-- ================================================
CREATE TABLE `announcements` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_id` INT(11) NULL,
  `author_id` INT(11) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `priority` ENUM('low', 'normal', 'high', 'urgent') NOT NULL DEFAULT 'normal',
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_course` (`course_id`),
  INDEX `idx_author` (`author_id`),
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- TABLE: attendance (Tabel Kehadiran)
-- ================================================
CREATE TABLE `attendance` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `meeting_number` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `status` ENUM('present', 'absent', 'excused', 'late') NOT NULL,
  `notes` TEXT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_attendance` (`course_id`, `student_id`, `meeting_number`),
  INDEX `idx_course` (`course_id`),
  INDEX `idx_student` (`student_id`),
  INDEX `idx_date` (`date`),
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`student_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- INSERT SAMPLE DATA
-- ================================================

-- Insert Admin User
INSERT INTO `users` (`username`, `email`, `password`, `full_name`, `role`, `nim_nip`, `program_studi`, `is_active`) 
VALUES 
('admin', 'admin@uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'admin', 'ADM001', 'Sistem Informasi', 1);

-- Insert Lecturer
INSERT INTO `users` (`username`, `email`, `password`, `full_name`, `role`, `nim_nip`, `program_studi`, `phone`, `is_active`) 
VALUES 
('dosen1', 'dosen1@uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dr. Ahmad Fauzi, M.Kom', 'lecturer', 'NIP123456', 'Teknik Informatika', '081234567890', 1),
('dosen2', 'dosen2@uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Siti Nur Azizah, M.T', 'lecturer', 'NIP123457', 'Teknik Informatika', '081234567891', 1);

-- Insert Students
INSERT INTO `users` (`username`, `email`, `password`, `full_name`, `role`, `nim_nip`, `program_studi`, `semester`, `phone`, `is_active`) 
VALUES 
('2022020100078', 'syaiful@student.uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Moh. Syaiful Anam', 'student', '2022020100078', 'Teknik Informatika', 7, '082345678901', 1),
('2022020100079', 'student2@student.uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Fatimah Zahra', 'student', '2022020100079', 'Teknik Informatika', 7, '082345678902', 1),
('2022020100080', 'student3@student.uim.ac.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Muhammad Rizki', 'student', '2022020100080', 'Teknik Informatika', 7, '082345678903', 1);

-- Insert Courses
INSERT INTO `courses` (`code`, `name`, `description`, `credits`, `semester`, `lecturer_id`, `is_active`) 
VALUES 
('TIF701', 'Pemrograman Mobile', 'Mata kuliah yang mempelajari pengembangan aplikasi mobile berbasis Android dan iOS menggunakan Flutter', 3, 7, 2, 1),
('TIF702', 'Sistem Basis Data Lanjut', 'Mata kuliah yang mempelajari konsep database lanjutan, optimasi query, dan NoSQL', 3, 7, 2, 1),
('TIF703', 'Kecerdasan Buatan', 'Mata kuliah yang mempelajari konsep AI, Machine Learning, dan Deep Learning', 3, 7, 3, 1),
('TIF704', 'Pemrograman Web Lanjut', 'Mata kuliah yang mempelajari pengembangan web modern dengan framework seperti Laravel dan React', 3, 7, 2, 1);

-- Insert Enrollments
INSERT INTO `enrollments` (`student_id`, `course_id`, `status`) 
VALUES 
(3, 1, 'active'), -- Syaiful -> Pemrograman Mobile
(3, 2, 'active'), -- Syaiful -> Basis Data Lanjut
(3, 3, 'active'), -- Syaiful -> Kecerdasan Buatan
(4, 1, 'active'), -- Fatimah -> Pemrograman Mobile
(4, 2, 'active'), -- Fatimah -> Basis Data Lanjut
(5, 1, 'active'), -- Rizki -> Pemrograman Mobile
(5, 3, 'active'); -- Rizki -> Kecerdasan Buatan

-- Insert Materials
INSERT INTO `materials` (`course_id`, `title`, `description`, `type`, `order_index`, `week`, `is_published`) 
VALUES 
(1, 'Pengenalan Flutter', 'Materi pengenalan framework Flutter untuk pengembangan mobile', 'pdf', 1, 1, 1),
(1, 'Widget dan Layout Flutter', 'Materi tentang widget dasar dan layout management di Flutter', 'pdf', 2, 2, 1),
(1, 'State Management dengan Provider', 'Video tutorial state management menggunakan Provider', 'video', 3, 3, 1),
(2, 'Pengenalan MongoDB', 'Materi tentang database NoSQL MongoDB', 'pdf', 1, 1, 1),
(2, 'Query Optimization', 'Teknik optimasi query database', 'ppt', 2, 2, 1),
(3, 'Introduction to AI', 'Pengenalan konsep kecerdasan buatan', 'pdf', 1, 1, 1),
(3, 'Machine Learning Basics', 'Dasar-dasar machine learning dan algoritma', 'video', 2, 2, 1);

-- Insert Assignments
INSERT INTO `assignments` (`course_id`, `title`, `description`, `due_date`, `max_score`, `is_published`) 
VALUES 
(1, 'Tugas 1: Membuat Aplikasi To-Do List', 'Buatlah aplikasi to-do list sederhana menggunakan Flutter', '2025-12-30 23:59:59', 100, 1),
(1, 'Tugas 2: State Management', 'Implementasikan state management pada aplikasi sebelumnya', '2026-01-15 23:59:59', 100, 1),
(2, 'Tugas 1: Design Database E-Commerce', 'Rancang database untuk sistem e-commerce', '2025-12-28 23:59:59', 100, 1),
(3, 'Tugas 1: Implementasi Linear Regression', 'Implementasi algoritma linear regression menggunakan Python', '2026-01-10 23:59:59', 100, 1);

-- Insert Announcements
INSERT INTO `announcements` (`course_id`, `author_id`, `title`, `content`, `priority`, `is_published`) 
VALUES 
(1, 2, 'Perkuliahan Minggu Depan Online', 'Mahasiswa yang terhormat, perkuliahan minggu depan akan dilaksanakan secara online melalui Zoom.', 'high', 1),
(NULL, 1, 'Pengumuman UTS Semester Ganjil', 'UTS akan dilaksanakan pada tanggal 5-10 Januari 2026. Harap mempersiapkan diri dengan baik.', 'urgent', 1),
(2, 2, 'Jadwal Konsultasi Tugas', 'Konsultasi tugas dapat dilakukan setiap hari Rabu pukul 13.00-15.00 di ruang dosen.', 'normal', 1);

-- Insert Attendance
INSERT INTO `attendance` (`course_id`, `student_id`, `meeting_number`, `date`, `status`) 
VALUES 
(1, 3, 1, '2025-12-01', 'present'),
(1, 3, 2, '2025-12-08', 'present'),
(1, 3, 3, '2025-12-15', 'present'),
(1, 4, 1, '2025-12-01', 'present'),
(1, 4, 2, '2025-12-08', 'late'),
(1, 4, 3, '2025-12-15', 'present'),
(1, 5, 1, '2025-12-01', 'present'),
(1, 5, 2, '2025-12-08', 'absent'),
(1, 5, 3, '2025-12-15', 'present');

-- ================================================
-- CREATE VIEWS FOR EASY QUERIES
-- ================================================

-- View untuk melihat enrollment dengan detail
CREATE VIEW `view_enrollments_detail` AS
SELECT 
  e.id,
  u.full_name AS student_name,
  u.nim_nip AS student_nim,
  c.code AS course_code,
  c.name AS course_name,
  c.credits,
  e.status,
  e.final_grade,
  e.grade_letter,
  e.enrolled_at
FROM enrollments e
  JOIN users u ON e.student_id = u.id
  JOIN courses c ON e.course_id = c.id;

-- View untuk dashboard mahasiswa
CREATE VIEW `view_student_dashboard` AS
SELECT 
  u.id AS student_id,
  u.full_name,
  u.nim_nip,
  COUNT(DISTINCT e.course_id) AS total_courses,
  COUNT(DISTINCT s.id) AS total_submissions,
  AVG(s.score) AS average_score
FROM users u
  LEFT JOIN enrollments e ON u.id = e.student_id
  LEFT JOIN submissions s ON u.id = s.student_id
WHERE u.role = 'student'
GROUP BY u.id;

-- ================================================
-- STORED PROCEDURES
-- ================================================

DELIMITER $$

-- Procedure untuk menghitung kehadiran mahasiswa
CREATE PROCEDURE `calculate_attendance_percentage`(
  IN p_student_id INT,
  IN p_course_id INT,
  OUT p_percentage DECIMAL(5,2)
)
BEGIN
  DECLARE total_meetings INT;
  DECLARE present_count INT;
  
  SELECT COUNT(*) INTO total_meetings
  FROM attendance
  WHERE course_id = p_course_id;
  
  SELECT COUNT(*) INTO present_count
  FROM attendance
  WHERE course_id = p_course_id 
    AND student_id = p_student_id 
    AND status IN ('present', 'late');
  
  IF total_meetings > 0 THEN
    SET p_percentage = (present_count / total_meetings) * 100;
  ELSE
    SET p_percentage = 0;
  END IF;
END$$

DELIMITER ;

-- ================================================
-- SAMPLE USAGE QUERIES
-- ================================================

-- Query untuk melihat mata kuliah dan dosen
-- SELECT c.code, c.name, u.full_name AS lecturer 
-- FROM courses c 
-- LEFT JOIN users u ON c.lecturer_id = u.id;

-- Query untuk melihat mahasiswa dan mata kuliah yang diambil
-- SELECT * FROM view_enrollments_detail 
-- WHERE student_nim = '2022020100078';

-- Query untuk melihat tugas yang belum dikumpulkan
-- SELECT a.* FROM assignments a
-- LEFT JOIN submissions s ON a.id = s.assignment_id AND s.student_id = 3
-- WHERE s.id IS NULL AND a.is_published = 1;

-- ================================================
-- END OF SCHEMA
-- ================================================
