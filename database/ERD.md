# 🗄️ Database Entity Relationship Diagram (ERD)
## Smart UIM LMS - Learning Management System

---

## 📊 ERD Overview

```
┌─────────────────┐
│     USERS       │
├─────────────────┤
│ PK: id          │
│    username     │
│    email        │
│    password     │
│    full_name    │
│    role         │◄─────┐
│    nim_nip      │      │
│    program_studi│      │
│    semester     │      │
│    is_active    │      │
└────┬────────────┘      │
     │                   │
     │ 1:N (lecturer)    │
     │                   │
     ▼                   │ 1:N
┌─────────────────┐      │
│    COURSES      │      │
├─────────────────┤      │
│ PK: id          │      │
│    code         │      │
│    name         │      │
│ FK: lecturer_id │──────┘
│    credits      │
│    semester     │
│    is_active    │
└────┬────────────┘
     │
     │ 1:N
     │
     ├──────────────────┬──────────────────┬──────────────────┬──────────────────┐
     │                  │                  │                  │                  │
     ▼                  ▼                  ▼                  ▼                  ▼
┌──────────┐   ┌──────────────┐  ┌─────────────┐  ┌───────────┐   ┌─────────────┐
│ENROLLMENTS│   │  MATERIALS   │  │ ASSIGNMENTS │  │  QUIZZES  │   │ANNOUNCEMENTS│
├──────────┤   ├──────────────┤  ├─────────────┤  ├───────────┤   ├─────────────┤
│PK: id    │   │PK: id        │  │PK: id       │  │PK: id     │   │PK: id       │
│FK:student│───┐│FK:course_id │  │FK:course_id │  │FK:course │   │FK:course_id │
│FK:course │   ││   title     │  │   title     │  │   title   │   │FK:author_id │
│  status  │   ││   type      │  │   due_date  │  │   duration│   │   title     │
│  grade   │   ││   file_url  │  │   max_score │  │   start   │   │   content   │
└──────────┘   │└──────────────┘  └─────┬───────┘  │   end     │   │   priority  │
     │         │                        │          └───────────┘   └─────────────┘
     │         │                        │ 1:N
     │         │                        │
     │         │                        ▼
     │         │                  ┌─────────────┐
     │         │                  │ SUBMISSIONS │
     │         │                  ├─────────────┤
     │         │                  │PK: id       │
     │         │                  │FK:assignment│
     │         └──────────────────►FK:student_id│
     │                            │   file_url  │
     │                            │   score     │
     │                            │   status    │
     │                            └─────────────┘
     │
     │ 1:N
     │
     ▼
┌─────────────┐
│ ATTENDANCE  │
├─────────────┤
│PK: id       │
│FK:course_id │
│FK:student_id│
│   meeting_no│
│   date      │
│   status    │
└─────────────┘
```

---

## 📋 Table Relationships

### Primary Relationships

| Parent Table | Child Table | Relationship | Foreign Key | On Delete |
|-------------|-------------|--------------|-------------|-----------|
| `users` (lecturer) | `courses` | 1:N | `lecturer_id` | SET NULL |
| `users` (student) | `enrollments` | 1:N | `student_id` | CASCADE |
| `courses` | `enrollments` | 1:N | `course_id` | CASCADE |
| `courses` | `materials` | 1:N | `course_id` | CASCADE |
| `courses` | `assignments` | 1:N | `course_id` | CASCADE |
| `courses` | `quizzes` | 1:N | `course_id` | CASCADE |
| `courses` | `announcements` | 1:N (optional) | `course_id` | CASCADE |
| `courses` | `attendance` | 1:N | `course_id` | CASCADE |
| `users` (author) | `announcements` | 1:N | `author_id` | CASCADE |
| `users` (student) | `attendance` | 1:N | `student_id` | CASCADE |
| `users` (student) | `submissions` | 1:N | `student_id` | CASCADE |
| `assignments` | `submissions` | 1:N | `assignment_id` | CASCADE |

---

## 🔑 Key Fields

### users
- **PK**: `id` (INT, AUTO_INCREMENT)
- **Unique**: `username`, `email`
- **Enum**: `role` (admin, lecturer, student)
- **Index**: `role`, `email`

### courses
- **PK**: `id` (INT, AUTO_INCREMENT)
- **Unique**: `code`
- **FK**: `lecturer_id` → `users(id)`
- **Index**: `code`, `lecturer_id`

### enrollments
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `student_id` → `users(id)`, `course_id` → `courses(id)`
- **Unique**: (`student_id`, `course_id`) - Prevent duplicate enrollment
- **Enum**: `status` (active, completed, dropped)

### materials
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `course_id` → `courses(id)`
- **Enum**: `type` (video, pdf, ppt, doc, link, other)

### assignments
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `course_id` → `courses(id)`
- **Index**: `course_id`, `due_date`

### submissions
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `assignment_id` → `assignments(id)`, `student_id` → `users(id)`
- **Unique**: (`assignment_id`, `student_id`) - One submission per student
- **Enum**: `status` (submitted, late, graded, revision)

### quizzes
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `course_id` → `courses(id)`

### announcements
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `course_id` → `courses(id)` (nullable), `author_id` → `users(id)`
- **Enum**: `priority` (low, normal, high, urgent)

### attendance
- **PK**: `id` (INT, AUTO_INCREMENT)
- **FK**: `course_id` → `courses(id)`, `student_id` → `users(id)`
- **Unique**: (`course_id`, `student_id`, `meeting_number`)
- **Enum**: `status` (present, absent, excused, late)

