# 📱 Smart UIM - Learning Management System
## Universitas Islam Madura (UIM)

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

## 👨‍🎓 INFORMASI MAHASISWA

| Data | Keterangan |
|------|------------|
| **Nama** | Moh. Syaiful Anam |
| **NIM** | 2022020100078 |
| **Program Studi** | Teknik Informatika |
| **Universitas** | Universitas Islam Madura (UIM) |
| **Mata Kuliah** | Pemrograman Mobile |
| **Dosen** | Rofi Uddin, S.Kom., M.Kom |

---

## 📝 DESKRIPSI PROYEK

**Smart UIM** adalah aplikasi Learning Management System berbasis Flutter yang dirancang khusus untuk mahasiswa Universitas Islam Madura. Aplikasi ini menggunakan tema warna hijau yang konsisten dan modern dengan Material Design 3.

---

## ✨ FITUR UTAMA

### 1. 🚀 **Splash Screen**
- Animasi fade dan scale yang smooth
- Logo Smart UIM dengan background gradient hijau
- Auto-redirect ke Login setelah 3 detik

### 2. 🔐 **Login Screen**
- Form login dengan validasi
- Password visibility toggle
- Format email: username@uim.ac.id
- Informasi bantuan IT Helpdesk UIM

### 3. 🏠 **Home/Dashboard**
- Greeting mahasiswa
- Statistik kelas dan tugas aktif
- Daftar tugas yang akan datang
- Pengumuman terbaru
- Progress kelas dengan visualisasi

### 4. 📚 **Kelas Saya**
- Daftar 7 mata kuliah:
  1. Pemrograman Mobile (92%)
  2. UI/UX Design (88%)
  3. Basis Data (90%)
  4. Jaringan Komputer (85%)
  5. Algoritma & Struktur Data (91%)
  6. Rekayasa Perangkat Lunak (87%)
  7. Kecerdasan Buatan (89%)

### 5. 👤 **Profile Screen**
- Informasi lengkap mahasiswa
- Statistik kelas dan tugas
- Menu pengaturan
- Logout dengan konfirmasi

### 6. 🧭 **Bottom Navigation**
- Navigasi mudah: Home, Kelas Saya, Profile
- Icon yang jelas dengan animasi

---

## 🎨 DESIGN SYSTEM

### Skema Warna
- **Primary Green**: `#009247`
- **Primary Dark**: `#006B33`
- **Primary Light**: `#33A669`
- **Accent Gold**: `#FDB515`
- **Background**: `#F5F7FA`
- **Surface**: `#FFFFFF`

### Typography
- **Font**: Inter (Google Fonts)
- **Heading**: 24-32px, Bold
- **Body**: 14-16px, Regular
- **Caption**: 12px, Regular

---

## 🏗️ STRUKTUR PROYEK

```
smart_uim/
├── lib/
│   ├── main.dart
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   ├── models/
│   │   ├── course.dart
│   │   ├── assignment.dart
│   │   └── announcement.dart
│   └── screens/
│       ├── splash_screen.dart
│       ├── login_screen.dart
│       ├── main_screen.dart
│       ├── home_screen.dart
│       ├── courses_screen.dart
│       └── profile_screen.dart
├── pubspec.yaml
└── README.md
```

---

## 📦 DEPENDENCIES

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.2.1
  intl: ^0.19.0
```

---

## 🚀 CARA MENJALANKAN

### Prasyarat
- Flutter SDK 3.0.0+
- Dart SDK 3.0.0+
- Chrome / Android Emulator

### Langkah-langkah

#### 1. Clone Repository
```bash
git clone https://github.com/siapaajaboleh888/UAS_Smart-UIM.git
cd UAS_Smart-UIM
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Run Aplikasi

**Di Chrome (Web):**
```bash
flutter run -d chrome
```

**Di Android Emulator:**
```bash
flutter run
```

**Build APK:**
```bash
flutter build apk --release
```

---

## 🎯 PRINSIP UI/UX YANG DITERAPKAN

### Design Principles:
1. ✅ **Consistency** - Warna, font, dan spacing seragam
2. ✅ **Visual Hierarchy** - Typography dan size yang jelas
3. ✅ **Feedback** - Loading states dan validations
4. ✅ **Accessibility** - Kontras warna yang baik
5. ✅ **Aesthetics** - Gradient, shadows, dan animations

### 20 Prinsip UI Design:
- Clarity, Consistency, Hierarchy
- Alignment, Proximity, Contrast
- Repetition, White Space, Feedback
- Affordance, Visibility, Flexibility
- Efficiency, Learnability, Memorability
- Error Prevention, Error Recovery
- User Control, Aesthetic, Performance

---

## 📊 DATA MODEL

### Course
```dart
- id, name, code, instructor
- semester, progress, totalStudents
```

### Assignment
```dart
- id, title, courseCode, deadline
- isSubmitted, fileName, grade
```

### Announcement
```dart
- id, title, content, author, date
```

---

## 💡 FITUR TEKNIS

- ✅ Animasi fade & scale
- ✅ Form validation
- ✅ State management (StatefulWidget)
- ✅ Navigation (Navigator)
- ✅ Material Design 3
- ✅ Google Fonts (Inter)
- ✅ Responsive layout
- ✅ Custom theme
- ✅ Gradient backgrounds
- ✅ Progress indicators

---

## 📱 SCREENSHOT

### Splash Screen
![Splash](screenshots/splash.png)

### Login
![Login](screenshots/login.png)

### Home
![Home](screenshots/home.png)

### Courses
![Courses](screenshots/courses.png)

### Profile
![Profile](screenshots/profile.png)

---

## ✅ STATUS

- **Development**: ✅ Complete
- **Testing**: ✅ Passed
- **Documentation**: ✅ Complete
- **Deployment**: ✅ Ready

---

## 📝 CHANGELOG

### Version 1.0.0 (15 Desember 2025)
- ✅ Initial release
- ✅ Splash screen dengan animasi
- ✅ Login screen dengan validasi
- ✅ Home dashboard lengkap
- ✅  7 mata kuliah
- ✅ Profile screen
- ✅ Bottom navigation
- ✅ Warna hijau branding
- ✅ Material Design 3

---

## 🎓 UNTUK TUGAS

**Mata Kuliah**: Pemrograman Mobile  
**Dosen**: Rofi Uddin, S.Kom., M.Kom  
**Semester**: Genap 2024/2025  
**Deadline**: 31 Desember 2025, 23:59 WIB  

---

## 📞 KONTAK

**Moh. Syaiful Anam**  
- Email: syaifulanam@uim.ac.id
- NIM: 2022020100078
- Prodi: Teknik Informatika
- Universitas: Universitas Islam Madura

---

## 📄 LICENSE

MIT License - see [LICENSE](LICENSE) file for details

---

## 🙏 ACKNOWLEDGMENTS

- Flutter Team
- Material Design Team
- Google Fonts
- Universitas Islam Madura
- Rofi Uddin, S.Kom., M.Kom (Dosen Pembimbing)

---

**© 2025 Smart UIM - Universitas Islam Madura**  
_Learning Management System Mobile Application_

---

## 🌟 STAR THIS REPO!

If you find this project useful, please give it a ⭐️!

[![GitHub stars](https://img.shields.io/github/stars/siapaajaboleh888/UAS_Smart-UIM?style=social)](https://github.com/siapaajaboleh888/UAS_Smart-UIM/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/siapaajaboleh888/UAS_Smart-UIM?style=social)](https://github.com/siapaajaboleh888/UAS_Smart-UIM/network/members)
