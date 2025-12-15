# 📱 PANDUAN TESTING APLIKASI DI ANDROID DEVICE

## Langkah 1: Persiapan HP Android

### Enable USB Debugging:
1. Settings → About Phone
2. Tap "Build Number" 7x
3. Settings → Developer Options
4. Enable "USB Debugging"

### Connect ke Laptop:
1. Colokkan USB cable
2. Pilih "File Transfer" mode
3. Allow USB Debugging

---

## Langkah 2: Check Device

```powershell
cd "e:\SEMESTER 7\Flutter\UAS\lms_celoe_app"
flutter devices
```

Output yang diharapkan:
```
Found 2 devices:
  Android SDK built for x86 (mobile) • emulator-5554 • android-x86 • Android 11 (API 30)
  Chrome (web)                       • chrome        • web-javascript • Google Chrome
  [Your Device Name] (mobile)        • XXXXXX        • android-arm64  • Android XX
```

---

## Langkah 3: Run di Android

### Method 1: Auto-detect
```powershell
flutter run
# Flutter akan otomatis pilih device yang tersedia
```

### Method 2: Pilih device spesifik
```powershell
# List devices dulu
flutter devices

# Run di device tertentu
flutter run -d [device-id]
# Contoh: flutter run -d emulator-5554
```

---

## Langkah 4: Install APK Release

Untuk install permanent di HP:

```powershell
# Build APK release
flutter build apk --release

# Lokasi APK:
# e:\SEMESTER 7\Flutter\UAS\lms_celoe_app\build\app\outputs\flutter-apk\app-release.apk
```

Transfer APK ke HP dan install!

---

## 🔧 Troubleshooting

### Device tidak terdeteksi?
```powershell
# Restart ADB
flutter doctor
adb kill-server
adb start-server
adb devices
```

### Error saat build?
```powershell
# Clean project
flutter clean
flutter pub get
flutter run
```

### Aplikasi lag di debug mode?
```powershell
# Build release mode (lebih cepat)
flutter run --release
```

---

## ✅ Testing Checklist

- [ ] Splash screen muncul dengan animasi
- [ ] Login form berfungsi dengan validasi
- [ ] Home screen menampilkan data
- [ ] Bottom navigation berfungsi
- [ ] Courses screen menampilkan 7 mata kuliah
- [ ] Profile screen menampilkan info yang benar
- [ ] Logout berfungsi dengan konfirmasi

---

## 📝 Notes

- **Debug mode**: Slower tapi bisa hot reload
- **Release mode**: Faster, ukuran APK lebih kecil
- **Profile mode**: Untuk performance testing

---

**Good Luck Testing! 🚀**

_© 2025 Smart UIM - Universitas Islam Madura_
