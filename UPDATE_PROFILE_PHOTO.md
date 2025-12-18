# Update Profile Screen - Foto Profil & About Me

## ✅ Perubahan yang Telah Dilakukan

### 1. Menambahkan Dependency
**File: `pubspec.yaml`**
- Menambahkan package `image_picker: ^1.0.5` untuk fitur upload foto profil

### 2. Update Model User
**File: `lib/models/user_model.dart`**
- Menambahkan field `photoPath` untuk menyimpan lokasi foto profil
- Update factory method `withPassword()` untuk mendukung parameter `photoPath`
- Update method `toMap()` dan `fromMap()` untuk serialisasi/deserialisasi `photoPath`

### 3. Update User Service
**File: `lib/services/user_service.dart`**
- Menambahkan method `updateUserPhoto()` untuk memperbarui foto profil user
- Method ini akan:
  - Membuat instance user baru dengan foto yang diperbarui
  - Update current user dan registered users list
  - Menyimpan perubahan ke SharedPreferences

### 4. Update Profile Screen
**File: `lib/screens/profile_screen.dart`**

#### a. Import Baru:
```dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
```

#### b. State Variables Baru:
```dart
String? _selectedImagePath;
final ImagePicker _picker = ImagePicker();
```

#### c. Widget Foto Profil yang Diperbaiki:
- Mengganti `CircleAvatar` sederhana dengan widget Stack yang kompleks
- Foto profil sekarang lebih besar (120x120) dengan border putih dan shadow
- Menambahkan tombol edit (ikon kamera) di pojok kanan bawah foto
- Support untuk menampilkan foto dari file (mobile) atau network (web)
- Fallback ke inisial jika foto tidak tersedia

#### d. Method Baru:
1. **`_pickImage()`** - Untuk memilih foto dari galeri:
   - Menggunakan ImagePicker untuk pilih gambar
   - Maksimal resolusi 512x512 dengan quality 85%
   - Update foto profil via UserService
   - Menampilkan notifikasi sukses/error

2. **`_buildProfileImage()`** - Untuk render foto profil:
   - Support web (Image.network) dan mobile (Image.file)
   - Error handling dengan fallback ke inisial
   - Check file existence untuk mobile

3. **`_buildInitialsAvatar()`** - Untuk menampilkan avatar inisial:
   - Digunakan sebagai fallback jika foto tidak ada
   - Background putih dengan text warna primary

#### e. Tab "About Me" yang Diperbaiki:
Menambahkan informasi pribadi yang lebih lengkap:
- ✅ Email address
- ✅ Nomor Induk Mahasiswa
- ✅ **Program Studi** (BARU)
- ✅ **Angkatan** (BARU)
- ✅ **Nomor Telepon** (BARU)
- ✅ Jadwal Kuliah
- ✅ Website
- ✅ Aktivitas Login (First access & Last access)

## 🎯 Fitur yang Ditambahkan

### 1. Upload Foto Profil
- User dapat tap pada foto profil atau tombol kamera untuk memilih foto dari galeri
- Foto akan disimpan dan ditampilkan di semua tempat yang menampilkan profil
- Foto tersimpan di SharedPreferences sehingga tetap ada setelah restart aplikasi

### 2. Informasi Pribadi Lengkap
Tab "About Me" sekarang menampilkan semua data pribadi user:
- Data akademik: NIM, Prodi, Angkatan
- Data kontak: Email, Telepon
- Data aktivitas: Login history

### 3. UI/UX yang Lebih Baik
- Foto profil lebih besar dan eye-catching
- Border dan shadow untuk depth
- Tombol edit yang jelas
- Smooth transitions dan error handling

## 📝 Cara Menggunakan

### Upload Foto Profil:
1. Buka halaman Profile (dari Home screen tap pada profile card)
2. Tap pada foto profil atau tombol kamera di pojok kanan bawah
3. Pilih foto dari galeri
4. Foto akan otomatis diupdate

### Melihat Informasi Pribadi:
1. Buka halaman Profile
2. Tap tab "About Me"
3. Semua informasi pribadi akan ditampilkan secara rapi dan terstruktur

## 🔧 Testing

Untuk menguji fitur ini:

1. **Stop aplikasi yang sedang running** (Ctrl+C di terminal)
2. **Restart aplikasi**:
   ```bash
   flutter run -d chrome
   ```
3. Login dengan user yang sudah ada
4. Buka halaman Profile dari Home screen
5. Test upload foto profil
6. Cek tab "About Me" untuk melihat semua data pribadi

## ⚠️ Catatan untuk Web

Karena aplikasi berjalan di browser (Chrome), ada beberapa limitasi:
- File picker akan membuka dialog browser untuk pilih file
- Foto disimpan sebagai base64 atau path URL (tergantung implementasi browser)
- Untuk produksi, sebaiknya foto diupload ke server dan disimpan URL-nya

## 🚀 Next Steps (Optional Improvements)

1. **Compress foto** sebelum disimpan untuk menghemat storage
2. **Crop foto** agar selalu square/circular
3. **Upload ke cloud storage** (Firebase Storage, AWS S3, dll)
4. **Cache management** untuk foto yang sudah diupload
5. **Edit foto inline** (rotation, filters, etc.)

---

**Status**: ✅ SELESAI - Semua perubahan sudah diimplementasikan
**Perlu Restart**: Ya, restart aplikasi untuk melihat perubahan
