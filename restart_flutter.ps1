# Script untuk restart Flutter application
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESTART FLUTTER APPLICATION" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "⏳ Menghentikan aplikasi Flutter yang sedang running..." -ForegroundColor Yellow

# Cari proses Flutter
$flutterProcesses = Get-Process | Where-Object { $_.ProcessName -like "*flutter*" }

if ($flutterProcesses) {
    Write-Host "✓ Ditemukan proses Flutter" -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 INSTRUKSI:" -ForegroundColor Cyan
    Write-Host "1. Pindah ke terminal yang menjalankan 'flutter run -d chrome'" -ForegroundColor White
    Write-Host "2. Tekan tombol 'q' untuk stop aplikasi" -ForegroundColor White
    Write-Host "3. Tunggu sampai proses berhenti" -ForegroundColor White
    Write-Host "4. Jalankan ulang: flutter run -d chrome" -ForegroundColor White
    Write-Host ""
    Write-Host "Atau coba HOT RESTART:" -ForegroundColor Yellow
    Write-Host "→ Tekan 'R' (huruf R besar) di terminal Flutter" -ForegroundColor Green
    Write-Host ""
}
else {
    Write-Host "❌ Tidak ada proses Flutter yang running" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Untuk menjalankan aplikasi:" -ForegroundColor Yellow
    Write-Host "   flutter run -d chrome" -ForegroundColor White
}

Write-Host "========================================" -ForegroundColor Cyan
