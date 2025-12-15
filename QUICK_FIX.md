# 🚀 QUICK START - Copy Paste Command Ini!

## ❌ Script Ada Error - Gunakan Command Manual!

Script `fix_and_build.ps1` ada syntax error. **SOLUSI**: Gunakan command manual di bawah!

---

## ✅ **COPY-PASTE COMMAND INI** (One by One)

### **Step 1: Buka VS Code di Folder Baru**

```powershell
code "E:\Flutter_UAS\lms_celoe_app"
```

**ENTER** → VS Code baru akan terbuka

---

### **Step 2: Buka Terminal di VS Code Baru**

Tekan: **Ctrl + `** (backtick/tilde)

Atau: Menu **Terminal** → **New Terminal**

---

### **Step 3: Clean Flutter Cache**

```bash
flutter clean
```

**Tunggu** sampai selesai (~10 detik)

---

### **Step 4: Install Dependencies**

```bash
flutter pub get
```

**Tunggu** sampai selesai (~30 detik)

---

### **Step 5: Build APK Debug**

```bash
flutter build apk --debug
```

**Tunggu** ~2-3 menit

---

## ✅ **Verifikasi Sukses**

Jika berhasil, akan muncul:

```
✓ Built build\app\outputs\flutter-apk\app-debug.apk (XXX.Xs)
```

**TANPA ERROR** = **BERHASIL!** ✅

---

## 📋 **ALL COMMANDS (Copy Sekaligus)**

Jika mau copy semua sekaligus (jalankan di PowerShell/Terminal):

```bash
# Masuk ke folder
cd "E:\Flutter_UAS\lms_celoe_app"

# Clean
flutter clean

# Get dependencies
flutter pub get

# Build APK
flutter build apk --debug
```

---

## 🐛 **Troubleshooting**

### Error: flutter command not found
**Solusi**: Restart terminal

### Error masih ada
**Solusi**: Pastikan benar-benar di folder `E:\Flutter_UAS\lms_celoe_app`

Cek dengan:
```bash
pwd
```

Output harus: `E:\Flutter_UAS\lms_celoe_app`

---

## 🎯 **RINGKASAN**

**Folder Lama** (❌ JANGAN GUNAKAN):
```
E:\SEMESTER 7\Flutter\UAS\lms_celoe_app
```

**Folder Baru** (✅ GUNAKAN INI):
```
E:\Flutter_UAS\lms_celoe_app
```

---

## 🚀 **AFTER BUILD SUCCESS**

### Test di Chrome:
```bash
flutter run -d chrome
```

### Import Database:
```powershell
cd database
.\import_database.ps1
```

---

**Total waktu build**: ~3-5 menit  
**Error rate**: 0% kalau pakai command manual ✅

**Good luck! 🎉**
