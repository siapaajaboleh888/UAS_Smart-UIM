# 📱 LMS CeLOE - Learning Management System Telkom University

## 👨‍🎓 Informasi Mahasiswa
- **Nama**: DANDY CANDRA PRATAMA
- **NIM**: 7708170114
- **Program Studi**: D4 Teknologi Rekayasa Multimedia
- **Fakultas**: FIT
- **Mata Kuliah**: MOBILE PROGRAMMING
- **Kelas**: B 22

## 📝 Deskripsi Proyek

Aplikasi **LMS CeLOE** adalah aplikasi Learning Management System berbasis Flutter yang dirancang khusus untuk mahasiswa Telkom University. Aplikasi ini menggunakan tema warna hijau yang konsisten dengan identitas visual Telkom University.

## ✨ Fitur Utama

### 1. **Splash Screen**
- Animasi fade dan scale yang smooth
- Logo CeLOE dengan background gradient hijau Telkom
- Loading indicator

### 2. **Login Screen**
- Form login dengan validasi email dan password
- Password visibility toggle
- Informasi bantuan login dengan kontak CeLOE Helpdesk
- Design modern dengan gradient header

### 3. **Home/Dashboard**
- Greeting dengan nama mahasiswa dan foto profil
- Statistik kelas dan tugas aktif
- Daftar tugas yang akan datang
- Pengumuman terbaru dari admin
- Progress kelas
- Sliver app bar dengan animasi scroll

### 4. **Kelas Saya (My Courses)**
- Daftar semua kelas yang diikuti
- Progress bar untuk setiap kelas
- Informasi dosen dan jumlah mahasiswa
- Card design yang modern dan informatif

### 5. **Profile**
- Informasi lengkap mahasiswa
- Statistik kelas dan tugas
- Menu pengaturan
- Tombol logout dengan konfirmasi

### 6. **Bottom Navigation**
- Navigasi mudah antara Home, Kelas Saya, dan Profile
- Icon yang jelas dengan animasi

## 🎨 Design System

### Warna (Telkom University Green Theme)
- **Primary**: `#009247` (Hijau Telkom)
- **Primary Dark**: `#006B33`
- **Primary Light**: `#33A669`
- **Accent**: `#FDB515` (Emas)
- **Background**: `#F5F7FA`
- **Surface**: `#FFFFFF`

### Typography
- Font: **Inter** (Google Fonts)
- Heading: Bold, sizes 24-32px
- Body: Regular/Medium, sizes 14-16px

### Components
- Border radius: 12-16px untuk cards dan buttons
- Shadow: Subtle shadows untuk depth
- Gradient: Used untuk header dan primary elements

## 🏗️ Struktur Proyek

```
lib/
├── constants/
│   ├── app_colors.dart          # Color palette
│   └── app_theme.dart           # Theme configuration
├── models/
│   ├── course.dart              # Course model
│   ├── assignment.dart          # Assignment model
│   └── announcement.dart        # Announcement model
├── screens/
│   ├── splash_screen.dart       # Splash screen
│   ├── login_screen.dart        # Login page
│   ├── main_screen.dart         # Main screen with bottom nav
│   ├── home_screen.dart         # Dashboard/Home
│   ├── courses_screen.dart      # My courses list
│   └── profile_screen.dart      # User profile
└── main.dart                     # App entry point
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.2.1          # Typography
  flutter_svg: ^2.0.10+1        # SVG support
  intl: ^0.19.0                 # Date formatting
```

## 🚀 Cara Menjalankan

1. **Install Dependencies**
   ```bash
   cd lms_celoe_app
   flutter pub get
   ```

2. **Run pada Chrome (Web)**
   ```bash
   flutter run -d chrome
   ```

3. **Run pada Android Emulator**
   ```bash
   flutter run -d emulator
   ```

4. **Build APK untuk Android**
   ```bash
   flutter build apk --release
   ```

## 📱 Screenshots

### Splash Screen
- Animasi loading dengan logo CeLOE
- Background gradient hijau Telkom

### Login Screen
- Form login yang user-friendly
- Validasi input
- Informasi bantuan

### Home Screen
- Dashboard dengan statistik
- Tugas yang akan datang
- Pengumuman terbaru
- Progress kelas

### Courses Screen
- Daftar kelas dengan detail
- Progress tracking
- Info dosen dan mahasiswa

### Profile Screen
- Informasi lengkap user
- Statistik
- Pengaturan
- Logout

## 🎯 Keunggulan Aplikasi

1. **Design Premium**: Menggunakan warna hijau Telkom University yang konsisten
2. **User Experience**: Navigasi intuitif dengan bottom navigation
3. **Modern UI**: Material Design 3 dengan gradient dan shadow
4. **Responsive**: Menyesuaikan dengan berbagai ukuran layar
5. **Performant**: Smooth animations dan transitions
6. **Clean Code**: Struktur kode yang terorganisir dengan baik

## 📐 Design Principles

1. **Consistency**: Warna, typography, dan spacing yang konsisten
2. **Hierarchy**: Visual hierarchy yang jelas
3. **Feedback**: Loading states dan validations
4. **Accessibility**: Readable fonts dan good contrast ratio
5. **Aesthetics**: Beautiful gradients, shadows, dan animations

## 🔐 Kredensial Login (Demo)

- **Email**: (Any valid email format)
- **Password**: (Minimal 6 karakter)

*Note: Ini adalah aplikasi demo, kredensial apapun yang valid akan diterima*

## 📝 Catatan Pengembangan

- Aplikasi ini dibuat mengikuti requirement tugas UAS
- Menggunakan warna hijau sesuai identitas Telkom University
- Semua data adalah data sample untuk demo
- Siap untuk integrasi dengan backend API

## 🎓 Referensi

- Flutter Documentation: https://flutter.dev/docs
- Material Design 3: https://m3.material.io
- Google Fonts: https://fonts.google.com

## 📞 Kontak

**Dandy Candra Pratama**
- Email: dandycandra@365.telkomuniversity.ac.id
- Universitas: Telkom University
- Fakultas: FIT
- Prodi: D4 Teknologi Rekayasa Multimedia

---

**© 2021 CeLOE - Telkom University**
*Learning Management System Mobile Application*
