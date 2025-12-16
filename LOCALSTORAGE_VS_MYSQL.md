# 📊 Penjelasan: Database MySQL vs localStorage

## ❓ Pertanyaan User

> "berarti cuma di gambar 2 yang belum sinkron. di db saya gambar 4 user baru juga belum terilihat"

## ✅ Jawaban

Berdasarkan screenshot yang Anda kirim, saya perlu menjelaskan bahwa ada **2 sistem penyimpanan yang BERBEDA**:

---

## 🔴 Sistem 1: Database MySQL (Gambar 4 - Tidak Digunakan Saat Ini)

### Lokasi
- Screenshot gambar 4 menunjukkan **phpMyAdmin/MySQL** database `smart_uim`
- Database ini berada di **MySQL Server** (port 3306)

### Isi Database
```
Table: users
- admin@uim.ac.id (Administrator)
- dosen1@uim.ac.id (Dr. Ahmad Fauzi)  
- dosen2@uim.ac.id (Siti Nur Azizah)
- syaiful@student.uim.ac.id (Moh. Syaiful Anam - 2022020100078)
- student2@student.uim.ac.id (Fatimah Zahra - 2022020100079)
- student3@student.uim.ac.id (Muhammad Rizki - 2022020100080)
```

### ⚠️ STATUS: **TIDAK DIGUNAKAN oleh Flutter App**

Database MySQL ini adalah **database terpisah** yang:
- Dibuat dari file `database/smart_uim_schema.sql`
- Berisi sample data hardcoded
- **TIDAK terhubung** dengan aplikasi Flutter saat ini
- Tidak ada API backend yang menghubungkan Flutter dengan MySQL

---

## 🟢 Sistem 2: localStorage/SharedPreferences (Yang Digunakan)

### Lokasi
- **Browser localStorage** (untuk Flutter Web di Chrome)
- **SharedPreferences** (untuk Flutter Mobile)

### Cara Kerja
```
Registration → UserService → localStorage
    ↓              ↓              ↓
"ikrom"    → registerUser()  → Saved to browser
                                 (Key: 'registered_users')
```

### Data yang Tersimpan
```json
// Key: "registered_users"
[
  {
    "nim": "2022020100078",
    "nama": "MOH. SYAIFUL ANAM",
    "email": "syaifulanam@uim.ac.id",
    ...
  },
  {
    "nim": "2022020100099",
    "nama": "ikrom",
    "email": "ikrom@student.uim.ac.id",
    ...
  }
]

// Key: "current_user"
{
  "nim": "2022020100099",
  "nama": "ikrom",
  ...
}
```

### ✅ STATUS: **SEDANG DIGUNAKAN**

---

## 📋 Perbandingan

| Aspek | MySQL Database | localStorage |
|-------|----------------|--------------|
| **Lokasi** | MySQL Server (port 3306) | Browser/Device |
| **Akses** | Via phpMyAdmin | Via DevTools |
| **Persistent** | Ya, tetap ada di server | Ya, tetap di browser (kecuali clear data) |
| **Multi-user** | Ya, shared between users | **TIDAK**, per-user/per-browser |
| **Backend** | Perlu backend API | Tidak perlu backend |
| **Digunakan?** | ❌ TIDAK | ✅ YA |

---

## 🎯 Kenapa User Baru Tidak Muncul di MySQL?

### Jawaban Singkat
**Karena aplikasi Flutter TIDAK menulis ke MySQL!**

### Penjelasan Detail

Saat user registrasi:
```
User fills form → Register button clicked
    ↓
    UserService.registerUser() called
    ↓
    Data saved to SharedPreferences (localStorage)
    ↓
    NO API call to backend ❌
    ↓
    Data TIDAK masuk ke MySQL ❌
```

**Flow yang seharusnya** (jika mau pakai MySQL):
```
User fills form → Register button clicked
    ↓
    HTTP POST ke Backend API (/api/register)
    ↓
    Backend saves to MySQL database
    ↓
    Return response to Flutter
    ↓
    Flutter saves to localStorage (cache)
```

---

## 🔧 Solusi untuk Menyimpan ke MySQL

### Opsi 1: Tetap Pakai localStorage (Current - Recommended untuk Development)

**Kelebihan:**
✅ Tidak perlu setup backend  
✅ Tidak perlu server  
✅ Cepat untuk testing/demo  
✅ Data persistent di browser

**Kekurangan:**
❌ Data hanya ada di satu device/browser  
❌ Tidak bisa multi-user  
❌ Data hilang jika clear browser data

### Opsi 2: Implementasi Backend API + MySQL (Production)

**Yang Perlu Dilakukan:**
1. **Setup Backend Server**
   - Laravel (recommended - karena sudah ada schema.sql)
   - Node.js + Express
   - PHP native

2. **Create API Endpoints**
   ```
   POST   /api/register      - Register user baru
   POST   /api/login         - Login user
   GET    /api/user/profile  - Get user profile
   PUT    /api/user/profile  - Update profile
   POST   /api/logout        - Logout user
   ```

3. **Implement Authentication**
   - JWT (JSON Web Token)
   - Session-based
   - OAuth2

4. **Update Flutter App**
   - Add `http` package
   - Create API service class
   - Replace localStorage calls dengan API calls
   - Handle authentication token

**Estimasi Waktu:** 3-5 hari development

**File yang Perlu Dibuat/Diubah:**
```
Backend:
  - routes/api.php (untuk Laravel)
  - app/Http/Controllers/AuthController.php
  - app/Http/Controllers/UserController.php
  - app/Models/User.php (sudah ada di schema.sql)

Flutter:
  - lib/services/api_service.dart (NEW)
  - lib/services/auth_service.dart (NEW)
  - lib/services/user_service.dart (UPDATE - call API instead of localStorage)
  - lib/config/app_config.dart (NEW - API base URL)
```

---

## 🎓 Rekomendasi

### Untuk UAS/Demo Project:
**Gunakan localStorage** (current implementation) ✅
- Sudah cukup untuk demonstrasi
- Tidak perlu kompleksitas backend
- Focus pada Flutter UI/UX

### Untuk Production/Real Application:
**Gunakan Backend API + MySQL** 🚀
- Data persistent di server
- Multi-user support
- Scalable
- Secure

---

## 🔍 Cara Cek Data di localStorage (Flutter Web)

1. Buka aplikasi di Chrome
2. Kanan klik > **Inspect** (F12)
3. Tab **Application**
4. Sidebar: **Storage** > **Local Storage** > `http://localhost:xxxx`
5. Cari key:
   - `flutter.registered_users`
   - `flutter.current_user`
6. Double-click value untuk lihat JSON data

Screenshot example:
```
Key: flutter.registered_users
Value: [{"nim":"2022020100078","nama":"MOH. SYAIFUL ANAM",...},...]
```

---

**Kesimpulan:**  
Data user baru **SUDAH TERSIMPAN** di localStorage browser Anda, tetapi **TIDAK TERSIMPAN** di MySQL karena aplikasi tidak menggunakan MySQL sama sekali. Ini adalah behavior yang benar untuk aplikasi development saat ini.

---

**Date:** 2025-12-16  
**Author:** Antigravity AI Assistant
