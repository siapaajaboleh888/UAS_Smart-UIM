# Login Screen Redesign - Modern Style

## 🎯 Tujuan
Membuat login screen yang lebih modern dan menarik, terinspirasi dari tampilan profile screen.

## 🎨 Desain yang Akan Dibuat

### Konsep
1. **Header dengan Gambar Kampus** ✅ (Sudah ada)
   - Background: Gambar kampus UIM
   - Overlay gradient untuk readability
   - Logo dan text dengan shadow

2. **Form Login yang Lebih Modern**
   - Card dengan shadow dan border radius
   - Input fields dengan icon
   - Button dengan gradient
   - Email suggestions (quick select)

3. **Color Scheme**
   - Primary: Hijau UIM
   - Accent: Sesuai branding
   - Background: White dengan subtle gradient

## 📋 Status Implementasi

### ✅ Yang Sudah Ada
- [x] Background gambar kampus di header
- [x] Gradient overlay
- [x] Logo dan text dengan shadow
- [x] Quick select email (untuk user yang sudah terdaftar)
- [x] Email dan password input fields
- [x] Password visibility toggle
- [x] Tombol login dengan loading state
- [x] Tombol daftar akun baru
- [x] Help info card

### 🔄 Yang Perlu Di-Restart
**PENTING**: Perubahan gambar kampus belum terlihat karena perlu **HOT RESTART**

#### Cara Restart:
1. **Buka terminal** yang menjalankan `flutter run -d chrome`
2. **Tekan `R`** (huruf R besar/kapital) untuk hot restart
3. Tunggu aplikasi restart (5-10 detik)
4. Refresh browser jika perlu

#### Alternatif:
```powershell
# Stop aplikasi (tekan 'q' di terminal Flutter)
# Lalu jalankan ulang:
flutter run -d chrome
```

## 🖼️ Preview Fitur

### Header dengan Gambar Kampus
```
+----------------------------------+
|  [Gambar Kampus UIM]            |
|  (dengan gradient overlay)       |
|                                  |
|     [Logo Smart UIM]            |
|     Smart UIM                    |
|  Universitas Islam Madura       |
+----------------------------------+
```

### Quick Email Select
```
[user1@uim.ac.id] [user2@uim.ac.id] ...
```

### Form Login
```
Email: [________________]
Password: [________________] [👁️]

[      LOGIN      ]

atau

[  DAFTAR AKUN BARU  ]
```

## 🚀 Langkah Selanjutnya

1. **Restart Flutter App** untuk melihat gambar kampus
2. Jika tampilan masih belum sesuai, beri tahu saya
3. Saya bisa tambahkan animasi atau efek tambahan

## 💡 Tips
- Hot Reload (r): Untuk perubahan kode Dart
- Hot Restart (R): Untuk perubahan aset (gambar, dll)
- Full Restart: Stop (q) dan run ulang

---

**Updated**: 18 Desember 2025, 10:42 WIB  
**Developer**: Moh. Syaiful Anam (2022020100078)  
**Project**: Smart UIM - LMS Universitas Islam Madura
