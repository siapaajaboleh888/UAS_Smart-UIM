# 🧪 CARA TEST YANG BENAR

## ⚠️ PENTING: Clear Data Terlebih Dahulu!

Sebelum melakukan testing, **WAJIB** clear data aplikasi terlebih dahulu untuk memastikan testing bersih dari data lama.

### Cara Clear Data untuk Flutter Web:

#### **Opsi 1: Lewat Browser DevTools** (RECOMMENDED)
1. Buka aplikasi di Chrome
2. Klik kanan > **Inspect** (atau tekan F12)
3. Buka tab **Application**
4. Di sidebar kiri, klik **Storage**
5. Klik tombol **"Clear site data"**
6. **Refresh** halaman (F5 atau Ctrl+R)

#### **Opsi 2: Lewat Console**
1. Buka aplikasi di Chrome
2. Tekan **F12** untuk buka DevTools
3. Buka tab **Console**
4. Ketik dan jalankan:
```javascript
localStorage.clear();
sessionStorage.clear();
location.reload();
```

---

## ✅ Step 1: Registrasi User Baru

### 1.1 Buka Halaman Registrasi
- Dari halaman login, klik tombol **"Daftar Akun Baru"**

### 1.2 Isi Form Registrasi dengan Data BENAR:

```
NIM:              2024455566677
Nama Lengkap:     BUDI SANTOSO
Program Studi:    Sistem Informasi
Angkatan:         2024
Email:            budisantoso@student.uim.ac.id
Nomor Telepon:    081234567890
Password:         test123
Konfirmasi Password: test123
```

### 1.3 Submit Registrasi
1. ✅ **Centang** "Saya setuju dengan Syarat dan Ketentuan..."
2. Klik tombol **"Daftar Sekarang"**

### 1.4 Dialog Berhasil Muncul
Harus muncul dialog **"Registrasi Berhasil!"** dengan detail:
```
Detail Akun:
- NIM: 2024455566677
- Nama: BUDI SANTOSO
- Email: budisantoso@student.uim.ac.id
- Prodi: Sistem Informasi
```

### 1.5 Cek Console Log
Buka Console (F12), harus ada log:
```
✅ Registered new user: BUDI SANTOSO (2024455566677)
✅ Saved 2 registered users  // atau 1 jika default user belum ada
```

---

## ✅ Step 2: Login dengan User Baru

### 2.1 Dari Dialog Registrasi Berhasil
- Klik tombol **"Login Sekarang"**

### 2.2 Isi Form Login:
```
Email:    budisantoso@student.uim.ac.id
Password: test123  // atau password apapun (belum divalidasi)
```

### 2.3 Klik "Login"

### 2.4 Cek Console Log
Harus ada log:
```
🔄 Reloading user data...
✅ Loaded 2 registered users  // atau 1 jika hanya ada 1 user
   - MOH. SYAIFUL ANAM (2022020100078)
   - BUDI SANTOSO (2024455566677)
✅ Loaded current user: BUDI SANTOSO
🔍 Looking for user with: budisantoso@student.uim.ac.id
📊 Total registered users: 2
✅ Found matching user: BUDI SANTOSO (2024455566677)
✅ Login successful: BUDI SANTOSO
```

### 2.5 ✅ EXPECTED RESULT - Halaman Home Menampilkan:
```
Hallo,
BUDI SANTOSO           ← HARUS INI, BUKAN "MOH. SYAIFUL ANAM"!
MAHASISWA

Total Kelas: 7
Tugas Aktif: 0
```

### 2.6 Cek Halaman Profile
1. Klik tab **"Profile"** di bottom navigation
2. Harus menampilkan:
```
Profile
MS  ← Initials dari "Muda Santoso" atau "BUDI SANTOSO"

BUDI SANTOSO           ← HARUS INI!
MAHASISWA

Informasi User
📧 Email address
   budisantoso@student.uim.ac.id

🆔 NIM
   2024455566677

📚 Program Studi
   Sistem Informasi

📅 Angkatan
   2024

📱 Nomor Telepon
   081234567890
```

---

## ❌ Step 3: Testing Login Failed (User Tidak Terdaftar)

### 3.1 Logout Terlebih Dahulu
- Di halaman Profile, scroll ke bawah
- Klik tombol **"Keluar"**

### 3.2 Login dengan Email yang Tidak Terdaftar
```
Email:    userpalsu@uim.ac.id
Password: test123
```

