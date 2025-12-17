# 🚀 Quick Run Guide - Smart UIM

## ⚡ Cara Tercepat Menjalankan Aplikasi

### 💻 Di Laptop (Web/Chrome)
```powershell
.\run_web.ps1
```

### 📱 Di HP Android
```powershell
.\run_android.ps1
```

---

## 📝 Penjelasan Singkat

### Untuk Web (Chrome):
1. Buka PowerShell di folder project ini
2. Jalankan: `.\run_web.ps1`
3. Tunggu Chrome otomatis terbuka
4. Aplikasi siap digunakan!

### Untuk Android (HP):
1. **Persiapan HP** (sekali saja):
   - Aktifkan Developer Options (tap Build Number 7x)
   - Nyalakan USB Debugging
   
2. **Sambungkan HP ke Laptop**:
   - Gunakan kabel USB
   - Pilih mode "File Transfer" di HP
   - Izinkan USB Debugging saat popup muncul

3. **Jalankan**:
   - Buka PowerShell di folder project ini
   - Jalankan: `.\run_android.ps1`
   - Tunggu aplikasi terinstall & terbuka di HP

---

## ❌ Fix Error "device offline"

Jika muncul error `adb.exe: device offline`:

**Solusi Otomatis** (script sudah menangani ini):
```powershell
.\run_android.ps1
```

**Solusi Manual**:
```powershell
adb kill-server
adb start-server
adb devices
flutter run
```

---

## 📦 Membuat APK untuk Install Tanpa Kabel

```powershell
flutter build apk --release
```

APK ada di: `build\app\outputs\flutter-apk\app-release.apk`

Transfer ke HP via WhatsApp/Drive, lalu install.

---

## 🔧 Troubleshooting

| Problem | Solusi |
|---------|--------|
| `flutter: command not found` | Install Flutter SDK |
| `chrome not found` | Install Google Chrome |
| `device offline` | Jalankan `.\run_android.ps1` (auto-fix) |
| `no devices found` | Cek kabel USB & USB Debugging |

---

## 📖 Panduan Lengkap

Untuk panduan detail, baca: [CARA_MENJALANKAN_LENGKAP.md](./CARA_MENJALANKAN_LENGKAP.md)

---

**Developed by**: Moh. Syaiful Anam (2022020100078)  
**Project**: Smart UIM - LMS Universitas Islam Madura  
**Repository**: [GitHub](https://github.com/siapaajaboleh888/UAS_Smart-UIM)
