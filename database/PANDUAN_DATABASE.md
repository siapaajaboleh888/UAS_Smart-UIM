# 🗄️ Panduan Setup Database Smart UIM LMS

## 📋 Informasi Database

- **Nama Database**: `smart_uim`
- **Character Set**: `utf8mb4`
- **Collation**: `utf8mb4_unicode_ci`
- **MySQL Version**: 5.7+ atau 8.0+

---

## 🚀 Cara Import Database

### Method 1: Menggunakan MySQL Workbench

1. **Buka MySQL Workbench**
2. **Buat koneksi** ke MySQL Server (biasanya localhost)
   - Host: `127.0.0.1` atau `localhost`
   - Port: `3306` (default)
   - Username: `root`
   - Password: (sesuai password MySQL Anda)

3. **Import Schema**:
   - Klik menu **Server** → **Data Import**
   - Pilih **Import from Self-Contained File**
   - Browse ke file: `e:\SEMESTER 7\Flutter\UAS\lms_celoe_app\database\smart_uim_schema.sql`
   - Pilih **Default Target Schema**: `smart_uim` (akan dibuat otomatis)
   - Klik **Start Import**

4. **Verifikasi Import**:
   ```sql
   USE smart_uim;
   SHOW TABLES;
   SELECT COUNT(*) FROM users;
   ```

### Method 2: Menggunakan Command Line (MySQL CLI)

```bash
# Masuk ke MySQL
mysql -u root -p

# Atau langsung import
mysql -u root -p < "e:\SEMESTER 7\Flutter\UAS\lms_celoe_app\database\smart_uim_schema.sql"
```

### Method 3: Menggunakan phpMyAdmin (XAMPP)

1. Buka **XAMPP Control Panel**
2. Start **Apache** dan **MySQL**
3. Buka browser: `http://localhost/phpmyadmin`
4. Klik tab **Import**
5. Pilih file `smart_uim_schema.sql`
6. Klik **Go**

---

## 📊 Struktur Database

### Tabel Utama

| No | Tabel | Deskripsi |
|----|-------|-----------|
| 1 | `users` | Data pengguna (admin, dosen, mahasiswa) |
| 2 | `courses` | Data mata kuliah |
| 3 | `enrollments` | Data pendaftaran mahasiswa ke mata kuliah |
| 4 | `materials` | Materi pembelajaran |
| 5 | `assignments` | Data tugas |
| 6 | `submissions` | Pengumpulan tugas mahasiswa |
| 7 | `quizzes` | Data kuis/ujian |
| 8 | `announcements` | Pengumuman |
| 9 | `attendance` | Data kehadiran |

### Views

- `view_enrollments_detail`: Detail enrollment dengan nama lengkap
- `view_student_dashboard`: Dashboard statistik mahasiswa

### Stored Procedures

- `calculate_attendance_percentage`: Menghitung persentase kehadiran mahasiswa

---

## 👤 Default User Accounts

### 1. Admin
- **Username**: `admin`
- **Password**: `password` (hash: bcrypt)
- **Email**: `admin@uim.ac.id`
- **Role**: `admin`

### 2. Dosen 1
- **Username**: `dosen1`
- **Password**: `password`
- **Email**: `dosen1@uim.ac.id`
- **Role**: `lecturer`
- **NIP**: `NIP123456`

### 3. Dosen 2
- **Username**: `dosen2`
- **Password**: `password`
- **Email**: `dosen2@uim.ac.id`
- **Role**: `lecturer`
- **NIP**: `NIP123457`

### 4. Mahasiswa (Syaiful)
- **Username**: `2022020100078`
- **Password**: `password`
- **Email**: `syaiful@student.uim.ac.id`
- **Role**: `student`
- **NIM**: `2022020100078`
- **Program Studi**: `Teknik Informatika`
- **Semester**: `7`

### 5. Mahasiswa Lainnya
- **Username**: `2022020100079` & `2022020100080`
- **Password**: `password`

> ⚠️ **PENTING**: Semua password default adalah `password`. 
> Untuk mengubah password, gunakan bcrypt hash generator.

---

## 🔧 Sample Queries

### 1. Melihat Semua Mata Kuliah
```sql
SELECT c.code, c.name, u.full_name AS lecturer_name 
FROM courses c 
LEFT JOIN users u ON c.lecturer_id = u.id;
```

### 2. Melihat Enrollment Mahasiswa Tertentu
```sql
SELECT * FROM view_enrollments_detail 
WHERE student_nim = '2022020100078';
```

### 3. Melihat Tugas yang Belum Dikumpulkan
```sql
SELECT a.* FROM assignments a
LEFT JOIN submissions s ON a.id = s.assignment_id AND s.student_id = 3
WHERE s.id IS NULL AND a.is_published = 1;
```

### 4. Menghitung Persentase Kehadiran
```sql
CALL calculate_attendance_percentage(3, 1, @percentage);
SELECT @percentage AS attendance_percentage;
```

### 5. Dashboard Mahasiswa
```sql
SELECT * FROM view_student_dashboard 
WHERE student_id = 3;
```

---

## 🔐 Konfigurasi Koneksi Database

Jika Anda menggunakan backend (Laravel/PHP), buat file `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=smart_uim
DB_USERNAME=root
DB_PASSWORD=
```

Jika menggunakan Node.js:

```javascript
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'smart_uim'
});
```

---

## ✅ Verifikasi Database

Setelah import, jalankan query berikut untuk verifikasi:

```sql
-- Cek jumlah tabel
USE smart_uim;
SELECT COUNT(*) AS total_tables 
FROM information_schema.tables 
WHERE table_schema = 'smart_uim';

-- Cek data users
SELECT role, COUNT(*) AS total 
FROM users 
GROUP BY role;

-- Cek data courses
SELECT COUNT(*) AS total_courses FROM courses;

-- Cek data enrollments
SELECT COUNT(*) AS total_enrollments FROM enrollments;
```

**Expected Results**:
- Total Tables: 9
- Users: 5 (1 admin, 2 lecturer, 3 student)
- Courses: 4
- Enrollments: 7

---

## 🐛 Troubleshooting

### Error: "Access denied for user"
**Solusi**: Periksa username dan password MySQL Anda

### Error: "Unknown database 'smart_uim'"
**Solusi**: Database akan otomatis dibuat saat import. Pastikan user memiliki privilege CREATE DATABASE

### Error: "You have an error in your SQL syntax"
**Solusi**: Pastikan MySQL version minimal 5.7

### Koneksi ke MySQL gagal
**Solusi**: 
1. Pastikan XAMPP MySQL sudah running
2. Cek port 3306 tidak digunakan aplikasi lain
3. Restart MySQL service

---

## 📝 Catatan

- Password default (`password`) menggunakan bcrypt hash: `$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi`
- Untuk production, ganti semua password default
- Backup database secara berkala
- Aktifkan foreign key constraints untuk data integrity

---

## 📞 Support

Jika mengalami masalah, hubungi:
- **Developer**: Moh. Syaiful Anam
- **NIM**: 2022020100078
- **Program Studi**: Teknik Informatika
- **Universitas**: Universitas Islam Madura

---

**Last Updated**: 15 Desember 2025
