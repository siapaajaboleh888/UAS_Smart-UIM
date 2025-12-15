# 🚚 Cara Memindahkan Project untuk Mengatasi Error Path dengan Spasi

## ❌ **PROBLEM**
Error Android build terjadi karena path project mengandung spasi:
```
E:\SEMESTER 7\Flutter\UAS\lms_celoe_app
      ^ SPASI ^
```

Android Gradle **TIDAK BISA** menangani spasi di path!

---

## ✅ **SOLUSI: Pindahkan ke Path Tanpa Spasi**

### Option 1: Pindah ke Root Drive (PALING MUDAH) ⭐

```powershell
# 1. Buat folder baru tanpa spasi
New-Item -Path "E:\Flutter_Projects\UAS" -ItemType Directory -Force

# 2. Copy seluruh project
Copy-Item -Path "E:\SEMESTER 7\Flutter\UAS\lms_celoe_app" -Destination "E:\Flutter_Projects\UAS\lms_celoe_app" -Recurse

# 3. Masuk ke folder baru
cd "E:\Flutter_Projects\UAS\lms_celoe_app"

# 4. Clean & rebuild
flutter clean
flutter pub get
flutter build apk --debug
```

### Option 2: Ganti Nama Folder (Lebih Aman)

```powershell
# Di folder E:\
# Ganti "SEMESTER 7" jadi "SEMESTER_7" atau "SEM7"

# 1. Copy dulu untuk backup
Copy-Item -Path "E:\SEMESTER 7" -Destination "E:\SEMESTER_7" -Recurse

# 2. Masuk ke folder baru
cd "E:\SEMESTER_7\Flutter\UAS\lms_celoe_app"

# 3. Clean & rebuild
flutter clean
flutter pub get
```

---

## 📋 **Step-by-Step Detail**

### LANGKAH 1: Backup Project (PENTING!)
```powershell
# Buat backup dulu
Copy-Item -Path "E:\SEMESTER 7\Flutter\UAS" -Destination "E:\BACKUP_UAS" -Recurse
```

### LANGKAH 2: Buat Folder Baru Tanpa Spasi
```powershell
New-Item -Path "E:\Flutter_UAS" -ItemType Directory -Force
```

### LANGKAH 3: Copy Project
```powershell
Copy-Item -Path "E:\SEMESTER 7\Flutter\UAS\lms_celoe_app" `
          -Destination "E:\Flutter_UAS\lms_celoe_app" `
          -Recurse
```

### LANGKAH 4: Clean Build
```powershell
cd "E:\Flutter_UAS\lms_celoe_app"

# Clean semua cache
flutter clean

# Get dependencies
flutter pub get

# Build APK
flutter build apk --debug
```

### LANGKAH 5: Verifikasi
```powershell
# Check apakah build berhasil
# Seharusnya ada output:
# ✓ Built build\app\outputs\flutter-apk\app-debug.apk
```

---

## 🔧 **Jika Tidak Ingin Pindah**

### Workaround: Menggunakan Junction/Symlink (Advanced)

```powershell
# Buat symbolic link tanpa spasi
New-Item -ItemType SymbolicLink `
         -Path "E:\Flutter_UAS" `
         -Target "E:\SEMESTER 7\Flutter\UAS"

# Masuk lewat symlink
cd "E:\Flutter_UAS\lms_celoe_app"

# Build
flutter clean
flutter pub get
flutter build apk
```

**⚠️ CATATAN**: Symlink memerlukan **administrator privileges** dan mungkin tidak 100% berhasil.

---

## 📊 **Perbandingan Path**

| Path Lama (ERROR) | Path Baru (FIXED) |
|-------------------|-------------------|
| `E:\SEMESTER 7\Flutter\UAS\lms_celoe_app` | `E:\Flutter_UAS\lms_celoe_app` ✅ |
| `E:\SEMESTER 7\Flutter\UAS\lms_celoe_app` | `E:\SEMESTER_7\Flutter\UAS\lms_celoe_app` ✅ |
| `E:\SEMESTER 7\Flutter\UAS\lms_celoe_app` | `E:\SEM7\Flutter\UAS\lms_celoe_app` ✅ |

---

## ✅ **Setelah Pindah**

1. **Buka VS Code di folder baru**:
   ```powershell
   code "E:\Flutter_UAS\lms_celoe_app"
   ```

2. **Update Git Remote** (jika pakai Git):
   ```bash
   git remote set-url origin https://github.com/siapaajaboleh888/UAS_Smart-UIM.git
   ```

3. **Hapus folder lama** (setelah yakin semua berjalan):
   ```powershell
   Remove-Item -Path "E:\SEMESTER 7\Flutter\UAS\lms_celoe_app" -Recurse -Force
   ```

---

## 🎯 **Recommended Path Structure**

```
E:\
├── Flutter_UAS\           ← Folder utama (tanpa spasi)
│   ├── lms_celoe_app\     ← Project Flutter
│   ├── database\          ← Database files
│   └── apk\               ← APK output
└── BACKUP_UAS\            ← Backup original
```

---

## 🚀 **Quick Command (Copy-Paste)**

```powershell
# === QUICK FIX (5 MENIT) ===

# 1. Buat folder baru
New-Item -Path "E:\Flutter_UAS" -ItemType Directory -Force

# 2. Copy project
Copy-Item -Path "E:\SEMESTER 7\Flutter\UAS\lms_celoe_app" `
          -Destination "E:\Flutter_UAS\lms_celoe_app" `
          -Recurse

# 3. Masuk & build
cd "E:\Flutter_UAS\lms_celoe_app"
flutter clean
flutter pub get
flutter build apk --debug

# 4. Buka di VS Code
code .
```

---

## 📞 **Support**

**Developer**: Moh. Syaiful Anam  
**NIM**: 2022020100078  
**Program Studi**: Teknik Informatika  
**Universitas**: Universitas Islam Madura

---

**Last Updated**: 16 Desember 2025, 05:47 WIB  
**Status**: ✅ Tested & Working
