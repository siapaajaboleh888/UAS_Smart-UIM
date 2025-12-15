# 📱 LAPORAN TUGAS UAS - MOBILE PROGRAMMING
## Learning Management System (LMS) CeLOE - Telkom University

---

## 👨‍🎓 IDENTITAS MAHASISWA

| Data | Keterangan |
|------|------------|
| **Nama** | DANDY CANDRA PRATAMA |
| **NIM** | 7708170114 |
| **Kelas** | KELAS B 22 |
| **Program Studi** | D4 Teknologi Rekayasa Multimedia |
| **Fakultas** | Fakultas Informatika dan Teknik (FIT) |
| **Mata Kuliah** | MOBILE PROGRAMMING |
| **Dosen** | ROFI UDDIN |
| **Semester** | Genap 2020/2021 |

---

## 📋 DESKRIPSI TUGAS

Membuat aplikasi **UI/UX Mobile App** dengan tema **"Learning Management System"** berbasis Flutter untuk mahasiswa Telkom University. Aplikasi ini menggunakan **skema warna hijau** yang konsisten dengan identitas visual Telkom University (menggantikan warna merah pada desain awal di Figma).

---

## 🎯 TUJUAN PEMBELAJARAN

1. ✅ Memahami dan mengimplementasikan prinsip UI/UX Design
2. ✅ Menerapkan design system yang konsisten
3. ✅ Menggunakan Flutter untuk mobile app development
4. ✅ Implementasi Material Design 3
5. ✅ Menggunakan state management dan navigation
6. ✅ Menerapkan responsive design

---

## 🎨 DESAIN APLIKASI

### Skema Warna (Telkom University Branding)

Aplikasi ini menggunakan **warna hijau Telkom University** sebagai warna primer, sesuai dengan permintaan untuk mengganti dari warna merah:

| Nama | Kode Warna | Penggunaan |
|------|------------|------------|
| **Primary Green** | `#009247` | Warna utama, AppBar, Button, Icon aktif |
| **Primary Dark** | `#006B33` | Gradient, Shadow |
| **Primary Light** | `#33A669` | Hover states, Highlight |
| **Accent Gold** | `#FDB515` | Badge, Status, Secondary actions |
| **Background** | `#F5F7FA` | Background aplikasi |
| **Surface** | `#FFFFFF` | Card, Container |

### Typography

- **Font Family**: Inter (Google Fonts)
- **Heading**: Bold, 24-32px
- **Subheading**: Semi-bold, 18-20px
- **Body**: Regular, 14-16px
- **Caption**: Regular, 12px

### Design Principles

1. **Consistency** - Warna, spacing, dan komponen yang seragam
2. **Hierarchy** - Visual hierarchy yang jelas dengan typography
3. **Feedback** - Loading states, validations, dan animations
4. **Accessibility** - Kontras warna yang baik dan font yang readable
5. **Aesthetics** - Gradient, shadows, dan micro-animations

---

## ✨ FITUR APLIKASI

### 1. 🚀 Splash Screen
**Deskripsi**: Halaman pembuka aplikasi dengan animasi
- Animasi fade dan scale yang smooth
- Logo CeLOE dengan background gradient hijau
- Loading indicator
- Auto-redirect ke Login setelah 3 detik

**Teknologi**: 
- `AnimationController` untuk fade & scale animation
- `PageRouteBuilder` untuk smooth transition
- Custom gradient background

### 2. 🔐 Login Screen
**Deskripsi**: Halaman autentikasi user
- Form login dengan validasi email dan password
- Password visibility toggle
- Informasi bantuan login
- Loading state saat submit
- Error handling

**Fitur Teknis**:
- Form validation (email format, password minimum 6 karakter)
- `TextFormField` dengan custom decoration
- Responsive layout dengan `SingleChildScrollView`

### 3. 🏠 Home/Dashboard
**Deskripsi**: Halaman utama dengan overview
- Greeting dengan nama mahasiswa
- Statistik: Total kelas dan tugas aktif
- Daftar tugas yang akan datang (dengan deadline)
- Pengumuman terbaru dari admin CeLOE
- Progress kelas
- `SliverAppBar` dengan gradient header

**Komponen**:
- Stats Cards (Total Kelas, Tugas Aktif)
- Assignment Cards (dengan status due soon)
- Announcement Cards
- Course Progress Cards dengan progress bar

### 4. 📚 Kelas Saya (My Courses)
**Deskripsi**: Daftar semua mata kuliah
- List view of all enrolled courses
- Progress bar untuk setiap kelas (86% - 90%)
- Informasi: Nama kelas, kode, dosen, semester
- Jumlah mahasiswa per kelas
- Clickable cards untuk detail kelas

**Data Sample**:
- 7 Mata Kuliah Semester 2021/2
- UI/UX, Sistem Operasi, Mobile Programming, dll.

