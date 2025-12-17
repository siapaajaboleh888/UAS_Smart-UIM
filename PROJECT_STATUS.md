# ✅ PROJECT SUDAH SIAP! 

## 🎉 Yang Sudah Dikerjakan:

### 1. ✅ Script PowerShell untuk Run di Laptop & HP
- **`run_web.ps1`** → Untuk menjalankan di Chrome (Laptop)
- **`run_android.ps1`** → Untuk menjalankan di HP Android
- **Auto-fix** untuk masalah "device offline"

### 2. ✅ Dokumentasi Lengkap
- **`QUICK_RUN.md`** → Panduan cepat
- **`CARA_MENJALANKAN_LENGKAP.md`** → Panduan detail dengan troubleshooting

### 3. ✅ Push ke GitHub
- Repository: https://github.com/siapaajaboleh888/UAS_Smart-UIM
- Semua file terbaru sudah di-push
- Commit terakhir: "Update: Tambah QUICK_RUN.md dan perbaiki run_web.ps1"

---

## 🚀 CARA MENJALANKAN SEKARANG:

### 💻 **Di Laptop (Web/Chrome)**:
```powershell
.\run_web.ps1
```

**ATAU manual:**
```powershell
flutter run -d chrome
```

**INGAT**: Yang benar adalah `flutter run -d chrome` (TANPA spasi antara - dan d)  
❌ SALAH: `flutter run - d chrome`  
✅ BENAR: `flutter run -d chrome`

---

### 📱 **Di HP Android**:

#### Persiapan (Sekali Saja):
1. **Aktifkan Developer Options**:
   - Settings → About Phone
   - Tap "Build Number" 7 kali

2. **Aktifkan USB Debugging**:
   - Settings → Developer Options
   - Nyalakan "USB Debugging"

3. **Sambungkan HP ke Laptop**:
   - Gunakan kabel USB
   - Pilih mode "File Transfer"
   - Izinkan USB Debugging saat popup

#### Jalankan:
```powershell
.\run_android.ps1
```

Script ini akan otomatis:
- ✅ Cek device yang tersedia
- ✅ Restart ADB jika device offline
- ✅ Install dan jalankan app di HP

**ATAU manual (jika device offline):**
```powershell
adb kill-server
adb start-server
flutter run
```

---

## 🔧 FIX ERROR "device offline"

Script `run_android.ps1` sudah otomatis menangani error ini!

Jika masih error, coba:
1. Cabut dan pasang ulang kabel USB
2. Matikan dan nyalakan ulang USB Debugging
3. Ganti kabel USB (gunakan yang original)
4. Coba port USB lain di laptop

---

## 📦 Membuat APK (Install Tanpa Kabel)

Jika ingin install di HP tanpa kabel:

```powershell
flutter build apk --release
```

APK akan tersimpan di:
```
build\app\outputs\flutter-apk\app-release.apk
```

Transfer file ini ke HP via WhatsApp/Drive, lalu install.

---

## 📊 Status Repository GitHub

✅ **Repository**: https://github.com/siapaajaboleh888/UAS_Smart-UIM  
✅ **Branch**: main  
✅ **Status**: Up to date  
✅ **Devices yang Didukung**: 
   - Chrome (Web)
   - Windows (Desktop)
   - Android (Mobile)
   - Edge (Web)

---

## 🎯 Devices yang Terdeteksi

Dari `flutter devices`, project ini bisa dijalankan di:
- **Windows (desktop)** → `flutter run -d windows`
- **Chrome (web)** → `flutter run -d chrome`
- **Edge (web)** → `flutter run -d edge`
- **Android (mobile)** → `flutter run` (auto-detect) atau `.\run_android.ps1`

---

## 📝 Informasi HP Anda

Device: **V2030** (Vivo V2030)

Jika masih ada masalah dengan HP:
1. Install driver USB Vivo dari: https://www.vivo.com/en/support/drivers
2. Pastikan kabel USB dalam kondisi baik
3. Pastikan mode USB adalah "File Transfer" bukan "Charging Only"

---

## ✨ NEXT STEPS

Untuk menjalankan sekarang:

1. **Di Laptop**: Buka PowerShell di folder ini, ketik `.\run_web.ps1`
2. **Di HP**: Sambungkan HP, lalu ketik `.\run_android.ps1`

---

**Project**: Smart UIM - LMS Universitas Islam Madura  
**Developer**: Moh. Syaiful Anam (2022020100078)  
**Teknik Informatika**  
**Universitas Islam Madura**

---

## 🔗 Links

- **GitHub**: https://github.com/siapaajaboleh888/UAS_Smart-UIM
- **Commits**: https://github.com/siapaajaboleh888/UAS_Smart-UIM/commits/main

---

**STATUS**: ✅ READY TO RUN! 🚀
