# ================================================
# Auto Import Database - Smart UIM LMS
# Script PowerShell untuk import database otomatis
# Author: Moh. Syaiful Anam (2022020100078)
# ================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Smart UIM LMS - Database Importer" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Konfigurasi
$MYSQL_HOST = "localhost"
$MYSQL_USER = "root"
$MYSQL_PASSWORD = ""  # Kosongkan jika tidak ada password
$DATABASE_NAME = "smart_uim"
$SQL_FILE_FULL = "database\smart_uim_schema.sql"
$SQL_FILE_QUICK = "database\quick_setup.sql"

# Fungsi untuk cek MySQL
function Test-MySQLConnection {
    try {
        $mysqlPath = Get-Command mysql -ErrorAction Stop
        Write-Host "[✓] MySQL CLI ditemukan: $($mysqlPath.Source)" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "[✗] MySQL CLI tidak ditemukan!" -ForegroundColor Red
        Write-Host "    Pastikan MySQL sudah terinstall dan ditambahkan ke PATH" -ForegroundColor Yellow
        Write-Host "    Atau gunakan: C:\xampp\mysql\bin\mysql.exe" -ForegroundColor Yellow
        return $false
    }
}

# Fungsi untuk import database
function Import-Database {
    param (
        [string]$SqlFile,
        [string]$DbName
    )
    
    Write-Host ""
    Write-Host "Mengimpor database dari: $SqlFile" -ForegroundColor Cyan
    
    if (-not (Test-Path $SqlFile)) {
        Write-Host "[✗] File SQL tidak ditemukan: $SqlFile" -ForegroundColor Red
        return $false
    }
    
    try {
        
        # Import menggunakan redirection
        Write-Host "[→] Menjalankan import..." -ForegroundColor Yellow
        
        if ($MYSQL_PASSWORD -eq "") {
            Get-Content $SqlFile | mysql -h $MYSQL_HOST -u $MYSQL_USER
        }
        else {
            Get-Content $SqlFile | mysql -h $MYSQL_HOST -u $MYSQL_USER -p"$MYSQL_PASSWORD"
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[✓] Database berhasil diimpor!" -ForegroundColor Green
            return $true
        }
        else {
            Write-Host "[✗] Gagal mengimpor database (Exit code: $LASTEXITCODE)" -ForegroundColor Red
            return $false
        }
        
    }
    catch {
        Write-Host "[✗] Error: $_" -ForegroundColor Red
        return $false
    }
}

# Fungsi untuk verifikasi database
function Test-Database {
    param ([string]$DbName)
    
    Write-Host ""
    Write-Host "Memverifikasi database..." -ForegroundColor Cyan
    
    try {
        $query = "USE $DbName; SELECT COUNT(*) AS total FROM users;"
        
        if ($MYSQL_PASSWORD -eq "") {
            $result = Write-Output $query | mysql -h $MYSQL_HOST -u $MYSQL_USER -s -N
        }
        else {
            $result = Write-Output $query | mysql -h $MYSQL_HOST -u $MYSQL_USER -p"$MYSQL_PASSWORD" -s -N
        }
        
        Write-Host "[✓] Database '$DbName' aktif dengan $result user(s)" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "[✗] Gagal memverifikasi database: $_" -ForegroundColor Red
        return $false
    }
}

# Main Script
Write-Host "1. Cek koneksi MySQL..." -ForegroundColor White
if (-not (Test-MySQLConnection)) {
    Write-Host ""
    Write-Host "Alternatif: Gunakan phpMyAdmin atau MySQL Workbench" -ForegroundColor Yellow
    Write-Host "  1. Buka http://localhost/phpmyadmin" -ForegroundColor Yellow
    Write-Host "  2. Import file: $SQL_FILE_FULL" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "2. Pilih mode import:" -ForegroundColor White
Write-Host "   [1] Full Schema (lengkap dengan sample data)" -ForegroundColor Cyan
Write-Host "   [2] Quick Setup (minimal data)" -ForegroundColor Cyan
Write-Host ""
$choice = Read-Host "Pilihan (1/2)"

$sqlFile = $SQL_FILE_FULL
if ($choice -eq "2") {
    $sqlFile = $SQL_FILE_QUICK
    Write-Host "[→] Mode: Quick Setup" -ForegroundColor Yellow
}
else {
    Write-Host "[→] Mode: Full Schema" -ForegroundColor Yellow
}

# Import database
if (Import-Database -SqlFile $sqlFile -DbName $DATABASE_NAME) {
    # Verifikasi
    Test-Database -DbName $DATABASE_NAME
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host " Import Selesai!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Informasi Login:" -ForegroundColor Cyan
    Write-Host "  Database: $DATABASE_NAME" -ForegroundColor White
    Write-Host "  Host: $MYSQL_HOST" -ForegroundColor White
    Write-Host ""
    Write-Host "Default Users:" -ForegroundColor Cyan
    Write-Host "  Admin    : admin / password" -ForegroundColor White
    Write-Host "  Dosen    : dosen1 / password" -ForegroundColor White
    Write-Host "  Mahasiswa: 2022020100078 / password" -ForegroundColor White
    Write-Host ""
    Write-Host "Lihat PANDUAN_DATABASE.md untuk detail lebih lanjut" -ForegroundColor Yellow
}
else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host " Import Gagal!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  1. Pastikan MySQL service running (XAMPP)" -ForegroundColor White
    Write-Host "  2. Cek username dan password MySQL" -ForegroundColor White
    Write-Host "  3. Ganti MYSQL_PASSWORD di script ini jika perlu" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Read-Host "Tekan Enter untuk keluar"
