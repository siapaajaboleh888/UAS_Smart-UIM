# 🧪 Test Script - Cara Test yang Benar

## ⚠️ PENTING: Urutan Test yang Benar

### **Step 0: Clear Browser Data Dulu**
**Sebelum test, clear localStorage browser:**
1. Buka **DevTools** (F12)
2. Klik tab **Console**
3. Ketik:
   ```javascript
   localStorage.clear()
   ```
4. Tekan Enter
5. **Refresh browser** (Ctrl+R)

---

### **Step 1: Registrasi User Baru**
1. Klik **"Daftar Akun Baru"**
2. Isi form dengan data ini:
   ```
   NIM: 2024777888999
   Nama: ANDI WIJAYA
   Prodi: Sistem Informasi
   Angkatan: 2024
   Email: andiwijaya@student.uim.ac.id
   Phone: 081234567890
   Password: test123
   ```
3. ✅ Centang "Syarat dan Ketentuan"
4. Klik **"Daftar Sekarang"**
5. Dialog "Registrasi Berhasil!" muncul

---

### **Step 2: Login dengan User Baru**
1. Di dialog sukses, klik **"Login Sekarang"**
2. Di form login, masukkan:
   ```
   Email: andiwijaya@student.uim.ac.id
   Password: (apa saja)
   ```
3. Klik **"Login"**
4. ⏳ Tunggu loading...
5. ✅ Masuk ke Home screen

---

### **Step 3: Cek Console Log**
Buka DevTools Console dan cari log seperti ini:
```
🔄 Reloading user data...
✅ Loaded 1 registered users
   - ANDI WIJAYA (2024777888999)
🔍 Looking for user with: andiwijaya@student.uim.ac.id
📊 Total registered users: 1
✅ Found matching user: ANDI WIJAYA
✅ Login successful: ANDI WIJAYA
```

---

### **Step 4: Lihat Home Screen**
**Di Home screen, seharusnya muncul:**
- Header: "Hallo, **ANDI WIJAYA**" (bukan MOH. SYAIFUL ANAM)
- Initials: **"AW"** (bukan "MS")

---

### **Step 5: Lihat Profile Screen**
1. Klik tab **"Profile"** di bottom navigation
2. **Seharusnya muncul:**
   - Avatar initials: **"AW"**
   - Nama: **"ANDI WIJAYA"**
   - Email: "andiwijaya@student.uim.ac.id"
   - NIM: "2024777888999"
   - Prodi: "Sistem Informasi"

---

### **Step 6: Test Persistent (Refresh Browser)**
1. Tekan **F5** atau **Ctrl+R**
2. Login lagi dengan email yang sama
3. Cek Home & Profile
4. ✅ **Data masih "ANDI WIJAYA"** (tidak balik ke MOH. SYAIFUL ANAM)

---

## 🐛 Jika Masih Muncul "MOH. SYAIFUL ANAM"

### **Debug Steps:**

1. **Cek Console Log:**
   - Buka DevTools Console
   - Lihat apakah ada error
   - Cari log "✅ Found matching user"
   
2. **Jika log mengatakan "User not found":**
   - Berarti data registrasi tidak tersimpan
   - Clear localStorage dan coba registrasi lagi

3. **Jika log mengatakan "Found matching user" tapi UI tidak update:**
   - Berarti masalah di ProfileScreen
   - Hot reload: Tekan **R** di terminal

4. **Clear semua dan test ulang:**
   ```javascript
   // Di Console
   localStorage.clear()
   location.reload()
   ```

---

## 📊 Expected vs Actual

| Screen | Expected | Jika Masih Error |
|--------|----------|------------------|
| **Home** | "Hallo, ANDI WIJAYA" | "Hallo, MOH. SYAIFUL ANAM" |
| **Avatar** | "AW" | "MS" |
| **Profile - Nama** | "ANDI WIJAYA" | "MOH. SYAIFUL ANAM" |
| **Profile - Email** | "andiwijaya@student.uim.ac.id" | "syaifulanam@uim.ac.id" |
| **Profile - NIM** | "2024777888999" | "2022020100078" |

---

## 🎯 Quick Test Commands

### Clear localStorage:
```javascript
localStorage.clear()
location.reload()
```

### Check saved data:
```javascript
console.log('Current User:', localStorage.getItem('current_user'))
console.log('Registered Users:', localStorage.getItem('registered_users'))
```

### Parse and view:
```javascript
const users = JSON.parse(localStorage.getItem('registered_users') || '[]')
console.table(users)
```

---

**Last Updated:** 16 Desember 2025, 06:48 WIB  
**Status:** Ready to test with debug logging