---

## 🔍 Database Constraints

### Foreign Key Constraints

```sql
-- Users to Courses
ALTER TABLE courses 
  ADD CONSTRAINT fk_courses_lecturer 
  FOREIGN KEY (lecturer_id) REFERENCES users(id) 
  ON DELETE SET NULL;

-- Courses to Enrollments
ALTER TABLE enrollments
  ADD CONSTRAINT fk_enrollments_course
  FOREIGN KEY (course_id) REFERENCES courses(id)
  ON DELETE CASCADE;

-- Users to Enrollments
ALTER TABLE enrollments
  ADD CONSTRAINT fk_enrollments_student
  FOREIGN KEY (student_id) REFERENCES users(id)
  ON DELETE CASCADE;

-- Courses to Materials
ALTER TABLE materials
  ADD CONSTRAINT fk_materials_course
  FOREIGN KEY (course_id) REFERENCES courses(id)
  ON DELETE CASCADE;

-- Courses to Assignments
ALTER TABLE assignments
  ADD CONSTRAINT fk_assignments_course
  FOREIGN KEY (course_id) REFERENCES courses(id)
  ON DELETE CASCADE;

-- Assignments to Submissions
ALTER TABLE submissions
  ADD CONSTRAINT fk_submissions_assignment
  FOREIGN KEY (assignment_id) REFERENCES assignments(id)
  ON DELETE CASCADE;

-- Users to Submissions
ALTER TABLE submissions
  ADD CONSTRAINT fk_submissions_student
  FOREIGN KEY (student_id) REFERENCES users(id)
  ON DELETE CASCADE;

-- Courses to Attendance
ALTER TABLE attendance
  ADD CONSTRAINT fk_attendance_course
  FOREIGN KEY (course_id) REFERENCES courses(id)
  ON DELETE CASCADE;

-- Users to Attendance
ALTER TABLE attendance
  ADD CONSTRAINT fk_attendance_student
  FOREIGN KEY (student_id) REFERENCES users(id)
  ON DELETE CASCADE;
```

---

## 📈 Sample Queries

### 1. Get All Courses for a Student
```sql
SELECT c.*, u.full_name AS lecturer_name, e.status, e.final_grade
FROM enrollments e
JOIN courses c ON e.course_id = c.id
LEFT JOIN users u ON c.lecturer_id = u.id
WHERE e.student_id = 3;
```

### 2. Get All Assignments with Submission Status
```sql
SELECT 
  a.id, 
  a.title, 
  a.due_date, 
  c.name AS course_name,
  CASE 
    WHEN s.id IS NOT NULL THEN 'Submitted'
    ELSE 'Not Submitted'
  END AS submission_status,
  s.score
FROM assignments a
JOIN courses c ON a.course_id = c.id
LEFT JOIN submissions s ON a.id = s.assignment_id AND s.student_id = 3
WHERE a.is_published = 1
ORDER BY a.due_date ASC;
```

### 3. Calculate Student Attendance Percentage
```sql
SELECT 
  u.full_name,
  c.name AS course_name,
  COUNT(*) AS total_meetings,
  SUM(CASE WHEN att.status IN ('present', 'late') THEN 1 ELSE 0 END) AS attended,
  ROUND((SUM(CASE WHEN att.status IN ('present', 'late') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS attendance_percentage
FROM attendance att
JOIN users u ON att.student_id = u.id
JOIN courses c ON att.course_id = c.id
WHERE att.student_id = 3
GROUP BY u.id, c.id;
```

### 4. Get Student Dashboard Statistics
```sql
SELECT 
  u.full_name,
  COUNT(DISTINCT e.course_id) AS enrolled_courses,
  COUNT(DISTINCT s.id) AS total_submissions,
  AVG(s.score) AS average_score,
  COUNT(DISTINCT CASE WHEN s.status = 'graded' THEN s.id END) AS graded_assignments
FROM users u
LEFT JOIN enrollments e ON u.id = e.student_id
LEFT JOIN submissions s ON u.id = s.student_id
WHERE u.id = 3
GROUP BY u.id;
```

---

## 🎨 Normalization

Database ini sudah dalam bentuk **Third Normal Form (3NF)**:

1. **1NF**: Setiap kolom berisi atomic values
2. **2NF**: Tidak ada partial dependencies (all non-key attributes depend on entire PK)
3. **3NF**: Tidak ada transitive dependencies

### Contoh Normalisasi:
- ❌ Tidak menyimpan `lecturer_name` di tabel `courses` (akan redundant)
- ✅ Menggunakan FK `lecturer_id` yang merujuk ke tabel `users`
- ❌ Tidak menyimpan `course_name` di tabel `enrollments`
- ✅ Menggunakan FK `course_id` yang merujuk ke tabel `courses`

---

## 📊 Database Statistics (Sample Data)

| Table | Record Count | Description |
|-------|--------------|-------------|
| users | 5 | 1 admin, 2 lecturers, 3 students |
| courses | 4 | TIF701-TIF704 |
| enrollments | 7 | Active enrollments |
| materials | 7+ | PDF, Video, PPT |
| assignments | 4+ | Tugas per course |
| submissions | varies | Student submissions |
| quizzes | 0 | Ready for data |
| announcements | 3+ | Course & general |
| attendance | 9+ | Sample attendance records |

---

**Document Version**: 1.0  
**Last Updated**: 15 Desember 2025  
**Author**: Moh. Syaiful Anam (2022020100078)
