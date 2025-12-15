# 🚀 Quick Start Guide - Smart UIM

Panduan cepat untuk menjalankan aplikasi Smart UIM

---

## ⚡ Quick Run

### 1. Install Dependencies
```powershell
flutter pub get
```

### 2. Run Aplikasi

**Chrome (Web) - RECOMMENDED:**
```powershell
flutter run -d chrome
```

**Android Emulator:**
```powershell
flutter run
```

**Build APK:**
```powershell
flutter build apk --release
```

---

## 🔑 Login Credentials

Gunakan salah satu akun berikut untuk login:

| Role | Email | Password |
|------|-------|----------|
| **Mahasiswa** | `syaiful@student.uim.ac.id` | `password` |
| **Dosen** | `dosen1@uim.ac.id` | `password` |
| **Admin** | `admin@uim.ac.id` | `password` |

---

## 📊 Flow Aplikasi

1. **Splash Screen** (3 detik)
   - Logo Smart UIM
   - Auto redirect ke login

2. **Login Screen**
   - Masukkan email dan password
   - Klik "Login"

3. **Home Dashboard**
   - Lihat statistik kelas & tugas
   - Daftar tugas upcoming
   - Pengumuman terbaru

4. **Kelas Saya**
   - 7 mata kuliah dengan progress
   - Detail kelas lengkap

5. **Profile**
   - Info mahasiswa
   - Settings
   - Logout

---

## 🎨 Fitur Utama

- ✅ Splash Screen dengan animasi
- ✅ Login dengan validasi
- ✅ Dashboard interaktif
- ✅ 7 Mata kuliah dengan progress
- ✅ Profile mahasiswa lengkap
- ✅ Bottom navigation smooth
- ✅ Tema hijau UIM
- ✅ Material Design 3

---

## 🗄️ Database (Optional)

Jika ingin menggunakan database MySQL:

```powershell
cd database
.\import_database.ps1
```

Pilih:
- **[1]** Full Schema (Lengkap dengan sample data)
- **[2]** Quick Setup (Minimal untuk testing)

---

## 🐛 Troubleshooting

### Error: "Lost connection to device"
- **Solusi**: Ini normal, aplikasi tetap berjalan. Refresh Chrome atau restart device.

### Error: "Gradle build failed"
- **Solusi**: Jalankan `flutter clean` lalu `flutter pub get`

### Error: "No device found"
- **Solusi**: Pastikan Chrome installed atau Android emulator running
- Check dengan: `flutter devices`

---

## 📱 Tested On

- ✅ Windows 11
- ✅ Flutter 3.35.3
- ✅ Chrome Browser
- ✅ Android Emulator

---

## 📞 Need Help?

**Developer**: Moh. Syaiful Anam  
**NIM**: 2022020100078  
**Email**: syaifulanam@uim.ac.id

---

## 🔗 Useful Links

- GitHub: https://github.com/siapaajaboleh888/UAS_Smart-UIM.git
- Documentation: README.md
- Database Guide: database/PANDUAN_DATABASE.md
- Testing Checklist: TESTING_CHECKLIST.md

---

**© 2025 Smart UIM - Universitas Islam Madura**
