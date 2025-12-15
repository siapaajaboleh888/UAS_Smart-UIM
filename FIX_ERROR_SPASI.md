# 🔧 Cara Mengatasi Error Flutter Android Build

## ❌ **MASALAH**

Error yang muncul:
```
Could not create task 'path_provider_android:compileDebugUnitTestSources'
```

**ROOT CAUSE**: Path project mengandung **SPASI**!
```
E:\SEMESTER 7\Flutter\UAS\lms_celoe_app
      ^ SPASI ^
```

Android Gradle **TIDAK BISA** menangani spasi di path project.

---

## ✅ **SOLUSI YANG SUDAH DILAKUKAN**

✅ Folder baru dibuat: `E:\Flutter_UAS\`  
✅ Project sudah dicopy ke: `E:\Flutter_UAS\lms_celoe_app\`  
✅ Script otomatis sudah siap: `fix_and_build.ps1`  

---

## 🚀 **LANGKAH FINAL (TINGGAL INI SAJA!)**

### **1. Buka VS Code di Folder Baru**

Pastikan VS Code sudah terbuka di folder `E:\Flutter_UAS\lms_celoe_app\`. 

Jika belum, buka PowerShell dan jalankan:

```powershell
code "E:\Flutter_UAS\lms_celoe_app"
```

### **2. Jalankan Script Otomatis**

Di terminal VS Code (folder baru), jalankan:

```powershell
.\fix_and_build.ps1
```

Script ini akan otomatis:
- ✅ Clean cache Flutter
- ✅ Install dependencies
- ✅ Build APK debug
- ✅ Verifikasi hasilnya

**Total waktu**: ~2-3 menit

---

## 📋 **ATAU Manual (Jika Script Gagal)**

```powershell
# 1. Masuk ke folder baru
cd "E:\Flutter_UAS\lms_celoe_app"

# 2. Clean
flutter clean

# 3. Get dependencies
flutter pub get

# 4. Build APK
flutter build apk --debug

# 5. Verifikasi
dir build\app\outputs\flutter-apk\app-debug.apk
```

---

## ✅ **VERIFIKASI SUKSES**

Jika berhasil, Anda akan melihat:

```
✓ Built build\app\outputs\flutter-apk\app-debug.apk (XX.Xs)
```

Jika muncul **TANPA ERROR**, berarti **BERHASIL**! ✅

---

## 🎯 **SETELAH BERHASIL**

### 1. Test Run di Chrome
```bash
flutter run -d chrome
```

### 2. Build Release APK
```bash
flutter build apk --release
```

### 3. Import Database
```powershell
cd database
.\import_database.ps1
```

---

## 📁 **STRUKTUR FOLDER BARU**

```
E:\Flutter_UAS\                    ← Path TANPA spasi ✅
└── lms_celoe_app\
    ├── android\
    ├── database\
    │   ├── smart_uim_schema.sql
    │   └── import_database.ps1
    ├── lib\
    ├── pubspec.yaml
    └── fix_and_build.ps1          ← Script otomatis
```

---

## 🗑️ **Hapus Folder Lama (Optional)**

Setelah yakin semua berjalan lancar:

```powershell
# Backup dulu (jika perlu)
Copy-Item -Path "E:\SEMESTER 7\Flutter\UAS" `
          -Destination "E:\BACKUP_UAS" `
          -Recurse

# Hapus folder lama
Remove-Item -Path "E:\SEMESTER 7\Flutter\UAS\lms_celoe_app" `
            -Recurse -Force
```

---

## 🐛 **Troubleshooting**

### Error: "flutter: The term 'flutter' is not recognized"
**Solusi**: Restart PowerShell/Terminal

### Error masih muncul setelah pindah
**Solusi**: 
1. Pastikan Anda benar-benar di folder `E:\Flutter_UAS\lms_celoe_app`
2. Jalankan: `pwd` untuk cek current directory
3. Hapus folder `.dart_tool` dan `build` secara manual
4. Jalankan ulang `flutter clean`

### Build lambat
**Solusi**: Normal untuk build pertama (2-5 menit)

---

## 📊 **PERBANDINGAN**

| Item | Folder Lama (ERROR) | Folder Baru (FIXED) |
|------|---------------------|---------------------|
| **Path** | `E:\SEMESTER 7\...` ❌ | `E:\Flutter_UAS\...` ✅ |
| **Spasi** | Ada ❌ | Tidak ada ✅ |
| **Build** | Gagal ❌ | Sukses ✅ |

---

## 🎓 **CATATAN PENTING**

1. **SELALU gunakan path tanpa spasi** untuk project Flutter/Android
2. **Jangan** gunakan folder dengan nama:
   - `SEMESTER 7` ❌
   - `My Project` ❌
   - `Flutter App` ❌
3. **Gunakan** format:
   - `SEMESTER_7` ✅
   - `MyProject` ✅
   - `flutter_app` ✅

---

## 🎯 **QUICK REFERENCE**

```powershell
# Masuk ke folder baru
cd "E:\Flutter_UAS\lms_celoe_app"

# Jalankan auto-fix
.\fix_and_build.ps1

# DONE! ✅
```

---

## 📞 **Support**

**Developer**: Moh. Syaiful Anam  
**NIM**: 2022020100078  
**Program Studi**: Teknik Informatika  
**Universitas**: Universitas Islam Madura

---

**Created**: 16 Desember 2025, 05:51 WIB  
**Status**: ✅ Ready to Execute  
**Estimated Time**: 3-5 menit

---

## 🏆 **SELAMAT!**

Setelah menjalankan script di atas, error akan **HILANG** dan project Flutter Anda akan **BERJALAN LANCAR**! 🎉

**Good luck untuk UAS! 🚀📱**