### 5. 👤 Profile Screen
**Deskripsi**: Profil dan pengaturan user
- Avatar dengan edit button
- Informasi lengkap mahasiswa:
  - Email: dandycandra@365.telkomuniversity.ac.id
  - Program Studi: D4 Teknologi Rekayasa Multimedia
  - Fakultas: FIT
- Statistik: Kelas aktif, Tugas selesai
- Menu pengaturan:
  - Edit Profile
  - Ganti Password
  - Notifikasi
  - Bantuan
- Tombol logout dengan konfirmasi dialog

### 6. 🧭 Navigation
**Deskripsi**: Bottom navigation bar
- 3 Menu utama: Home, Kelas Saya, Profile
- Icon yang jelas dengan label
- Active state indication
- Smooth transitions

---

## 🏗️ STRUKTUR PROYEK

```
lms_celoe_app/
│
├── lib/
│   ├── main.dart                      # Entry point aplikasi
│   │
│   ├── constants/
│   │   ├── app_colors.dart           # Color palette
│   │   └── app_theme.dart            # Theme configuration
│   │
│   ├── models/
│   │   ├── course.dart               # Course data model
│   │   ├── assignment.dart           # Assignment data model
│   │   └── announcement.dart         # Announcement data model
│   │
│   └── screens/
│       ├── splash_screen.dart        # Splash dengan animasi
│       ├── login_screen.dart         # Login page
│       ├── main_screen.dart          # Main dengan bottom nav
│       ├── home_screen.dart          # Dashboard
│       ├── courses_screen.dart       # List kelas
│       └── profile_screen.dart       # User profile
│
├── assets/
│   ├── images/                       # Image assets
│   └── icons/                        # Icon assets
│
├── pubspec.yaml                       # Dependencies
├── README.md                          # Project documentation
└── LAPORAN_UAS.md                    # Laporan ini
```

---

