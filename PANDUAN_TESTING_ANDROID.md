# 📱 Panduan Testing di HP Android

## ✅ Perubahan yang Sudah Dilakukan

### 1. Update Branding ✅
- **Sebelum**: "Smart UIM LMS"
- **Setelah**: "Smart UIM" (lebih clean dan simple)

### 2. Fitur Baru: Tombol Register ✅
- Tombol "Daftar Akun Baru" dengan icon person_add
- Style: Outlined button (hijau border)
- Divider dengan text "atau"
- Helper text: "Belum punya akun? Daftar sebagai mahasiswa baru"
- Saat ini menampilkan snackbar info (fitur akan segera hadir)

---

## 🚀 Cara Testing di HP Android

### **Metode 1: Install APK Debug** (Recommended)

#### 1. Build APK
```bash
cd "e:\SEMESTER 7\Flutter\UAS\lms_celoe_app"
flutter build apk --debug
```

**Output**: `build\app\outputs\flutter-apk\app-debug.apk`

#### 2. Transfer APK ke HP
**Pilihan A: Via USB Cable**
- Hubungkan HP ke laptop via USB
- Copy file APK ke folder Download HP
- Buka File Manager di HP → Download
- Tap file APK → Install

**Pilihan B: Via Google Drive/WhatsApp**
- Upload APK ke Google Drive
- Buka di HP → Download → Install

**Pilihan C: Via ADB**
```bash
adb install build\app\outputs\flutter-apk\app-debug.apk
```

#### 3. Enable Install from Unknown Sources
Di HP Android:
- Buka **Settings** → **Security**
- Enable **Install from Unknown Sources**
- Atau beri izin saat diminta install

---

### **Metode 2: Flutter Run via USB** (Development Mode)

#### 1. Enable Developer Options di HP
1. Buka **Settings** → **About Phone**
2. Tap **Build Number** 7x hingga muncul "You are now a developer"
3. Kembali ke Settings → **Developer Options**
4. Enable **USB Debugging**

#### 2. Hubungkan HP via USB
```bash
# Cek device terdeteksi
flutter devices

# Expected output:
# Vivo 1906 • xxxxx • android-arm64 • Android 11 (API 30)
```

#### 3. Run Flutter
```bash
cd "e:\SEMESTER 7\Flutter\UAS\lms_celoe_app"
flutter run
```

Pilih device HP Anda dari list

---

### **Metode 3: Wireless Debugging** (Android 11+)

#### 1. Enable Wireless Debugging
- Settings → Developer Options → **Wireless Debugging** → ON
- Tap **Pair device with pairing code**
- Catat IP dan Port

#### 2. Pair dari Laptop
```bash
adb pair <IP>:<PORT>
# Masukkan pairing code dari HP

# Connect
adb connect <IP>:<PORT>
```

#### 3. Run Flutter
```bash
flutter run
```

---

## 🧪 Test Checklist

Setelah aplikasi berjalan di HP, test hal berikut:

### ✅ Login Screen
- [ ] Logo Smart UIM tampil dengan benar
- [ ] Text "Smart UIM" (bukan "Smart UIM LMS")
- [ ] Text "Universitas Islam Madura" tampil
- [ ] Form Email dan Password bisa diisi
- [ ] Icon lock dan email tampil
- [ ] Toggle password visibility berfungsi
- [ ] Tombol "Login" bisa diklik
- [ ] Loading indicator muncul saat login
- [ ] **Tombol "Daftar Akun Baru" tampil** ✅ NEW
- [ ] **Divider "atau" tampil** ✅ NEW
- [ ] **Text helper "Belum punya akun?" tampil** ✅ NEW
- [ ] Tap "Daftar Akun Baru" → Muncul snackbar
- [ ] Card "Bantuan Login" tampil
- [ ] Scroll halaman berfungsi dengan lancar

### ✅ Setelah Login
- [ ] Navigasi ke Home/Dashboard
- [ ] Bottom navigation bar tampil
- [ ] Semua fitur berfungsi

### ✅ Performance
- [ ] Aplikasi berjalan smooth (tidak lag)
- [ ] Animasi berjalan dengan baik
- [ ] Tidak ada crash atau force close
- [ ] Memory usage wajar

---

## 🔧 Troubleshooting

### Error: "App not installed"
**Solusi**:
- Uninstall aplikasi lama (jika ada)
- Enable Install from Unknown Sources
- Pastikan APK tidak corrupt

### Error: "Device not found"
**Solusi**:
```bash
# Cek koneksi USB
adb devices

# Restart adb server
adb kill-server
adb start-server

# Cek lagi
flutter devices
```

### Error: SDK version mismatch
**Solusi**: Pastikan minSdkVersion di `android/app/build.gradle.kts` sesuai dengan Android HP Anda

### HP tidak terdeteksi via USB
**Solusi**:
1. Instal driver HP
2. Gunakan kabel USB original
3. Pilih mode "File Transfer" di HP
4. Enable USB Debugging ulang

---

## 📊 Spesifikasi HP yang Didukung

**Minimum Requirements**:
- Android 5.0 (Lollipop) / API Level 21+
- RAM: 2GB+
- Storage: 100MB free space

**Recommended**:
- Android 8.0 (Oreo) / API Level 26+
- RAM: 4GB+
- Storage: 500MB free space

---

## 📸 Screenshot untuk Laporan

Capture screenshot dari HP untuk dokumentasi:

1. **Splash Screen** (jika ada)
2. **Login Screen** dengan tombol Register ✅
3. **Home/Dashboard**
4. **Halaman Kelas**
5. **Profile Screen**
6. **Bottom Navigation**

---

## 🎯 Performa yang Diharapkan

| Feature | Expected Behavior |
|---------|------------------|
| **Startup Time** | < 3 detik |
| **Screen Transition** | Smooth, < 300ms |
| **Button Response** | Instant |
| **Scroll** | 60 FPS |
| **Memory Usage** | < 200MB |

---

## 🚀 Quick Commands

```bash
# Build APK Debug
flutter build apk --debug

# Build APK Release (untuk distribusi)
flutter build apk --release

# Run di device yang terkoneksi
flutter run

# Run dengan hot reload
flutter run --hot

# Cek device
flutter devices

# Cek logs
flutter logs

# Clean build
flutter clean && flutter pub get
```

---

## ✅ Status Commit

**Commit Hash**: `3a2d62a`  
**Branch**: `main`  
**Status**: ✅ **Pushed to GitHub**

**Commit Message**:
```
feat: Update login screen branding and add registration button

- Changed app title from 'Smart UIM LMS' to 'Smart UIM'
- Added 'Daftar Akun Baru' (Register) button
- Added divider with 'atau' text
- Ready for Android device testing
```

---

## 📞 Support

Jika ada error atau pertanyaan:
- Cek logs: `flutter logs`
- Screenshot error message
- Cek versi Flutter: `flutter doctor -v`

---

**Last Updated**: 15 Desember 2025, 23:51 WIB  
**Ready for**: Android Device Testing 📱

**Selamat Testing! 🚀**