### 3.3 Klik "Login"

### 3.4 ✅ EXPECTED RESULT:
- ❌ **Login HARUS GAGAL**
- Harus muncul SnackBar merah: "Login gagal! Periksa email dan password Anda."
- **TIDAK BOLEH** masuk ke halaman home
- **TIDAK BOLEH** otomatis login dengan user default

### 3.5 Cek Console Log
Harus ada log:
```
🔄 Reloading user data...
🔍 Looking for user with: userpalsu@uim.ac.id
📊 Total registered users: 2
❌ User not found in registered users
```

---

## ✅ Step 4: Testing Login dengan User Default

### 4.1 Login dengan User Default
```
Email:    syaifulanam@uim.ac.id
Password: test123
```

### 4.2 Klik "Login"

### 4.3 ✅ EXPECTED RESULT - Halaman Home Menampilkan:
```
Hallo,
MOH. SYAIFUL ANAM      ← Sekarang ini BENAR
MAHASISWA

Total Kelas: 7
Tugas Aktif: 0
```

### 4.4 Cek Console Log
```
🔄 Reloading user data...
🔍 Looking for user with: syaifulanam@uim.ac.id
📊 Total registered users: 2
✅ Found matching user: MOH. SYAIFUL ANAM (2022020100078)
✅ Login successful: MOH. SYAIFUL ANAM
```

---

## 📊 Checklist Hasil Testing

Isi checklist ini setelah selesai testing:

### Registrasi:
- [ ] Form registrasi bisa diisi dengan lengkap
- [ ] Validasi email harus @uim.ac.id berfungsi
- [ ] Password dan confirm password harus sama
- [ ] Dialog "Registrasi Berhasil" muncul dengan data yang BENAR
- [ ] Data tersimpan di localStorage/SharedPreferences

### Login dengan User Baru (BUDI SANTOSO):
- [ ] Login berhasil dengan email yang baru didaftarkan
- [ ] Halaman Home menampilkan nama **BUDI SANTOSO** (BUKAN "MOH. SYAIFUL ANAM")
- [ ] Halaman Profile menampilkan:
  - [ ] Nama: BUDI SANTOSO
  - [ ] NIM: 2024455566677
  - [ ] Email: budisantoso@student.uim.ac.id
  - [ ] Prodi: Sistem Informasi
  - [ ] Angkatan: 2024
  - [ ] Phone: 081234567890

### Login Gagal:
- [ ] Login dengan email tidak terdaftar HARUS GAGAL
- [ ] Muncul error message yang jelas
- [ ] TIDAK otomatis login dengan user default

### Login dengan User Default:
- [ ] Login dengan syaifulanam@uim.ac.id berhasil
- [ ] Menampilkan data "MOH. SYAIFUL ANAM" yang benar

---

## 🐛 Jika Masih Bermasalah

### Problem: Masih menampilkan data lama/salah

**Solusi:**
1. **WAJIB** clear browser data (lihat bagian atas)
2. Restart aplikasi Flutter (stop dan run ulang)
3. Hard refresh browser (Ctrl + Shift + R)

### Problem: Console menunjukkan "Total registered users: 0"

**Solusi:**
1. Aplikasi pertama kali dijalankan harus auto-create user default
2. Cek console, harus ada: `✅ Initialized default user: MOH. SYAIFUL ANAM`
3. Jika tidak ada, restart aplikasi

### Problem: Data tidak persistent setelah refresh

**Solusi:**
1. Cek apakah SharedPreferences berfungsi
2. Untuk Web, pastikan browser tidak dalam mode Incognito
3. Cek console untuk error saat save/load

---

## 📝 Catatan Tambahan

### Limitation Saat Ini:
1. **Password TIDAK divalidasi** - Semua password akan diterima
2. Data hanya tersimpan di **browser localStorage** (untuk Web)
3. Tidak ada enkripsi untuk data yang tersimpan
4. Tidak ada backend API - semua data lokal

### Untuk Deployment Production:
- [ ] Tambahkan validasi password dengan hashing
- [ ] Implementasi backend API untuk user management
- [ ] Tambahkan token-based authentication (JWT)
- [ ] Enkripsi sensitive data
- [ ] Rate limiting untuk prevent brute force
- [ ] Email verification untuk registrasi

---

**Date:** 2025-12-16  
**Testing Guide Version:** 1.0  
**Status:** Ready for Testing ✅