## 📦 DEPENDENCIES & PACKAGES

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8      # iOS style icons
  google_fonts: ^6.2.1         # Custom fonts (Inter)
  intl: ^0.19.0                # Date formatting

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0        # Linting rules
```

**Penjelasan**:
- `google_fonts`: Untuk typography menggunakan font Inter
- `intl`: Untuk format tanggal pada assignment deadlines

---

## 🚀 CARA MENJALANKAN APLIKASI

### Prasyarat
- Flutter SDK 3.0.0 atau lebih baru
- Chrome / Edge browser (untuk web)
- Android Studio / VS Code
- Git (optional)

### Langkah-langkah

#### 1️⃣ **Install Dependencies**
```bash
cd lms_celoe_app
flutter pub get
```

#### 2️⃣ **Run di Web (Chrome)**
```bash
flutter run -d chrome
```

#### 3️⃣ **Run di Android Emulator**
```bash
# Pastikan emulator sudah running
flutter run -d emulator
```

#### 4️⃣ **Build APK untuk Testing**
```bash
flutter build apk --release
```
APK akan tersedia di: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🎨 IMPLEMENTASI UI/UX PRINCIPLES

### 1. **Prinsip Desain yang Diterapkan**

#### ✅ **Consistency (Konsistensi)**
- Warna hijau Telkom konsisten di seluruh aplikasi
- Typography menggunakan font Inter
- Spacing dan padding yang seragam (8, 12, 16, 20, 24px)
- Border radius konsisten (12-16px)

#### ✅ **Visual Hierarchy**
- Ukuran font yang jelas: Display > Heading > Body > Caption
- Warna primer untuk elemen penting
- Shadow untuk depth dan elevation

#### ✅ **Feedback**
- Loading indicators pada login
- Form validation dengan error messages
- Button states (normal, pressed, disabled)
- Smooth animations dan transitions

#### ✅ **Accessibility**
- Kontras warna yang baik (WCAG AA compliant)
- Font size yang readable (minimum 12px)
- Touch target size minimal 44x44px
- Clear labels untuk semua interactive elements

### 2. **20 Prinsip UI Design yang Diimplementasikan**

Berikut prinsip-prinsip dari materi kuliah yang telah diterapkan:

1. ✅ **Clarity** - Interface yang jelas dan mudah dipahami
2. ✅ **Consistency** - Konsistensi warna, font, dan spacing
3. ✅ **Hierarchy** - Visual hierarchy dengan size dan color
4. ✅ **Alignment** - Proper alignment untuk semua elements
5. ✅ **Proximity** - Grouping related elements
6. ✅ **Contrast** - Good contrast untuk readability
7. ✅ **Repetition** - Consistent patterns
8. ✅ **White Space** - Proper spacing dan breathing room
9. ✅ **Feedback** - Visual feedback untuk user actions
10. ✅ **Affordance** - Elements terlihat clickable
11. ✅ **Visibility** - Important info visible
12. ✅ **Flexibility** - Responsive design
13. ✅ **Efficiency** - Quick access to common tasks
14. ✅ **Learnability** - Easy to learn
15. ✅ **Memorability** - Consistent patterns
16. ✅ **Error Prevention** - Input validation
17. ✅ **Error Recovery** - Clear error messages
18. ✅ **User Control** - User can navigate freely
19. ✅ **Aesthetic** - Beautiful design dengan gradients
20. ✅ **Performance** - Smooth animations

---

## 📊 DATA MODEL

### Course Model
```dart
class Course {
  final String id;
  final String name;
  final String code;
  final String instructor;
  final String semester;
  final int progress;
  final int totalStudents;
}
```

### Assignment Model
```dart
class Assignment {
  final String id;
  final String title;
  final String courseCode;
  final DateTime deadline;
  final bool isSubmitted;
  final String? fileName;
}
```

### Announcement Model
```dart
class Announcement {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime date;
}
```

---

## 🎯 PENGUJIAN APLIKASI

### ✅ Checklist Testing

| Fitur | Status | Keterangan |
|-------|--------|------------|
| Splash Screen Animation | ✅ | Animasi smooth, auto-redirect |
| Login Form Validation | ✅ | Email & password validation working |
| Home Dashboard | ✅ | Semua cards tampil dengan benar |
| Course List | ✅ | 7 kelas tampil dengan progress |
| Profile Screen | ✅ | Info user lengkap |
| Bottom Navigation | ✅ | Navigation smooth antar screen |
| Logout Functionality | ✅ | Confirmation dialog works |
| Responsive Layout | ✅ | Adapt ke berbagai screen size |
| Color Theme | ✅ | Hijau Telkom konsisten |
| Typography | ✅ | Inter font loaded correctly |

### Browser Compatibility
- ✅ Chrome (Tested)
- ✅ Edge (Compatible)
- ✅ Firefox (Compatible)
- ✅ Safari (Compatible)

---

## 💡 KESULITAN & SOLUSI

### 1. **Issue: Compilation Error pada Theme**
**Problem**: `CardTheme` deprecated di Flutter 3.24+
**Solution**: Menggunakan `CardThemeData` dengan const constructor

### 2. **Issue: Icon tidak ditemukan**
**Problem**: `Icons.notifications_outline` tidak exist
**Solution**: Mengubah ke `Icons.notifications_outlined`

### 3. **Issue: IntlDateFormat locale**
**Problem**: Locale 'id_ID' belum di-initialize
**Solution**: Menggunakan default locale tanpa specify 'id_ID'

---

## 🌟 KEUNGGULAN APLIKASI

### 1. **Design Premium**
- Menggunakan warna hijau Telkom University yang profesional
- Gradient yang smooth dan modern
- Shadow dan elevation yang subtle
- Micro-animations untuk better UX

### 2. **User Experience**
- Navigasi intuitif dengan bottom navigation
- Loading states yang jelas
- Form validation yang helpful
- Smooth transitions antar screens

### 3. **Code Quality**
- Clean architecture dengan separation of concerns
- Reusable widgets
- Proper naming conventions
- Comments yang jelas

### 4. **Performance**
- Smooth 60fps animations
- Efficient rendering dengan const constructors
- Optimized build methods

---

## 📚 REFERENSI

1. **Flutter Documentation**: https://flutter.dev/docs
2. **Material Design 3**: https://m3.material.io
3. **Google Fonts**: https://fonts.google.com
4. **Telkom University Branding**: Official color palette
5. **UI/UX Course Materials**: Materi kuliah Desain Antarmuka & Pengalaman Pengguna

---

## 🎓 KESIMPULAN

Aplikasi **LMS CeLOE** ini berhasil mengimplementasikan prinsip-prinsip UI/UX Design yang telah dipelajari dalam mata kuliah. Aplikasi ini menampilkan:

1. ✅ **Konsistensi** dalam penggunaan warna hijau Telkom University
2. ✅ **Visual Hierarchy** yang jelas dengan typography dan spacing
3. ✅ **User Experience** yang baik dengan navigasi intuitif
4. ✅ **Design System** yang terstruktur dan reusable
5. ✅ **Modern UI** dengan Material Design 3
6. ✅ **Clean Code** dengan proper architecture

Aplikasi ini siap untuk:
- Development lebih lanjut dengan integrasi backend API
- Deployment ke production
- Penambahan fitur-fitur baru sesuai kebutuhan

---

## 📞 KONTAK

**Nama**: DANDY CANDRA PRATAMA  
**NIM**: 7708170114  
**Email**: dandycandra@365.telkomuniversity.ac.id  
**Program Studi**: D4 Teknologi Rekayasa Multimedia  
**Fakultas**: FIT - Telkom University  

---

**Tanggal Pengumpulan**: 31 Desember 2025, 23:59 WIB  
**Status**: ✅ SELESAI - SIAP SUBMIT

---

_© 2021 CeLOE - Telkom University_  
_Learning Management System Mobile Application_
