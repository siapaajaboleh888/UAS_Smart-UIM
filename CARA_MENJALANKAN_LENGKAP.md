# Panduan Lengkap Menjalankan Smart UIM

## 📱 Menjalankan di Laptop (Web - Chrome)

### Cara 1: Menggunakan Script PowerShell (MUDAH)
```powershell
.\run_web.ps1
```

### Cara 2: Manual
```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

**PENTING**: Perintah yang benar adalah `flutter run -d chrome` (TANPA spasi antara - dan d)

---

## 📱 Menjalankan di HP Android

### Persiapan:
1. **Aktifkan Developer Options di HP**:
   - Buka Settings → About Phone
   - Tap "Build Number" 7 kali
   - Developer Options akan muncul

2. **Aktifkan USB Debugging**:
   - Buka Settings → Developer Options
   - Nyalakan "USB Debugging"

3. **Sambungkan HP ke Laptop**:
   - Gunakan kabel USB
   - Pastikan mode transfer file (MTP/File Transfer)
   - Izinkan USB Debugging saat popup muncul di HP

### Cara 1: Menggunakan Script PowerShell (MUDAH)
```powershell
.\run_android.ps1
```

Script ini akan otomatis:
- Memeriksa device yang tersedia
- Membersihkan cache
- Restart ADB server jika device offline
- Menjalankan aplikasi

### Cara 2: Manual

#### Jika Device Offline:
```powershell
# Matikan ADB server
adb kill-server

# Tunggu 2 detik, lalu start lagi
adb start-server

# Cek status device
adb devices
```

#### Menjalankan Aplikasi:
```powershell
flutter clean
flutter pub get
flutter run
```

---

## 🔧 Troubleshooting

### Problem: "adb.exe: device offline"
**Solusi 1**: Restart ADB
```powershell
adb kill-server
adb start-server
adb devices
```

**Solusi 2**: Cabut dan pasang ulang kabel USB

**Solusi 3**: Matikan dan nyalakan ulang USB Debugging di HP

**Solusi 4**: Restart HP dan Laptop

### Problem: "Target file "-" not found"
Anda mengetik `flutter run - d chrome` (ada spasi sebelum -d)
Yang benar: `flutter run -d chrome` (tanpa spasi)

### Problem: Device tidak terdeteksi
```powershell
# Cek apakah ADB mendeteksi device
adb devices

# Jika kosong, coba:
# 1. Pastikan USB Debugging aktif
# 2. Ganti kabel USB
# 3. Coba port USB lain di laptop
# 4. Install driver USB untuk HP Anda (jika Windows)
```

---

## 🚀 Menjalankan di Kedua Platform Sekaligus

Anda TIDAK bisa menjalankan di web dan Android secara bersamaan dalam satu terminal.
Tapi Anda bisa:

1. **Buka 2 Terminal PowerShell berbeda**
2. Terminal 1: `flutter run -d chrome`
3. Terminal 2: `flutter run -d android` (atau biarkan auto-detect)

---

## 📦 Membuat APK untuk Instalasi di HP

Jika Anda ingin install tanpa kabel:

```powershell
# Build APK
flutter build apk --release

# APK akan tersimpan di:
# build\app\outputs\flutter-apk\app-release.apk
```

Transfer file APK ini ke HP Anda via:
- WhatsApp
- Google Drive
- Bluetooth
- Cloud Storage

Lalu install di HP.

---

## ✅ Checklist Sebelum Run

- [ ] Flutter SDK sudah terinstall
- [ ] `flutter doctor` tidak ada error critical
- [ ] Untuk Web: Chrome browser terinstall
- [ ] Untuk Android: USB Debugging aktif
- [ ] Untuk Android: HP tersambung dengan kabel USB
- [ ] Dependencies sudah di-download (`flutter pub get`)

---

## 📞 Informasi Device Anda

Dari error log, device Anda adalah: **V2030** (kemungkinan Vivo V2030)

Jika masih ada masalah, coba:
1. Install driver USB untuk Vivo: [Download dari website Vivo](https://www.vivo.com/en/support/drivers)
2. Gunakan kabel USB original
3. Pastikan mode USB adalah "File Transfer" bukan "Charging Only"
